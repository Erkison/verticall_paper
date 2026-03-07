I ran Verticall on Marvin/Trillian/Zaphod for consistency.



# Software used

* [Verticall](https://github.com/rrwick/Verticall) v0.4.2
* [MinVar-Rooting](https://github.com/uym2/MinVar-Rooting) v1.5



# Paths

Choose based on dataset:
```bash
base_dir=/home/wickr/Verticall_paper/S_pneumo_PMEN1
base_dir=/home/wickr/Verticall_paper/S_enterica_Typhi_431
base_dir=/home/wickr/Verticall_paper/E_coli_GEMS
base_dir=/home/wickr/Verticall_paper/Klebsiella_Alfred
```



# Run Verticall-pairwise

```bash
mkdir "$base_dir"/verticall_pairwise
cd "$base_dir"/verticall_pairwise

conda activate verticall
/usr/bin/time -v -o verticall_pairwise.time verticall pairwise -i ../assemblies -o verticall_pairwise.tsv --threads 32 2> verticall_pairwise.out
/usr/bin/time -v -o verticall_matrix.time verticall matrix -i verticall_pairwise.tsv -o verticall_pairwise.phylip 2> verticall_matrix.out
```

Verticall resources used (time is the sum of pairwise and matrix, RAM is the larger of the two):

| Dataset              |   Time    |  RAM (kB) |      Status       |
-------------------------------------------------------------------|
| S_pneumo_PMEN1       |   1:05:12 |    320460 | finished          |
| S_enterica_Typhi_431 |           |           | didn't bother     |
| E_coli_GEMS          |   3:05:30 |    963404 | finished          |
| Klebsiella_Alfred    |  26:22:41 |   1331544 | finished          |

```R
round( c(320460, 963404, 1331544) / (1024*1024), 1) # convert to GB
```


# Build a tree

```bash
mkdir "$base_dir"/trees/verticall_pairwise_fastme
cd "$base_dir"/trees/verticall_pairwise_fastme
cp ../../verticall_pairwise/verticall_pairwise.phylip .
/usr/bin/time -v -o fastme.time ~/programs/Verticall/scripts/fastme.sh verticall_pairwise.phylip
mv verticall_pairwise.newick ../verticall_pairwise_fastme.newick
```

FastME resources used:

| Dataset              |   Time   | RAM (kB) |      Status       |
-----------------------------------------------------------------|
| S_pneumo_PMEN1       |     0:04 |   242100 | finished          |
| S_enterica_Typhi_431 |          |          |                   |
| E_coli_GEMS          |     0:04 |   238336 | finished          |
| Klebsiella_Alfred    |     0:10 |   243652 | finished          |


# Get reference positions for each genome
```bash
conda activate verticall
cd "$base_dir"/verticall_pairwise
get_verticall_reference_coordinates.py pairwise -i ../assemblies -o ref_coordinates.tsv \
       -r ../Reference.fasta --threads 8
```

# Build a `--multi exclude` tree

I only did this for the _Klebsiella_ tree to illustrate `--multi exclude`.

```bash
base_dir=/home/wickr/Verticall_paper/Klebsiella_Alfred
cd "$base_dir"/verticall_pairwise
verticall matrix -i verticall_pairwise.tsv -o verticall_pairwise_multi_exclude.phylip --multi exclude
cd "$base_dir"/trees/verticall_pairwise_fastme
cp ../../verticall_pairwise/verticall_pairwise_multi_exclude.phylip .
~/programs/Verticall/scripts/fastme.sh verticall_pairwise_multi_exclude.phylip
mv verticall_pairwise_multi_exclude.newick ../verticall_pairwise_multi_exclude_fastme.newick
```
