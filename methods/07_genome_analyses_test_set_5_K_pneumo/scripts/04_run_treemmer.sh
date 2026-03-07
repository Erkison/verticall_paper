#!/bin/bash


# load R module and snp-dists
module load R
module load snp-dists
TREEMMER_TOOL_DIR=~/erkison/seroepi/scripts/Treemmer # Treemmer installation location

# Args
CLONE_DIR=$1 
CLONE_DIR=$(realpath $CLONE_DIR)

CLONE=$(basename $CLONE_DIR)

TREEMMER_DIR=${CLONE_DIR}/treemmer
TREEMMER_META_INFO=${TREEMMER_DIR}/${CLONE}_treemer_meta_info.csv

REDDOG_DIR=${CLONE_DIR}/reddog
REDDOG_ALIGNMENT=${REDDOG_DIR}/${CLONE}_whole_genome_alignment.fasta

echo -e "\nSubmitting treemmer job for $CLONE"
cd $TREEMMER_DIR


# Remove invariant sites from alignment
echo -e "\nRemoving invariant sites"
REDDOG_DIR=$(dirname $REDDOG_ALIGNMENT)
python3 ../../scripts/bin/exclude_invariant.py $REDDOG_ALIGNMENT > ${REDDOG_DIR}/${CLONE}_variants_only_alignment.fasta
INPUT_ALN=${REDDOG_DIR}/${CLONE}_variants_only_alignment.fasta

# Get snp distance matrix
TREEMMER_DIR=$(dirname $TREEMMER_META_INFO)
snp-dists $INPUT_ALN > ${TREEMMER_DIR}/${CLONE}_snpdist.tsv
Rscript ../../scripts/bin/snpdist_to_phylip.R ${TREEMMER_DIR}/${CLONE}_snpdist.tsv ${TREEMMER_DIR}/${CLONE}_snpdist.phylip

INPUT_DIST=${TREEMMER_DIR}/${CLONE}_snpdist.phylip


# Run fastme
fastme --method B --nni B --spr -i ${INPUT_DIST} -o ${CLONE}.nwk -I ${CLONE}_fastme.info

# Run treemmer (downsample to 200 genomes but keep at least one taxon with unique combinations of K/O loci, country and year
python3 ${TREEMMER_TOOL_DIR}/Treemmer_v0.3.py ${CLONE}.nwk -X 200 -lm ${TREEMMER_META_INFO} -mc 1
echo "" >> ${CLONE}.nwk_trimmed_list_X_200 

# Get new alignment containing kept samples
python3 ../../scripts/bin/extract_fasta_by_headers.py ${REDDOG_ALIGNMENT} \
    ${CLONE}.nwk_trimmed_list_X_200 ${CLONE}_downsampled_whole_genome_alignment.fasta


cd -
