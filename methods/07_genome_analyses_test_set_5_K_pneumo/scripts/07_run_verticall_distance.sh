#!/bin/bash

module load minimap2/2.1.8

###################
# Arguments
###################
CLONE_DIR=$1 		# e.g., SL_1
DOWNSAMPLED_LIST=$2     # e.g., SL_1/treemmer/SL_1.nwk_trimmed_list_X_200

if [[ "$DOWNSAMPLED_LIST" != "" ]] && [[ -f $DOWNSAMPLED_LIST ]]; then
  DOWNSAMPLED_LIST=$(realpath $DOWNSAMPLED_LIST)
elif [[ "$DOWNSAMPLED_LIST" != "" ]] && [[ ! -f $DOWNSAMPLED_LIST ]]; then
  echo "$DOWNSAMPLED_LIST file not found"
  exit 1
fi 

######################
# Set up
###################

CLONE_DIR=$(realpath $CLONE_DIR)
CLONE=$(basename ${CLONE_DIR})
OUTPUT_DIR=${CLONE_DIR}/verticall_dist
REDDOG_DIR=${CLONE_DIR}/reddog
REDDOG_VARIANTS_CSV_FILE=$(ls ${REDDOG_DIR}/${CLONE}_*_alleles_cons0.95_*strains_var.csv)

cd $CLONE_DIR
mkdir -p $OUTPUT_DIR


##########################
# Input assemblies
##########################
INPUT_ASSEMBLIES_DIR=${CLONE_DIR}/assemblies 
mkdir -p ${OUTPUT_DIR}/temp_assemblies

# get list of read ids that passed reddog alignment
rm -f ${CLONE_DIR}/passed_ids.txt
# first get the ids from the col names of the final reddog variants csv file
column_names=$(awk -F',' 'NR==1 {print $0}' "$REDDOG_VARIANTS_CSV_FILE")
MY_IFS=$IFS 
IFS=', ' read -r -a column_array <<< "$column_names"
for ((i = 1; i < ${#column_array[@]}; i++)); do
  name="${column_array[i]}"
  echo "$name" >> ${CLONE_DIR}/passed_ids.txt
done
IFS=$MY_IFS # restore IFS

# read ids may be different from assembly ids. both are matched in ${CLONE_DIR}/${CLONE}_data.tsv (columns 2 and 3)
# for each passed read id, get the corresponding assembly id and link the files to the temp assembly dir; save assembly files with read id
for id in $(cat ${CLONE_DIR}/passed_ids.txt); do
  assembly_id=$( grep -w "$id" ${CLONE_DIR}/${CLONE}_data.tsv | cut -f3 )
  if [[ "$assembly_id" == "" ]]; then
    echo "ERROR: No assembly id found for read id $id in ${CLONE_DIR}/${CLONE}_data.tsv"
    exit 1
  elif [[ "$DOWNSAMPLED_LIST" != "" ]] && ! grep -wq "$id" $DOWNSAMPLED_LIST ; then
    continue
  else
    ln -s -f ${INPUT_ASSEMBLIES_DIR}/${assembly_id}.fasta ${OUTPUT_DIR}/temp_assemblies/${id}.fasta
  fi
done
FINAL_ASSEMBLIES_DIR=${OUTPUT_DIR}/temp_assemblies/


# Run Verticall
conda activate verticall
cd $OUTPUT_DIR

verticall pairwise -i ${FINAL_ASSEMBLIES_DIR} -o verticall.tsv -T 32 

verticall matrix -i verticall.tsv -o verticall.phylip

fastme --method B --nni B --spr -i verticall.phylip -o verticall.newick


