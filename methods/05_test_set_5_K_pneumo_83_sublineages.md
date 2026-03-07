# K. pneumoniae dataset (83 sublineages)

The data came from two sources:  
* Pathogenwatch K. pneumoniae collection (as of June 2023)
* AMR Geno-Pheno Group paper: https://www.microbiologyresearch.org/content/journal/mgen/10.1099/mgen.0.001294


I downloaded all Pathogenwatch assemblies and associated data (for K. pneumoniae only) via the download api
```bash
d=$(date '+%Y_%m_%d')
for s in pneumoniae;
do
  mkdir -p ${d}/${s}
  wget https://pathogenwatch-public.ams3.cdn.digitaloceanspaces.com/Klebsiella%20${s}__fastas.zip -O ${d}/${s}/fastas.zip;
  for a in kleborate kaptive klebsiella-lincodes metadata inctyper;
  do
    wget https://pathogenwatch-public.ams3.cdn.digitaloceanspaces.com/Klebsiella%20${s}__${a}.csv.gz -O ${d}/${s}/${a}.csv.gz;
  done;
done
```
I then downloaded the corresponding reads for the pathogenwatch assemblies from ENA based on their accession numbers using [ena-file-downloader](https://github.com/enasequence/ena-ftp-downloader)

Reads and assemblies for the geno-pheno dataset were already downloaded on MASSIVE prior to this.



Accession numbers for all reads are provided in Table S6

