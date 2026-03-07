I ran ClonalFrameML on Marvin/Trillian/Zaphod for consistency.



# Software used

* [ClonalFrameML](https://github.com/xavierdidelot/ClonalFrameML) v1.13
* [MinVar-Rooting](https://github.com/uym2/MinVar-Rooting) v1.5



# Paths

Choose based on dataset:
```bash
base_dir=/home/wickr/Verticall_paper/S_pneumo_PMEN1
base_dir=/home/wickr/Verticall_paper/S_enterica_Typhi_431
base_dir=/home/wickr/Verticall_paper/E_coli_GEMS
base_dir=/home/wickr/Verticall_paper/Klebsiella_Alfred
```



# Run ClonalFrameML

```bash
mkdir "$base_dir"/clonalframeml
cd "$base_dir"/clonalframeml

/usr/bin/time -v -o clonalframeml.time ClonalFrameML ../trees/snippy_iqtree.newick ../alignments/snippy.fasta clonalframeml > clonalframeml.out
```

ClonalFrameML resources used:

| Dataset              |   Time   |  RAM (kB) |      Status       |
------------------------------------------------------------------|
| S_pneumo_PMEN1       |  1:47:20 |   4678112 | finished          |
| S_enterica_Typhi_431 |          | 392436568 | ran out of memory |
| E_coli_GEMS          | 13:57:51 |  21403216 | finished          |
| Klebsiella_Alfred    | 34:38:57 | 161243604 | finished          |

```R
round( c(4678112, 392436568, 21403216, 161243604) / (1024*1024), 1) # convert to GB
```

# Make a ClonalFrameML alignment

```bash
cd "$base_dir"/alignments
~/programs/Verticall/scripts/mask_clonalframeml_alignment.py snippy.fasta ../clonalframeml/clonalframeml.importation_status.txt ../clonalframeml/clonalframeml.labelled_tree.newick > snippy_clonalframeml.fasta
pigz -p4 snippy_clonalframeml.fasta
coresnpfilter -e -c 0.95 snippy_clonalframeml.fasta.gz | pigz -p4 > snippy_clonalframeml_core.fasta.gz
```




# Build a tree

```bash
mkdir "$base_dir"/trees/snippy_clonalframeml_iqtree
cd "$base_dir"/trees/snippy_clonalframeml_iqtree

/usr/bin/time -v -o snippy_clonalframeml_iqtree.time ~/programs/iqtree-2.2.2.3-Linux/bin/iqtree2 -s ../../alignments/snippy_clonalframeml_core.fasta.gz -T 32 --prefix snippy_clonalframeml_iqtree
```

IQ-TREE resources used:

| Dataset              |   Time   | RAM (kB) |      Status       |
-----------------------------------------------------------------|
| S_pneumo_PMEN1       |   0:5:22 |   106484 | finished          |
| S_enterica_Typhi_431 |          |          | unable to start   |
| E_coli_GEMS          |  0:13:11 |   447512 | finished          |
| Klebsiella_Alfred    |  0:7:23  |   27632  | unable to start   |


Minimum-variance rooting:
```bash
cd "$base_dir"/trees
python3 FastRoot.py -i snippy_clonalframeml_iqtree/snippy_clonalframeml_iqtree.treefile > snippy_clonalframeml_iqtree.newick
```
