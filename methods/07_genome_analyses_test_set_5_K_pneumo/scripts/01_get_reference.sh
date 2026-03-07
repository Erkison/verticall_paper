#!/bin/bash

module load mash/2.1

# Args
CLONE_DIR=$1
CLONE_DIR=$(realpath $CLONE_DIR)

cd ${CLONE_DIR}

mkdir -p ${CLONE_DIR}/bactinspector
CLONE=$(basename $CLONE_DIR)
INPUT_DIR=${CLONE_DIR}/reads
INPUT_FORMAT="*.fastq.gz"

bactinspector closest_match -i $INPUT_DIR \
    -fq "$INPUT_FORMAT" -o ${CLONE_DIR}/bactinspector

if [ $? -eq 0 ]; then
  # download closest match   
  ftp_path=$(sed -n '2p' ${CLONE_DIR}/bactinspector/closest_matches_*.tsv | grep -o 'ftp\:\//.*\.gz') && wget $ftp_path
  reference_name=$(basename $ftp_path)
  gunzip $reference_name
  reference_name=${reference_name%%.gz}

  # get chromosome
  awk "/^>/ {n++} n>1 {exit} {print}" $reference_name > ${CLONE}_reference.fas
  mkdir -p ${CLONE_DIR}/reference
  mv ${CLONE}_reference.fas ${CLONE_DIR}/reference

  rm -f $reference_name
fi

cd -
