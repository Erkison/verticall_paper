#!/bin/bash

# Use SimBac to simulate recombination data to test impact of divergence on Verticall performance
# Mutation rates are varied across the four generated datasets
# Recombination rates kept constant
# https://github.com/tbrown91/SimBac)
# https://pmc.ncbi.nlm.nih.gov/articles/PMC5049688/

recomb_rate=0.0001 

data_dir=sim_dataset_${recomb_rate}

mkdir -p $data_dir && cd $data_dir

for rate in 0.0001 0.001 0.01 0.1; do
  echo -e "\nSimulating alignment with mutation rate: ${rate}"
  outdir=mut_rate_${rate}
  mkdir -p $outdir
  cd $outdir

  sbatch --job-name="simbac_R${recomb_rate}_${rate}" --time=3-00:00:00 --partition='comp' \
    --ntasks=1 --mem=384000 --cpus-per-task=4 --account=js66 \
    --wrap "SimBac -N 30 -B 3000000 -R $recomb_rate -T $rate -s 20260909 -c clonal.nwk -o alignment.fasta -b recs_i.txt -g recs.txt"

  cd $data_dir
done