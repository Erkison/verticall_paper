#!/bin/bash

module load minimap2/2.1.8

# Arguments
CLONE_DIR=$1 		# e.g., SL_1
DOWNSAMPLED_LIST=$2	# Optional. e.g., SL_1/treemmer/SL_1.nwk_trimmed_list_X_200

if [[ "$DOWNSAMPLED_LIST" != "" ]] && [[ -f $DOWNSAMPLED_LIST ]]; then 
    DOWNSAMPLED_LIST=$(realpath $DOWNSAMPLED_LIST); 
elif [[ "$DOWNSAMPLED_LIST" != "" ]] && [[ ! -f $DOWNSAMPLED_LIST ]]; then
    echo "$DOWNSAMPLED_LIST file not found"; exit 1
fi


######################
# Set up
###################

CLONE_DIR=$(realpath $CLONE_DIR)
CLONE=$(basename ${CLONE_DIR})
OUTPUT_DIR=${CLONE_DIR}/verticall
REDDOG_DIR=${CLONE_DIR}/reddog
REDDOG_VARIANTS_CSV_FILE=$(ls ${REDDOG_DIR}/${CLONE}_*_alleles_cons0.95_*strains_var.csv)

mkdir -p $OUTPUT_DIR/iqtree
cd $CLONE_DIR


##########################
# Input assemblies
##########################
INPUT_ASSEMBLIES_DIR=${CLONE_DIR}/assemblies 
mkdir -p ${OUTPUT_DIR}/temp_assemblies
# get list of read ids that passed reddog mapping filters
rm -f ${CLONE_DIR}/passed_ids.txt
column_names=$(awk -F',' 'NR==1 {print $0}' "$REDDOG_VARIANTS_CSV_FILE")
MY_IFS=$IFS;  IFS=', '; read -r -a column_array <<< "$column_names"
for ((i = 1; i < ${#column_array[@]}; i++)); do
  name="${column_array[i]}"
  echo "$name" >> ${CLONE_DIR}/passed_ids.txt
done
IFS=$MY_IFS 

# Link assemblies
# some read ids different from assembly ids. both are matched in ${CLONE_DIR}/${CLONE}_data.tsv (columns 2 and 3)
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

##########################
# reference genomes fastas and annotations
##########################
REF_GENOMES_DIR=$CLONE_DIR/reference
REFERENCE_FAS=$(ls ${REF_GENOMES_DIR}/chr_fastas/${CLONE}_*_reference.fas | grep -v "${CLONE}_and*")
cp $REFERENCE_FAS ${OUTPUT_DIR}/Reference.fasta
REFERENCE_FAS=${OUTPUT_DIR}/Reference.fasta


##########################
# Reddog alignment file
##########################
# create alignment for verticall (reference sequence must be included)
# Add 'Reference' to list of passed ids generated. Reddog reports the reference ID as 'Reference' in the snp table
echo "Reference" >> ${CLONE_DIR}/passed_ids.txt
# Generate an alignment file from the snp table that includes both the reference and the passed ids
~/js66/software/conda_envs/reddog-nf/bin/python ../scripts/bin/parseSNPtable3.py \
    -s ${REDDOG_DIR}/*_alleles_cons0.95.csv \
    -l ${CLONE_DIR}/passed_ids.txt \
    -m aln -d ${OUTPUT_DIR}
# Add invariant sites to the alignment
~/js66/software/conda_envs/reddog-nf/bin/python ../scripts/bin/snpTable2GenomeAlignment.py \
    --ref $REFERENCE_FAS --snps ${OUTPUT_DIR}/*_alleles_cons0.95_*strains_var.csv > ${OUTPUT_DIR}/${CLONE}_alignment_with_ref.fasta
INPUT_ALIGNMENT=${OUTPUT_DIR}/${CLONE}_alignment_with_ref.fasta
# Subsample alignment if downsample list provided
if [[ "$DOWNSAMPLED_LIST" != "" ]]; then
  echo "Reference" >> $DOWNSAMPLED_LIST
  
  ~/miniconda/bin/python3 ../scripts/bin/extract_fasta_by_headers.py $INPUT_ALIGNMENT \
      $DOWNSAMPLED_LIST ${OUTPUT_DIR}/${CLONE}_downsampled_alignment_with_ref.fasta
  mv ${OUTPUT_DIR}/${CLONE}_downsampled_alignment_with_ref.fasta $INPUT_ALIGNMENT
fi

##########################
# Run Verticall
##########################
conda activate verticall
cd $OUTPUT_DIR

verticall pairwise -i ${FINAL_ASSEMBLIES_DIR} -o verticall.tsv -r ${REFERENCE_FAS} -T 32

verticall mask -i verticall.tsv -a ${INPUT_ALIGNMENT} \
    -o masked_alignment_variants_only.fasta --exclude_invariant

cd $OUTPUT_DIR/iqtree
conda activate gubbinsv3_4
iqtree2 -s ../masked_alignment_variants_only.fasta -T 32 --prefix ${CLONE}_iqtree

conda activate fastroot
python3 FastRoot.py -i ${CLONE}_iqtree.treefile > ${CLONE}_iqtree.newick


