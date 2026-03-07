#!/bin/bash

NEXTFLOW_PIPELINE_DIR=~/erkison/klebs_dataset/scripts/reddog-nf


module load nextflow/21.10.6

# Arguments
CLONE_DIR=$1 		# e.g., SL_1
RedDog_NF_args=$2 	# e.g., "--force"

CLONE_DIR=$(realpath $CLONE_DIR)

cd $CLONE_DIR

# Vars
CLONE=$(basename ${CLONE_DIR})
INPUT_READS_DIR=${CLONE_DIR}/reads
READS_PATTERN=*{R,_}{1,2}.fastq.gz
INPUT_FILES=${INPUT_READS_DIR}/${READS_PATTERN}
OUTPUT_DIR=${CLONE_DIR}/reddog

# reference genomes fastas and annotations
REF_GENOMES_DIR=$CLONE_DIR/reference
REFERENCE_GBK=$(ls ${REF_GENOMES_DIR}/${CLONE}_*reference.gbff | grep -v "${CLONE}_and*")
REFERENCE_FAS=$(ls ${REF_GENOMES_DIR}/${CLONE}_*reference.fas | grep -v "${CLONE}_and*")

mkdir -p $OUTPUT_DIR

# get list of sample IDs
rm -f ${CLONE_DIR}/read_ids.txt
for each in $(ls ${INPUT_READS_DIR}/*_1.fastq.gz); do fn=$(basename $each _1.fastq.gz); echo $fn >> ${CLONE_DIR}/read_ids.txt; done


############################################
# Run reddog pipeline
nextflow run ${NEXTFLOW_PIPELINE_DIR}/reddog.nf \
        --reads "${INPUT_FILES}" \
        --output_dir $OUTPUT_DIR \
	    --reference ${REFERENCE_GBK} \
        -resume -w ${CLONE_DIR}/work \
	    "${RedDog_NF_args}" \
        -profile massive

cd -


############################################
# Uncomment and run lines below in $CLONE_DIR AFTER nextflow run finishes

# # Remove the "Ref" entry as the reference genome is also included in the alignment - the read_ids.txt includes all genomes that were input to RedDog
# # Add invariable sites to alignment for running Gubbins - for this you need the fasta file of the chromosomal reference
# python ../scripts/bin/parseSNPtable3.py \
#     -s ${OUTPUT_DIR}/*_alleles_cons0.95.csv \
#     -l ${CLONE_DIR}/read_ids.txt \
#     -m aln -d ${OUTPUT_DIR}
# 
# python ../scripts/bin/snpTable2GenomeAlignment.py \
#     --ref $REFERENCE_FAS --snps ${OUTPUT_DIR}/*_alleles_cons0.95_*strains_var.csv > ${OUTPUT_DIR}/${CLONE}_whole_genome_alignment.fasta 
# 
# rm -f ${CLONE_DIR}/read_ids.txt
