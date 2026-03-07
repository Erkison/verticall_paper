I ran Verticall on Marvin/Trillian/Zaphod for consistency.



# Software used

* [FastANI](https://github.com/ParBLiSS/FastANI) v1.33
* [MinVar-Rooting](https://github.com/uym2/MinVar-Rooting) v1.5



# Installation

```bash
cd ~/programs
wget https://github.com/ParBLiSS/FastANI/releases/download/v1.33/fastANI-Linux64-v1.33.zip
unzip fastANI-Linux64-v1.33.zip
mv fastANI ~/.local/bin
rm fastANI-Linux64-v1.33.zip
```



# Paths

Choose based on dataset:
```bash
base_dir=/home/wickr/Verticall_paper/S_pneumo_PMEN1
base_dir=/home/wickr/Verticall_paper/S_enterica_Typhi_431
base_dir=/home/wickr/Verticall_paper/E_coli_GEMS
base_dir=/home/wickr/Verticall_paper/Klebsiella_Alfred
```



# Run FastANI

```bash
mkdir "$base_dir"/fastani
cd "$base_dir"/fastani

ls ../assemblies/*.fasta.gz > genome_list
/usr/bin/time -v -o fastani.time fastANI --rl genome_list --ql genome_list --threads 32 -o fastani.out
~/programs/Verticall/scripts/fastani_to_phylip.py fastani.out > fastani.phylip
```

FastANI resources used:

| Dataset              |   Time    |  RAM (kB) |      Status       |
-------------------------------------------------------------------|
| S_pneumo_PMEN1       |      8:28 |   1240128 | finished          |
| S_enterica_Typhi_431 | 115:54:18 |  50541196 | finished          |
| E_coli_GEMS          |     16:20 |   3748984 | finished          |
| Klebsiella_Alfred    |   1:34:18 |   9653208 | finished          |




# Build a tree

```bash
mkdir "$base_dir"/trees/fastani_fastme
cd "$base_dir"/trees/fastani_fastme
cp ../../fastani/fastani.phylip .
/usr/bin/time -v -o fastme.time ~/programs/Verticall/scripts/fastme.sh fastani.phylip
mv fastani.newick ../fastani_fastme.newick
```

FastME resources used:

| Dataset              |   Time   | RAM (kB) |      Status       |
-----------------------------------------------------------------|
| S_pneumo_PMEN1       |     0:04 |   241648 | finished          |
| S_enterica_Typhi_431 |  5:28:51 |  2659924 | finished          |
| E_coli_GEMS          |     0:05 |   238188 | finished          |
| Klebsiella_Alfred    |     0:13 |   240448 | finished          |
