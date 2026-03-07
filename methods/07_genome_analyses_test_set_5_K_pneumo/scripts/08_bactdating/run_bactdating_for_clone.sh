#!/bin/bash

###########################
# Example usage
# bash run_bactdating_for_clone.sh SL_10 gubbins test 100000 3 tree
###########################


# Vars
clone=$1
tree_source=$2 	# One of 'gubbins', 'verticall', or 'verticall_dist'
run=$3		# One of 'test' or 'main'
iterations=$4
seed=$5
tree_for_bactdate=$6 # One of 'tree', 'rooted_tree', or 'rooted_tree_rec'
n_alignment_sites=$7
best_model=$8		# One of 'relaxedgamma' or 'mixedgamma'
run_mode=$9 # One of 'full', 'resume'
na_year=${10} # One of 'include', 'exclude'


bactdating_dir=~/erkison/klebs_dataset/bactdating
templates_dir=${bactdating_dir}/scripts/templates
template_rmd_file=${templates_dir}/bactdating_${run}_run_${tree_source}.Rmd
output_dir=${bactdating_dir}/${clone}/with_${tree_source}
r_script_for_bactdate=${bactdating_dir}/scripts/knit_bactdating_rmd.R

# check clone dir exists
clone_dir=$(dirname $bactdating_dir)/$clone
if [[ ! -d $clone_dir ]]; then
  echo "$clone_dir does not exist"
  exit 1
fi

# Check vars for template to use
if [[ ! "$tree_source" =~ ^(gubbins|verticall|verticall_dist)$ ]]; then
  echo -e "Second argument (run) must be one of 'gubbins', 'verticall' or 'verticall_dist'"
  exit 1
fi
if [[ ! "$run" =~ ^(test|main)$ ]]; then
  echo -e "Third argument (run) must be one of 'test' or 'main'"
  exit 1
fi

# check n_alignment_sites provided if tree_source == verticall
if [[ "$tree_source" == "verticall" ]]; then
  case $n_alignment_sites in
   *[^0-9]*) echo "n_alignment_sites (7th arg) must be a number"; exit 1
   ;;
   '')         echo "Must provide number of alignment sites (7th arg) with verticall option"; exit 1
   ;;
  esac
fi

# check best_model provided for 'main' run 
if [[ "$run" == "main" && "$best_model" == "" ]]; then
  echo -e "Must provide best model (8th arg) with main run"
  echo -e "Options are 'relaxedgamma' and 'mixedgamma'"
  exit 1
elif [[ "$run" == "main" && ! "$best_model" =~ ^(relaxedgamma|mixedgamma)$ ]]; then
  echo -e "best_model (8th arg) must be one of 'relaxedgamma' or 'mixedgamma'"
  exit 1
fi


# Add optional args
if [[ "$best_model" != "" ]]; then
  best_model_option="-b $best_model"
fi
if [[ "$n_alignment_sites" != "" ]]; then
  n_alignment_sites_option="-n $n_alignment_sites"
fi

if [[ ! "$run_mode" == "" && ! "$run_mode" =~ ^(full|resume)$ ]]; then
  echo -e "Run mode (9th arg) must be an empty string or one of 'full' or 'resume'"
  exit 1
elif [[ "$run_mode" != "" ]]; then
  run_mode_option="-r $run_mode"
fi

if [[ ! "$na_year" == "" && ! "$na_year" =~ ^(include|exclude)$ ]]; then
  echo -e "na_year (10th arg) must be an empty string or one of 'include' or 'exclude'"
  exit 1
elif [[ "$na_year" != "" ]]; then
  na_year_option="-y $na_year"
fi

# Run
mkdir -p $output_dir
cd $output_dir
Rscript --no-save --no-restore --no-site-file --no-init-file \
    $r_script_for_bactdate \
    -c $clone -o $output_dir -m $template_rmd_file \
    -i $iterations $best_model_option $n_alignment_sites_option \
    $run_mode_option $na_year_option \
    -s $seed -t $tree_for_bactdate

