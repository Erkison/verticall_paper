# Software used

* fastp v0.23.2
* Snippy v4.6.0
  * Freebayes v1.3.6
  * Samtools/Bcftools v1.16
  * BWA v0.7.17
* [IQ-TREE](https://github.com/iqtree/iqtree2) v2.3.6
* [MinVar-Rooting](https://github.com/uym2/MinVar-Rooting) v1.5



# Paths

Choose based on dataset:
```bash
base_dir=/projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1; ram=64000; time=0-6:00:00; name=S_pneumo_PMEN1
base_dir=/projects/js66/individuals/ryan/Verticall_paper/S_enterica_Typhi_431;  ram=256000; time=4-0:00:00; name=S_enterica_Typhi_431
base_dir=/projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS;  ram=128000; time=0-12:00:00; name=E_coli_GEMS
base_dir=/projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred;  ram=196000; time=1-0:00:00; name=Klebsiella_Alfred
```

```bash
ref="$base_dir"/Reference.fasta
samples=$(ls "$base_dir"/assemblies | grep -oP "SAM[EAN]+\d+")
```



# Run Snippy on each sample

```bash
mkdir "$base_dir"/snippy
for s in $(echo $samples); do
    r1="$base_dir"/reads/"$s"_1.fastq.gz
    r2="$base_dir"/reads/"$s"_2.fastq.gz
    cd "$base_dir"/snippy
    mkdir "$s"; cd "$s"
    sbatch --job-name=snippy_"$s" --time=0-4:00:00 --partition=genomics --qos=genomics --ntasks=1 --mem=128000 --cpus-per-task=8 --account kr58 --wrap "module load miniconda3/4.1.11-python3.5; source activate snippy; fastp --in1 "$r1" --in2 "$r2" --out1 illumina_1.fastq.gz --out2 illumina_2.fastq.gz; snippy --outdir . --R1 illumina_1.fastq.gz --R2 illumina_2.fastq.gz --ref "$ref" --cpus 8 --force --cleanup; rm illumina_*.fastq.gz"
done
```




# Combine Snippy results

```bash
cd "$base_dir"/snippy
sbatch --job-name=snippy_merge --time=0-4:00:00 --partition=genomics --qos=genomics --ntasks=1 --mem=128000 --cpus-per-task=8 --account md52 --wrap "module load miniconda3/4.1.11-python3.5; source activate snippy; snippy-core --ref "$ref" SAM*; snippy-clean_full_aln core.full.aln | seqtk seq > "$base_dir"/alignments/snippy.fasta"
```

Remove reference from alignment and compress:
```bash
cd "$base_dir"/alignments
tail -n+3 snippy.fasta > temp; mv temp snippy.fasta
pigz -p4 snippy.fasta
```

Get alignment stats:
```bash
cd "$base_dir"/snippy
cat slurm-*.out | grep "SAM" | cut -f2-7 | perl -pe 's/\w+=//g'
```

Clean up:
```bash
cd "$base_dir"/snippy
rm core.full.aln
```



# QC samples on het calls

For each dataset, I removed samples that had too many het calls, defined as >0.5% of the reference size:
* S_pneumo_PMEN1: >11107 (1 sample failed)
* S_enterica_Typhi_431: >24045 (11 samples failed)
* E_coli_GEMS: >27247 (3 samples failed)
* Klebsiella_Alfred: >26316 (15 samples failed)

```bash
mkdir /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/snippy/qc_fail
for s in SAMEA677475; do
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/snippy
    mv "$s" qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads
    mv "$s"_*.fastq.gz qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies_working_files
    mv "$s" qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
    rm "$s".fasta.gz
done

mkdir /projects/js66/individuals/ryan/Verticall_paper/S_enterica_Typhi_431/snippy/qc_fail
for s in SAMN03465830 SAMEA4759360 SAMN09210161 SAMEA7882642 SAMEA3276572 SAMEA3276227 SAMEA3558976 SAMEA4759568 SAMEA3558975 SAMEA3558985 SAMEA7456535; do
    cd /projects/js66/individuals/ryan/Verticall_paper/S_enterica_Typhi_431/snippy
    mv "$s" qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/S_enterica_Typhi_431/reads
    mv "$s"_*.fastq.gz qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/S_enterica_Typhi_431/assemblies_working_files
    mv "$s" qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/S_enterica_Typhi_431/assemblies
    rm "$s".fasta.gz
done

mkdir /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/snippy/qc_fail
for s in SAMEA1527972 SAMEA1466185 SAMEA1466189; do
    cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/snippy
    mv "$s" qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/reads
    mv "$s"_*.fastq.gz qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies_working_files
    mv "$s" qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies
    rm "$s".fasta.gz
done

mkdir /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/snippy/qc_fail
for s in SAMEA3357093 SAMEA3357128 SAMEA3357544 SAMEA3357356 SAMEA3356985 SAMEA3357409 SAMEA3357283 SAMEA3357207 SAMEA3357061 SAMEA3356953 SAMN06112228 SAMEA3357020 SAMEA3357261 SAMEA3356965 SAMEA3357216; do
    cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/snippy
    mv "$s" qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/reads
    mv "$s"_*.fastq.gz qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies_working_files
    mv "$s" qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies
    rm "$s".fasta.gz
done
```

I then have to remake the Snippy alignment:
```bash
cd "$base_dir"/snippy
sbatch --job-name=snippy_merge --time=0-4:00:00 --partition=genomics --qos=genomics --ntasks=1 --mem=128000 --cpus-per-task=8 --account md52 --wrap "module load miniconda3/4.1.11-python3.5; source activate snippy; snippy-core --ref "$ref" SAM*; snippy-clean_full_aln core.full.aln | seqtk seq > "$base_dir"/alignments/snippy.fasta"
```

Remove reference from alignment and compress:
```bash
cd "$base_dir"/alignments
tail -n+3 snippy.fasta > temp; mv temp snippy.fasta
pigz -p4 snippy.fasta
```

Clean up:
```bash
cd "$base_dir"/snippy
rm core.full.aln
```



# Get core sites

The core SNP percentage threshold is an interesting question. I.e. what fraction of the sequences must be present (not `-` or `N`) at a site for that site to be included? `snippy-core` produces two output files: `core.aln` which uses a 100% threshold (i.e. any site with a missing value is removed) and `core.full.aln` which uses a 0% threshold (i.e. all sites are included). RedDog uses [a 95% threshold](https://github.com/katholt/RedDog/blob/master/RedDog_config.py#L296) for its pipeline.

I made [Core-SNP-filter](https://github.com/rrwick/Core-SNP-filter) to remove invariant sites and non-core sites:
```bash
cd "$base_dir"/alignments
coresnpfilter -e -c 0.95 snippy.fasta.gz | pigz -p4 > snippy_core.fasta.gz
```

Non-core positions removed from each pseudo-alignment:

| Dataset              | Input len |  inv-A  |  inv-C  |  inv-G  |  inv-T  | inv-other | Non-core | Output len |
----------------------------------------------------------------------------------------------------------------
| S_pneumo_PMEN1       |   2221315 |  641977 |  415484 |  412401 |  642017 |     85310 |     1737 |      22389 |
| S_enterica_Typhi_431 |   4809037 | 1126610 | 1219151 | 1224294 | 1129155 |     98577 |      881 |      10369 |
| E_coli_GEMS          |   5449314 | 1165454 | 1159941 | 1150946 | 1165643 |    421845 |   105251 |     280234 |
| Klebsiella_Alfred    |   5263229 |  908576 | 1064982 | 1076222 |  908388 |     75422 |   697243 |     532396 |



# Build a tree

```bash
base_dir=/home/wickr/Verticall_paper/S_pneumo_PMEN1
base_dir=/home/wickr/Verticall_paper/S_enterica_Typhi_431
base_dir=/home/wickr/Verticall_paper/E_coli_GEMS
base_dir=/home/wickr/Verticall_paper/Klebsiella_Alfred
```

Run IQ-TREE:
```bash
mkdir "$base_dir"/trees
mkdir "$base_dir"/trees/snippy_iqtree
cd "$base_dir"/trees/snippy_iqtree

/usr/bin/time -v -o snippy_iqtree.time iqtree2 -s ../../alignments/snippy_core.fasta.gz \
    -T 32 --prefix snippy_iqtree
```

IQ-TREE resources used:

| Dataset              |   Time    | RAM (kB) |      Status       |
------------------------------------------------------------------|
| S_pneumo_PMEN1       |   0:09:02 |   215868 | finished          |
| S_enterica_Typhi_431 |   7:31:32 |  6634776 | finished          |
| E_coli_GEMS          |   5:59:40 |  9149452 | finished          |
| Klebsiella_Alfred    | 136:29:56 | 72492672 | finished          |

I gave each command one week to run, and if it wasn't done then, I killed it.


Minimum-variance rooting:
```bash
cd "$base_dir"/trees
python3 FastRoot.py -i snippy_iqtree/snippy_iqtree.treefile > snippy_iqtree.newick
```
