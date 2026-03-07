#!/bin/bash


# Arguments
CLONE_DIR=$1 		# e.g., SL_1

CLONE_DIR=$(realpath $CLONE_DIR)
CLONE=$(basename $CLONE_DIR)

mkdir -p ${CLONE_DIR}/bakta

cd $CLONE_DIR

bakta --db /opt/anaconda/anaconda3/envs/bakta_v181_env/lib/python3.10/site-packages/bakta/db/db \
      --complete --threads 4 \
      --prefix ${CLONE} --output bakta/${CLONE}_bakta -v reference/${CLONE}_reference.fas
      
cp bakta/${CLONE}_bakta/*.gbff reference/

cd -