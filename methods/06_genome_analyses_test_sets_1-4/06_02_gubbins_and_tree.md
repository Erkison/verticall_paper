I ran Gubbins on Marvin/Trillian/Zaphod for consistency.



# Software used

* [Gubbins](https://github.com/nickjcroucher/gubbins) v3.4
* [IQ-TREE](https://github.com/iqtree/iqtree2) v2.3.6
* [Seqtk](https://github.com/lh3/seqtk) v1.3
* [MinVar-Rooting](https://github.com/uym2/MinVar-Rooting) v1.5


```bash
conda activate gubbinsv3_4
module load seqtk/1.3
```



# Paths

Choose based on dataset:
```bash
base_dir=/home/wickr/Verticall_paper/S_pneumo_PMEN1
base_dir=/home/wickr/Verticall_paper/S_enterica_Typhi_431
base_dir=/home/wickr/Verticall_paper/E_coli_GEMS
base_dir=/home/wickr/Verticall_paper/Klebsiella_Alfred
```



# Run Gubbins

I ran Gubbins with `--filter-percentage 100` to ensure that all samples were included (i.e. turning off input alignment filtering).

I also had to add `sys.setrecursionlimit(10000)` to `run_gubbins.py` to prevent a `RecursionError` crash.

```bash
gunzip "$base_dir"/alignments/snippy.fasta.gz

mkdir "$base_dir"/gubbins
cd "$base_dir"/gubbins

/usr/bin/time -v -o gubbins.time run_gubbins.py ../alignments/snippy.fasta --prefix gubbins --threads 32 --filter-percentage 100 > gubbins.out
```

Gubbins resources used:

| Dataset              |   Time    | RAM (kB) | Status          |
----------------------------------------------------------------|
| S_pneumo_PMEN1       |   0:05:41 |   743388 | finished        |
| S_enterica_Typhi_431 |  69:43:46 | 77051648 | finished        |
| E_coli_GEMS          |   1:30:55 |  5417836 | finished        |
| Klebsiella_Alfred    |           |          | ran out of time |

```R
round( c(743388, 77051648, 5417836) / (1024*1024), 1) # convert to GB
```

# Make a Gubbins alignment

```bash
cd "$base_dir"/alignments
mask_gubbins_aln.py --aln snippy.fasta --gff ../gubbins/gubbins.recombination_predictions.gff --out snippy_gubbins.fasta
seqtk seq snippy_gubbins.fasta > temp.fasta; mv temp.fasta snippy_gubbins.fasta
pigz -p4 snippy_gubbins.fasta
coresnpfilter -e -c 0.95 snippy_gubbins.fasta.gz | pigz -p4 > snippy_gubbins_core.fasta.gz
```



# Build a tree

```bash
mkdir "$base_dir"/trees/snippy_gubbins_iqtree
cd "$base_dir"/trees/snippy_gubbins_iqtree

/usr/bin/time -v -o snippy_gubbins_iqtree.time iqtree2 -s ../../alignments/snippy_gubbins_core.fasta.gz -T 32 --prefix snippy_gubbins_iqtree
```

IQ-TREE resources used:

| Dataset              |   Time   | RAM (kB) |      Status      |
----------------------------------------------------------------|
| S_pneumo_PMEN1       |  0:06:27 |    99868 | finished         |
| S_enterica_Typhi_431 |  8:58:50 |  6261920 | finished         |
| E_coli_GEMS          |  0:16:49 |   935252 | finished         |
| Klebsiella_Alfred    |          |          | unable to start  |


```bash
cd "$base_dir"/trees
python3 FastRoot.py -i snippy_gubbins_iqtree/snippy_gubbins_iqtree.treefile > snippy_gubbins_iqtree.newick
```
