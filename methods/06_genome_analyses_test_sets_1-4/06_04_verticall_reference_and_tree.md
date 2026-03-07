I ran Verticall on Marvin/Trillian/Zaphod for consistency.



# Software used

* [Verticall](https://github.com/rrwick/Verticall) v0.4.1
* [IQ-TREE](https://github.com/iqtree/iqtree2) v2.3.6
* [MinVar-Rooting](https://github.com/uym2/MinVar-Rooting) v1.5


# Installation

```bash
conda create --name verticall python=3.11
conda activate verticall
mamba install minimap2
cd ~/programs/Verticall
python3 -m pip install .
```


# Paths

Choose based on dataset:
```bash
base_dir=/home/wickr/Verticall_paper/S_pneumo_PMEN1
base_dir=/home/wickr/Verticall_paper/S_enterica_Typhi_431
base_dir=/home/wickr/Verticall_paper/E_coli_GEMS
base_dir=/home/wickr/Verticall_paper/Klebsiella_Alfred
```



# Run Verticall-reference

```bash
conda activate verticall

mkdir "$base_dir"/verticall_reference
cd "$base_dir"/verticall_reference

/usr/bin/time -v -o verticall_reference.time verticall pairwise -i ../assemblies -o verticall_reference.tsv -r ../Reference.fasta --threads 32 2> verticall_reference.out
rm ../assemblies/*.mmi
```

Verticall-reference resources used:

| Dataset              |   Time   |  RAM (kB) |      Status       |
------------------------------------------------------------------|
| S_pneumo_PMEN1       |     0:30 |    287936 | finished          |
| S_enterica_Typhi_431 |    26:10 |    544448 | finished          |
| E_coli_GEMS          |     1:20 |   1000808 | finished          |
| Klebsiella_Alfred    |     4:16 |   1033564 | finished          |

```R
round( c(287936, 544448, 1000808, 1033564) / (1024*1024), 1) # convert to GB
```

# Make a Verticall-reference alignment

```bash
cd "$base_dir"/alignments

cat ../Reference.fasta > snippy_with_ref.fasta
cat snippy.fasta >> snippy_with_ref.fasta

conda activate verticall
verticall mask -i ../verticall_reference/verticall_reference.tsv -a snippy_with_ref.fasta -o snippy_verticall_with_ref.fasta
cat snippy_verticall_with_ref.fasta | paste - - | grep -v "Reference" | tr '\t' '\n' > snippy_verticall.fasta
rm *_with_ref.fasta

pigz -p4 snippy_verticall.fasta
coresnpfilter -e -c 0.95 snippy_verticall.fasta.gz | pigz -p4 > snippy_verticall_core.fasta.gz
```




# Build a tree

```bash
mkdir "$base_dir"/trees/snippy_verticall_iqtree
cd "$base_dir"/trees/snippy_verticall_iqtree

/usr/bin/time -v -o snippy_verticall_iqtree.time iqtree2 -s ../../alignments/snippy_verticall_core.fasta.gz -T 32 --prefix snippy_verticall_iqtree
```

IQ-TREE resources used:

| Dataset              |   Time   | RAM (kB) |      Status       |
-----------------------------------------------------------------|
| S_pneumo_PMEN1       |    05:44 |   174012 | finished          |
| S_enterica_Typhi_431 |  8:00:07 |  6608592 | finished          |
| E_coli_GEMS          |  5:52:06 |  8490004 | finished          |
| Klebsiella_Alfred    |          |          | Could not finish  |


Minimum-variance rooting:
```bash
cd "$base_dir"/trees
python3 FastRoot.py -i snippy_verticall_iqtree/snippy_verticall_iqtree.treefile > snippy_verticall_iqtree.newick
```
