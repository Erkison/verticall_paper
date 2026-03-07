#!/bin/bash

conda activate gubbinsv3_4
module load seqtk/1.3

# Args
CLONE_DIR=$1
RESUME=$2 # optional intermediate tree from terminated run; e.g., 'SL_65_whole_genome_alignment.iteration_3.tre'

CLONE_DIR=$(realpath $CLONE_DIR)
CLONE=$(basename $CLONE_DIR)
OUTPUT_DIR=${CLONE_DIR}/gubbins
INPUT_ALN=${CLONE_DIR}/reddog/${CLONE}_whole_genome_alignment.fasta

mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}

# Run Gubbins
/usr/bin/time -v -o gubbins.time run_gubbins.py ${INPUT_ALN} --prefix gubbins \
    --threads $THREADS --filter-percentage 100 > gubbins.out


# Make a Gubbins alignment
mask_gubbins_aln.py --aln ${INPUT_ALN} --gff ${OUTPUT_DIR}/gubbins.recombination_predictions.gff \
    --out ${OUTPUT_DIR}/gubbins_masked_aln.fasta
seqtk seq gubbins_masked_aln.fasta > temp.fasta; mv temp.fasta gubbins_masked_aln.fasta
pigz -p4 gubbins_masked_aln.fasta
coresnpfilter -e -c 0.95 gubbins_masked_aln.fasta.gz | pigz -p4 > gubbins_masked_aln_core.fasta.gz


# Build a tree
/usr/bin/time -v -o gubbins_iqtree.time iqtree2 \
    -s gubbins_masked_aln_core.fasta.gz \
    -T $THREADS --prefix gubbins_iqtree


# Root tree
conda activate fastroot
python3 FastRoot.py -i gubbins_iqtree.treefile > gubbins_iqtree.newick



cd -
