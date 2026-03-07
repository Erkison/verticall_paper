All analyses were run on MASSIVE. Sample commands with a single sublineage (SL1) are shown
All commands are run from the `selected_clones` directory as in the directory structure below

### Directory structure
```
- selected_clones/
    - SL_1/
        - SL_1_data.tsv
        - assemblies/*.fasta
        - reads/*_{1,2}.fastq.gz
    - SL_2/
        - SL_2_data.tsv
        - assemblies/*.fasta
        - reads/*_{1,2}.fastq.gz
    - scripts/
        - 01_get_reference.sh
```

### Get reference 
Software used:  

 - [Mash](https://github.com/marbl/Mash) v2.1  
 - [BactInspector](https://gitlab.com/antunderwood/bactinspector) v0.1.3  
```bash
conda activate bactinspector
bash scripts/01_get_reference.sh SL_1 
```

### Annotate reference 
Software used:  

 - [Bakta](https://github.com/oschwengers/bakta) v1.8.1  
```bash
conda activate bakta
bash scripts/02_run_bakta.sh SL_1
```

### Mapping with RedDog  
Software used:  

 - [RedDog-nf](https://github.com/katholt/reddog-nf/tree/main)  
```bash
conda activate /home/exterkodi/js66/software/conda_envs/reddog-nf
bash scripts/03_run_reddog.sh SL_1
```

### Treemmer if downsampling needed 
Software used:  

 - [Treemmer](https://github.com/fmenardo/Treemmer) v0.3  
 - [Mash](https://github.com/marbl/Mash) v2.3   
 - [FastME](https://gite.lirmm.fr/atgc/FastME/) v2.1.6.1  
 - [snp-dists](https://github.com/tseemann/snp-dists) v0.6.3  
 - R v4.4.0  
```bash
conda activate treemmer_env
bash scripts/04_run_treemmer.sh SL_1
```

### Gubbins  
Software used:  

 - [Gubbins](https://github.com/nickjcroucher/gubbins) v3.4  
 - [IQ-TREE](https://github.com/iqtree/iqtree2) v2.3.6  
 - [Seqtk](https://github.com/lh3/seqtk) v1.3  
 - [MinVar-Rooting](https://github.com/uym2/MinVar-Rooting) v1.5  
```bash
conda activate gubbinsv3_4
bash scripts/05_run_gubbins.sh SL_1
```


### Verticall alignment workflow 
Software used:  

 - [Verticall](https://github.com/rrwick/Verticall) v0.4.2  
 - [Minimap2](https://github.com/lh3/minimap2) v2.1.8  
 - [IQ-TREE](https://github.com/iqtree/iqtree2) v2.3.6  
```bash
conda activate verticall
bash scripts/06_run_verticall_alignment.sh SL_1
```


### Run Verticall distance workflow  
Software used:  

 - [Verticall](https://github.com/rrwick/Verticall) v0.4.2  
 - [Verticall custom wrapper](https://github.com/Erkison/verticall_nf)  
 - [Minimap2](https://github.com/lh3/minimap2) v2.1.8  
 - [FastME](https://gite.lirmm.fr/atgc/FastME/) v2.1.6.1  
```bash
conda activate verticall
bash scripts/07_run_verticall_distance.sh SL_1
```


