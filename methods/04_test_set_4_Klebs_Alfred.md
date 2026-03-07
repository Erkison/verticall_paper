# Paper

The data came from this paper: https://www.microbiologyresearch.org/content/journal/mgen/10.1099/mgen.0.000102

BioProjects:
* PRJEB6891 (KASPAH sequenced at Sanger)
* PRJNA351909 (KASPAH sequenced at MDU)




# Prep directories

```bash
cd /projects/js66/individuals/ryan/Verticall_paper
mkdir Klebsiella_Alfred

cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred
mkdir reads
mkdir assemblies
mkdir alignments
```




# Download reads


To determine which reads to download, I first got these tables from EBI:
```
https://www.ebi.ac.uk/ena/portal/api/filereport?accession=PRJNA351909&result=read_run&fields=sample_accession,fastq_ftp,sample_alias&format=tsv&download=true&limit=0
https://www.ebi.ac.uk/ena/portal/api/filereport?accession=PRJEB6891&result=read_run&fields=sample_accession,fastq_ftp,sample_alias&format=tsv&download=true&limit=0
```
And I then removed any lines which had only a single read file, implying long reads, leaving only paired-end Illumina reads. A number of isolates were sequenced in both BioProjects, so for each of these I preferentially kept the PRJEB6891 one. Finally, INF017 had two read sets in PRJEB6891, so I kept the second one (which was larger) on the assumption that something was wrong with the first and therefore it had to be resequenced.

This left me with 653 read sets in total:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/reads
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356945_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023737/ERR1023737_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356945_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023737/ERR1023737_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356946_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023738/ERR1023738_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356946_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023738/ERR1023738_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356947_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023739/ERR1023739_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356947_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023739/ERR1023739_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356948_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023740/ERR1023740_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356948_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023740/ERR1023740_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356949_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023741/ERR1023741_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356949_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023741/ERR1023741_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356950_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023742/ERR1023742_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356950_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023742/ERR1023742_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356951_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023743/ERR1023743_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356951_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023743/ERR1023743_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356952_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023744/ERR1023744_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356952_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023744/ERR1023744_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356953_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023745/ERR1023745_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356953_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023745/ERR1023745_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356954_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023746/ERR1023746_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356954_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023746/ERR1023746_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356955_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023747/ERR1023747_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356955_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023747/ERR1023747_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356956_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023748/ERR1023748_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356956_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023748/ERR1023748_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356957_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023749/ERR1023749_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356957_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023749/ERR1023749_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356959_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/008/ERR1215608/ERR1215608_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356959_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/008/ERR1215608/ERR1215608_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356960_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/009/ERR1215609/ERR1215609_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356960_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/009/ERR1215609/ERR1215609_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356961_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023751/ERR1023751_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356961_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023751/ERR1023751_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356962_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023752/ERR1023752_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356962_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023752/ERR1023752_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356963_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023753/ERR1023753_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356963_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023753/ERR1023753_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356964_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008657/ERR1008657_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356964_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008657/ERR1008657_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356965_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023754/ERR1023754_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356965_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023754/ERR1023754_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356966_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008658/ERR1008658_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356966_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008658/ERR1008658_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356967_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008659/ERR1008659_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356967_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008659/ERR1008659_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356968_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023755/ERR1023755_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356968_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023755/ERR1023755_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356969_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008660/ERR1008660_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356969_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008660/ERR1008660_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356970_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008661/ERR1008661_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356970_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008661/ERR1008661_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356971_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023756/ERR1023756_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356971_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023756/ERR1023756_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356972_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008662/ERR1008662_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356972_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008662/ERR1008662_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356973_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008663/ERR1008663_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356973_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008663/ERR1008663_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356974_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023757/ERR1023757_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356974_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023757/ERR1023757_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356975_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008664/ERR1008664_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356975_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008664/ERR1008664_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356976_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008665/ERR1008665_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356976_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008665/ERR1008665_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356977_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023758/ERR1023758_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356977_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023758/ERR1023758_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356978_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008666/ERR1008666_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356978_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008666/ERR1008666_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356979_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023759/ERR1023759_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356979_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023759/ERR1023759_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356980_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008667/ERR1008667_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356980_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008667/ERR1008667_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356981_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008668/ERR1008668_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356981_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008668/ERR1008668_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356982_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023760/ERR1023760_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356982_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023760/ERR1023760_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356983_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023761/ERR1023761_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356983_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023761/ERR1023761_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356984_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008669/ERR1008669_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356984_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008669/ERR1008669_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356985_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023762/ERR1023762_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356985_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023762/ERR1023762_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356986_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023763/ERR1023763_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356986_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023763/ERR1023763_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356987_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008670/ERR1008670_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356987_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008670/ERR1008670_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356988_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008671/ERR1008671_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356988_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008671/ERR1008671_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356989_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023764/ERR1023764_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356989_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023764/ERR1023764_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356990_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008672/ERR1008672_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356990_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008672/ERR1008672_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356991_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023765/ERR1023765_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356991_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023765/ERR1023765_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356992_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023766/ERR1023766_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356992_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023766/ERR1023766_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356993_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008673/ERR1008673_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356993_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008673/ERR1008673_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356994_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023767/ERR1023767_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356994_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023767/ERR1023767_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356995_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008674/ERR1008674_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356995_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008674/ERR1008674_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356996_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023768/ERR1023768_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356996_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023768/ERR1023768_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356997_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008675/ERR1008675_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356997_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008675/ERR1008675_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356998_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023769/ERR1023769_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356998_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023769/ERR1023769_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356999_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008676/ERR1008676_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3356999_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008676/ERR1008676_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357000_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023770/ERR1023770_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357000_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023770/ERR1023770_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357001_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008677/ERR1008677_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357001_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008677/ERR1008677_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357002_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023771/ERR1023771_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357002_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023771/ERR1023771_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357003_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008678/ERR1008678_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357003_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008678/ERR1008678_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357004_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023772/ERR1023772_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357004_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023772/ERR1023772_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357005_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023773/ERR1023773_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357005_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023773/ERR1023773_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357006_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008679/ERR1008679_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357006_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008679/ERR1008679_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357007_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008680/ERR1008680_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357007_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008680/ERR1008680_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357008_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023774/ERR1023774_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357008_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023774/ERR1023774_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357009_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008681/ERR1008681_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357009_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008681/ERR1008681_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357010_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023775/ERR1023775_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357010_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023775/ERR1023775_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357011_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023776/ERR1023776_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357011_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023776/ERR1023776_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357012_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008682/ERR1008682_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357012_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008682/ERR1008682_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357013_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023777/ERR1023777_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357013_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023777/ERR1023777_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357014_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008683/ERR1008683_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357014_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008683/ERR1008683_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357015_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023778/ERR1023778_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357015_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023778/ERR1023778_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357016_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008684/ERR1008684_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357016_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008684/ERR1008684_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357017_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023779/ERR1023779_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357017_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023779/ERR1023779_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357018_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008685/ERR1008685_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357018_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008685/ERR1008685_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357019_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023780/ERR1023780_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357019_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023780/ERR1023780_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357020_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008686/ERR1008686_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357020_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008686/ERR1008686_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357021_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023781/ERR1023781_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357021_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023781/ERR1023781_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357022_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008687/ERR1008687_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357022_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008687/ERR1008687_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357023_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023782/ERR1023782_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357023_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023782/ERR1023782_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357024_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008688/ERR1008688_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357024_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008688/ERR1008688_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357025_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023783/ERR1023783_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357025_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023783/ERR1023783_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357026_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023784/ERR1023784_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357026_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023784/ERR1023784_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357027_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008689/ERR1008689_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357027_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008689/ERR1008689_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357028_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023785/ERR1023785_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357028_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023785/ERR1023785_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357029_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008690/ERR1008690_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357029_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008690/ERR1008690_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357030_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023786/ERR1023786_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357030_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023786/ERR1023786_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357031_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008691/ERR1008691_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357031_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008691/ERR1008691_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357032_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023787/ERR1023787_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357032_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023787/ERR1023787_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357033_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008692/ERR1008692_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357033_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008692/ERR1008692_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357034_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023788/ERR1023788_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357034_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023788/ERR1023788_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357035_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008693/ERR1008693_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357035_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008693/ERR1008693_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357036_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023789/ERR1023789_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357036_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023789/ERR1023789_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357037_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008694/ERR1008694_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357037_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008694/ERR1008694_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357038_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008695/ERR1008695_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357038_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008695/ERR1008695_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357039_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023790/ERR1023790_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357039_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023790/ERR1023790_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357040_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/002/ERR1215612/ERR1215612_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357040_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/002/ERR1215612/ERR1215612_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357041_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023791/ERR1023791_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357041_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023791/ERR1023791_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357042_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008696/ERR1008696_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357042_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008696/ERR1008696_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357043_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023792/ERR1023792_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357043_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023792/ERR1023792_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357044_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008697/ERR1008697_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357044_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008697/ERR1008697_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357045_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023793/ERR1023793_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357045_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023793/ERR1023793_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357046_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008698/ERR1008698_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357046_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008698/ERR1008698_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357047_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023794/ERR1023794_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357047_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023794/ERR1023794_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357048_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008699/ERR1008699_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357048_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008699/ERR1008699_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357049_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023795/ERR1023795_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357049_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023795/ERR1023795_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357050_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008700/ERR1008700_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357050_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008700/ERR1008700_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357051_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023715/ERR1023715_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357051_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023715/ERR1023715_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357052_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008701/ERR1008701_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357052_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008701/ERR1008701_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357053_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023796/ERR1023796_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357053_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023796/ERR1023796_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357054_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008702/ERR1008702_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357054_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008702/ERR1008702_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357055_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008703/ERR1008703_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357055_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008703/ERR1008703_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357056_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/000/ERR1215610/ERR1215610_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357056_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/000/ERR1215610/ERR1215610_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357057_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023797/ERR1023797_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357057_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023797/ERR1023797_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357058_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008704/ERR1008704_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357058_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008704/ERR1008704_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357059_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008628/ERR1008628_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357059_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008628/ERR1008628_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357060_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008705/ERR1008705_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357060_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008705/ERR1008705_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357061_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/001/ERR1215611/ERR1215611_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357061_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/001/ERR1215611/ERR1215611_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357062_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008706/ERR1008706_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357062_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008706/ERR1008706_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357063_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008629/ERR1008629_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357063_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008629/ERR1008629_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357064_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008707/ERR1008707_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357064_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008707/ERR1008707_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357065_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008630/ERR1008630_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357065_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008630/ERR1008630_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357066_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008708/ERR1008708_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357066_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008708/ERR1008708_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357067_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008709/ERR1008709_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357067_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008709/ERR1008709_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357068_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008631/ERR1008631_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357068_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008631/ERR1008631_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357069_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008710/ERR1008710_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357069_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008710/ERR1008710_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357070_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008632/ERR1008632_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357070_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008632/ERR1008632_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357071_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008711/ERR1008711_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357071_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008711/ERR1008711_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357072_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008633/ERR1008633_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357072_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008633/ERR1008633_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357073_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023798/ERR1023798_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357073_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023798/ERR1023798_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357074_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008634/ERR1008634_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357074_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008634/ERR1008634_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357075_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023799/ERR1023799_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357075_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023799/ERR1023799_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357076_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008635/ERR1008635_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357076_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008635/ERR1008635_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357077_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023800/ERR1023800_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357077_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023800/ERR1023800_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357078_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008636/ERR1008636_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357078_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008636/ERR1008636_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357079_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008637/ERR1008637_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357079_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008637/ERR1008637_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357080_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023801/ERR1023801_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357080_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023801/ERR1023801_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357081_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008638/ERR1008638_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357081_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008638/ERR1008638_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357082_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023802/ERR1023802_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357082_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023802/ERR1023802_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357083_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008639/ERR1008639_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357083_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008639/ERR1008639_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357084_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023803/ERR1023803_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357084_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023803/ERR1023803_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357085_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008640/ERR1008640_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357085_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008640/ERR1008640_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357086_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023804/ERR1023804_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357086_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023804/ERR1023804_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357087_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008641/ERR1008641_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357087_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008641/ERR1008641_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357088_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/009/ERR1035979/ERR1035979_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357088_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/009/ERR1035979/ERR1035979_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357089_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008642/ERR1008642_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357089_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008642/ERR1008642_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357090_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/000/ERR1035980/ERR1035980_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357090_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/000/ERR1035980/ERR1035980_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357091_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008643/ERR1008643_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357091_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008643/ERR1008643_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357092_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023805/ERR1023805_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357092_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023805/ERR1023805_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357093_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008644/ERR1008644_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357093_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008644/ERR1008644_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357094_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023806/ERR1023806_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357094_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023806/ERR1023806_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357095_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008645/ERR1008645_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357095_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008645/ERR1008645_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357096_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023807/ERR1023807_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357096_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023807/ERR1023807_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357097_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023716/ERR1023716_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357097_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023716/ERR1023716_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357098_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008646/ERR1008646_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357098_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008646/ERR1008646_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357099_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023808/ERR1023808_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357099_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023808/ERR1023808_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357100_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008647/ERR1008647_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357100_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008647/ERR1008647_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357101_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023809/ERR1023809_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357101_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023809/ERR1023809_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357102_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008648/ERR1008648_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357102_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008648/ERR1008648_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357103_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008649/ERR1008649_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357103_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008649/ERR1008649_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357104_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023810/ERR1023810_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357104_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023810/ERR1023810_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357105_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023811/ERR1023811_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357105_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023811/ERR1023811_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357106_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008650/ERR1008650_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357106_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008650/ERR1008650_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357107_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023812/ERR1023812_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357107_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023812/ERR1023812_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357108_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008651/ERR1008651_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357108_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008651/ERR1008651_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357109_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008652/ERR1008652_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357109_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008652/ERR1008652_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357110_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023813/ERR1023813_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357110_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023813/ERR1023813_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357111_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008653/ERR1008653_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357111_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008653/ERR1008653_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357112_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023814/ERR1023814_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357112_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023814/ERR1023814_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357113_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023815/ERR1023815_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357113_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023815/ERR1023815_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357114_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008654/ERR1008654_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357114_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008654/ERR1008654_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357115_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023816/ERR1023816_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357115_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023816/ERR1023816_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357116_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008655/ERR1008655_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357116_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008655/ERR1008655_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357117_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008656/ERR1008656_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357117_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008656/ERR1008656_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357118_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023817/ERR1023817_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357118_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023817/ERR1023817_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357119_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023818/ERR1023818_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357119_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023818/ERR1023818_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357120_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023819/ERR1023819_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357120_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023819/ERR1023819_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357121_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023820/ERR1023820_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357121_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023820/ERR1023820_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357122_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023821/ERR1023821_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357122_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023821/ERR1023821_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357123_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023822/ERR1023822_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357123_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023822/ERR1023822_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357124_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023823/ERR1023823_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357124_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023823/ERR1023823_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357125_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023824/ERR1023824_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357125_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023824/ERR1023824_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357126_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023825/ERR1023825_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357126_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023825/ERR1023825_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357127_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023826/ERR1023826_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357127_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023826/ERR1023826_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357128_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023827/ERR1023827_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357128_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023827/ERR1023827_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357129_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023828/ERR1023828_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357129_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023828/ERR1023828_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357130_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023829/ERR1023829_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357130_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023829/ERR1023829_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357131_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023830/ERR1023830_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357131_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023830/ERR1023830_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357132_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023831/ERR1023831_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357132_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023831/ERR1023831_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357133_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023832/ERR1023832_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357133_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023832/ERR1023832_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357134_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023717/ERR1023717_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357134_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023717/ERR1023717_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357135_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023833/ERR1023833_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357135_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023833/ERR1023833_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357136_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023834/ERR1023834_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357136_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023834/ERR1023834_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357137_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023835/ERR1023835_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357137_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023835/ERR1023835_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357138_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023836/ERR1023836_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357138_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023836/ERR1023836_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357139_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023837/ERR1023837_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357139_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023837/ERR1023837_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357140_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023838/ERR1023838_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357140_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023838/ERR1023838_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357141_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023839/ERR1023839_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357141_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023839/ERR1023839_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357142_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023840/ERR1023840_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357142_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023840/ERR1023840_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357143_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023841/ERR1023841_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357143_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023841/ERR1023841_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357144_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023842/ERR1023842_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357144_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023842/ERR1023842_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357145_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023843/ERR1023843_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357145_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023843/ERR1023843_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357146_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023844/ERR1023844_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357146_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023844/ERR1023844_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357147_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023845/ERR1023845_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357147_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023845/ERR1023845_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357148_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023846/ERR1023846_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357148_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023846/ERR1023846_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357149_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023847/ERR1023847_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357149_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023847/ERR1023847_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357150_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023848/ERR1023848_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357150_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023848/ERR1023848_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357151_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008753/ERR1008753_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357151_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008753/ERR1008753_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357152_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023849/ERR1023849_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357152_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023849/ERR1023849_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357153_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008754/ERR1008754_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357153_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008754/ERR1008754_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357154_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023850/ERR1023850_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357154_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023850/ERR1023850_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357155_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008755/ERR1008755_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357155_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008755/ERR1008755_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357156_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023851/ERR1023851_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357156_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023851/ERR1023851_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357157_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008756/ERR1008756_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357157_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008756/ERR1008756_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357158_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023852/ERR1023852_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357158_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023852/ERR1023852_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357159_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008757/ERR1008757_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357159_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008757/ERR1008757_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357160_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023853/ERR1023853_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357160_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023853/ERR1023853_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357161_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008758/ERR1008758_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357161_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008758/ERR1008758_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357162_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023854/ERR1023854_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357162_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023854/ERR1023854_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357163_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008759/ERR1008759_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357163_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008759/ERR1008759_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357164_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023855/ERR1023855_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357164_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023855/ERR1023855_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357165_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008760/ERR1008760_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357165_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008760/ERR1008760_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357166_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023856/ERR1023856_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357166_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023856/ERR1023856_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357167_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008761/ERR1008761_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357167_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008761/ERR1008761_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357168_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023857/ERR1023857_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357168_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023857/ERR1023857_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357169_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008762/ERR1008762_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357169_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008762/ERR1008762_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357170_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023858/ERR1023858_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357170_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023858/ERR1023858_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357171_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008763/ERR1008763_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357171_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008763/ERR1008763_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357172_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023859/ERR1023859_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357172_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023859/ERR1023859_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357173_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008764/ERR1008764_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357173_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008764/ERR1008764_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357174_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023860/ERR1023860_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357174_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023860/ERR1023860_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357175_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008765/ERR1008765_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357175_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008765/ERR1008765_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357176_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023861/ERR1023861_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357176_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023861/ERR1023861_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357177_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008766/ERR1008766_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357177_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008766/ERR1008766_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357178_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023862/ERR1023862_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357178_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023862/ERR1023862_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357179_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008767/ERR1008767_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357179_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008767/ERR1008767_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357180_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023863/ERR1023863_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357180_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023863/ERR1023863_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357181_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008768/ERR1008768_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357181_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008768/ERR1008768_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357182_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023864/ERR1023864_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357182_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023864/ERR1023864_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357183_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008769/ERR1008769_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357183_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008769/ERR1008769_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357184_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008770/ERR1008770_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357184_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008770/ERR1008770_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357185_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/003/ERR1215613/ERR1215613_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357185_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/003/ERR1215613/ERR1215613_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357186_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008771/ERR1008771_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357186_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008771/ERR1008771_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357187_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008772/ERR1008772_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357187_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008772/ERR1008772_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357188_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023718/ERR1023718_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357188_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023718/ERR1023718_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357189_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008773/ERR1008773_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357189_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008773/ERR1008773_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357190_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023865/ERR1023865_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357190_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023865/ERR1023865_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357191_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008774/ERR1008774_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357191_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008774/ERR1008774_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357192_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023866/ERR1023866_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357192_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023866/ERR1023866_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357193_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008775/ERR1008775_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357193_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008775/ERR1008775_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357194_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023867/ERR1023867_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357194_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023867/ERR1023867_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357195_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023868/ERR1023868_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357195_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023868/ERR1023868_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357196_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008776/ERR1008776_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357196_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008776/ERR1008776_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357197_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023869/ERR1023869_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357197_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023869/ERR1023869_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357198_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/001/ERR1035981/ERR1035981_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357198_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/001/ERR1035981/ERR1035981_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357199_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008777/ERR1008777_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357199_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008777/ERR1008777_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357200_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/002/ERR1035982/ERR1035982_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357200_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/002/ERR1035982/ERR1035982_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357201_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008778/ERR1008778_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357201_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008778/ERR1008778_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357202_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/003/ERR1035983/ERR1035983_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357202_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/003/ERR1035983/ERR1035983_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357203_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008779/ERR1008779_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357203_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008779/ERR1008779_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357204_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/004/ERR1035984/ERR1035984_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357204_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/004/ERR1035984/ERR1035984_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357205_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/005/ERR1035985/ERR1035985_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357205_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/005/ERR1035985/ERR1035985_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357206_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008780/ERR1008780_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357206_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008780/ERR1008780_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357207_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/006/ERR1035986/ERR1035986_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357207_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/006/ERR1035986/ERR1035986_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357208_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008781/ERR1008781_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357208_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008781/ERR1008781_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357209_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/007/ERR1035987/ERR1035987_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357209_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/007/ERR1035987/ERR1035987_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357210_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008782/ERR1008782_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357210_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008782/ERR1008782_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357211_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/008/ERR1035988/ERR1035988_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357211_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/008/ERR1035988/ERR1035988_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357212_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008783/ERR1008783_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357212_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008783/ERR1008783_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357213_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/009/ERR1035989/ERR1035989_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357213_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/009/ERR1035989/ERR1035989_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357214_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008784/ERR1008784_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357214_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008784/ERR1008784_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357215_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/000/ERR1035990/ERR1035990_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357215_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/000/ERR1035990/ERR1035990_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357216_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008785/ERR1008785_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357216_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008785/ERR1008785_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357217_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/001/ERR1035991/ERR1035991_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357217_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR103/001/ERR1035991/ERR1035991_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357218_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008786/ERR1008786_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357218_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008786/ERR1008786_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357219_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008712/ERR1008712_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357219_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008712/ERR1008712_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357220_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008787/ERR1008787_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357220_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008787/ERR1008787_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357221_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008713/ERR1008713_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357221_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008713/ERR1008713_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357222_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008788/ERR1008788_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357222_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008788/ERR1008788_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357223_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008714/ERR1008714_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357223_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008714/ERR1008714_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357224_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008789/ERR1008789_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357224_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008789/ERR1008789_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357225_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008715/ERR1008715_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357225_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008715/ERR1008715_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357226_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008790/ERR1008790_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357226_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008790/ERR1008790_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357227_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008716/ERR1008716_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357227_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008716/ERR1008716_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357228_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023721/ERR1023721_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357228_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023721/ERR1023721_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357229_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008717/ERR1008717_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357229_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008717/ERR1008717_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357230_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008718/ERR1008718_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357230_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008718/ERR1008718_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357231_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/006/ERR1215616/ERR1215616_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357231_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/006/ERR1215616/ERR1215616_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357232_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/004/ERR1215614/ERR1215614_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357232_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/004/ERR1215614/ERR1215614_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357233_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008791/ERR1008791_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357233_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008791/ERR1008791_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357234_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008719/ERR1008719_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357234_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008719/ERR1008719_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357235_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008792/ERR1008792_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357235_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008792/ERR1008792_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357236_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008720/ERR1008720_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357236_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008720/ERR1008720_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357237_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008793/ERR1008793_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357237_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008793/ERR1008793_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357238_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008721/ERR1008721_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357238_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008721/ERR1008721_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357239_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008794/ERR1008794_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357239_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008794/ERR1008794_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357240_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008722/ERR1008722_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357240_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008722/ERR1008722_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357241_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015281/ERR1015281_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357241_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015281/ERR1015281_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357242_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008723/ERR1008723_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357242_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008723/ERR1008723_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357243_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015282/ERR1015282_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357243_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015282/ERR1015282_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357244_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008724/ERR1008724_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357244_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008724/ERR1008724_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357245_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015283/ERR1015283_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357245_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015283/ERR1015283_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357246_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008725/ERR1008725_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357246_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008725/ERR1008725_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357247_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015284/ERR1015284_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357247_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015284/ERR1015284_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357248_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023719/ERR1023719_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357248_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023719/ERR1023719_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357249_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008726/ERR1008726_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357249_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008726/ERR1008726_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357250_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015285/ERR1015285_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357250_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015285/ERR1015285_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357251_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008727/ERR1008727_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357251_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008727/ERR1008727_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357252_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015286/ERR1015286_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357252_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015286/ERR1015286_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357253_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008728/ERR1008728_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357253_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008728/ERR1008728_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357254_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015287/ERR1015287_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357254_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015287/ERR1015287_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357255_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023720/ERR1023720_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357255_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023720/ERR1023720_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357256_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015288/ERR1015288_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357256_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015288/ERR1015288_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357257_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008729/ERR1008729_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357257_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008729/ERR1008729_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357258_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015289/ERR1015289_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357258_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015289/ERR1015289_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357259_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008730/ERR1008730_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357259_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008730/ERR1008730_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357260_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023722/ERR1023722_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357260_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023722/ERR1023722_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357261_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008731/ERR1008731_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357261_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008731/ERR1008731_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357262_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015290/ERR1015290_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357262_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015290/ERR1015290_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357263_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008732/ERR1008732_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357263_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008732/ERR1008732_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357264_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008733/ERR1008733_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357264_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008733/ERR1008733_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357265_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015291/ERR1015291_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357265_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015291/ERR1015291_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357266_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015292/ERR1015292_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357266_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015292/ERR1015292_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357267_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008734/ERR1008734_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357267_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008734/ERR1008734_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357268_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008735/ERR1008735_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357268_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008735/ERR1008735_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357269_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015293/ERR1015293_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357269_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015293/ERR1015293_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357270_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008736/ERR1008736_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357270_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008736/ERR1008736_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357271_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015294/ERR1015294_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357271_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015294/ERR1015294_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357272_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008737/ERR1008737_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357272_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008737/ERR1008737_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357273_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008738/ERR1008738_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357273_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008738/ERR1008738_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357274_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015295/ERR1015295_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357274_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015295/ERR1015295_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357275_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/005/ERR1215615/ERR1215615_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357275_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/005/ERR1215615/ERR1215615_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357276_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015296/ERR1015296_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357276_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015296/ERR1015296_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357277_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008739/ERR1008739_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357277_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008739/ERR1008739_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357278_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008740/ERR1008740_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357278_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008740/ERR1008740_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357279_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023723/ERR1023723_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357279_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023723/ERR1023723_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357280_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008741/ERR1008741_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357280_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008741/ERR1008741_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357281_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015297/ERR1015297_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357281_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015297/ERR1015297_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357282_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008742/ERR1008742_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357282_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008742/ERR1008742_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357283_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008743/ERR1008743_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357283_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/003/ERR1008743/ERR1008743_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357284_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015298/ERR1015298_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357284_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015298/ERR1015298_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357285_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008744/ERR1008744_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357285_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/004/ERR1008744/ERR1008744_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357286_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/007/ERR1215617/ERR1215617_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357286_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/007/ERR1215617/ERR1215617_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357287_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008745/ERR1008745_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357287_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/005/ERR1008745/ERR1008745_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357288_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015299/ERR1015299_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357288_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015299/ERR1015299_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357289_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015300/ERR1015300_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357289_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015300/ERR1015300_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357290_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008746/ERR1008746_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357290_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/006/ERR1008746/ERR1008746_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357291_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015301/ERR1015301_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357291_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015301/ERR1015301_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357292_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008747/ERR1008747_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357292_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/007/ERR1008747/ERR1008747_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357293_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015302/ERR1015302_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357293_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015302/ERR1015302_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357294_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008748/ERR1008748_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357294_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/008/ERR1008748/ERR1008748_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357295_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015303/ERR1015303_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357295_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015303/ERR1015303_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357296_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008749/ERR1008749_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357296_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/009/ERR1008749/ERR1008749_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357297_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015304/ERR1015304_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357297_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015304/ERR1015304_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357298_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008750/ERR1008750_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357298_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/000/ERR1008750/ERR1008750_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357299_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015305/ERR1015305_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357299_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015305/ERR1015305_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357300_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008751/ERR1008751_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357300_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/001/ERR1008751/ERR1008751_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357301_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023724/ERR1023724_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357301_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023724/ERR1023724_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357302_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008752/ERR1008752_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357302_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR100/002/ERR1008752/ERR1008752_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357303_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015306/ERR1015306_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357303_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015306/ERR1015306_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357304_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015307/ERR1015307_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357304_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015307/ERR1015307_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357305_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/008/ERR1215618/ERR1215618_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357305_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/008/ERR1215618/ERR1215618_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357306_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/009/ERR1215619/ERR1215619_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357306_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/009/ERR1215619/ERR1215619_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357307_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015308/ERR1015308_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357307_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015308/ERR1015308_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357308_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015309/ERR1015309_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357308_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015309/ERR1015309_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357309_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015310/ERR1015310_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357309_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015310/ERR1015310_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357310_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015311/ERR1015311_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357310_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015311/ERR1015311_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357311_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015312/ERR1015312_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357311_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015312/ERR1015312_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357312_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015313/ERR1015313_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357312_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015313/ERR1015313_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357313_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015314/ERR1015314_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357313_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015314/ERR1015314_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357314_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015315/ERR1015315_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357314_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015315/ERR1015315_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357315_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015316/ERR1015316_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357315_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015316/ERR1015316_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357316_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015317/ERR1015317_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357316_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015317/ERR1015317_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357317_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015318/ERR1015318_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357317_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015318/ERR1015318_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357318_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015319/ERR1015319_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357318_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015319/ERR1015319_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357319_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015320/ERR1015320_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357319_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015320/ERR1015320_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357320_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015321/ERR1015321_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357320_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015321/ERR1015321_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357321_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/000/ERR1215620/ERR1215620_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357321_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/000/ERR1215620/ERR1215620_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357322_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/001/ERR1215621/ERR1215621_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357322_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/001/ERR1215621/ERR1215621_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357323_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015322/ERR1015322_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357323_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015322/ERR1015322_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357324_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015323/ERR1015323_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357324_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015323/ERR1015323_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357325_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023628/ERR1023628_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357325_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023628/ERR1023628_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357326_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023629/ERR1023629_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357326_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023629/ERR1023629_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357327_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023630/ERR1023630_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357327_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023630/ERR1023630_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357328_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023631/ERR1023631_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357328_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023631/ERR1023631_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357329_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023632/ERR1023632_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357329_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023632/ERR1023632_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357330_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023633/ERR1023633_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357330_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023633/ERR1023633_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357331_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023634/ERR1023634_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357331_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023634/ERR1023634_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357332_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023635/ERR1023635_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357332_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023635/ERR1023635_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357333_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023636/ERR1023636_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357333_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023636/ERR1023636_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357334_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023637/ERR1023637_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357334_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023637/ERR1023637_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357335_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023638/ERR1023638_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357335_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023638/ERR1023638_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357336_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023639/ERR1023639_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357336_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023639/ERR1023639_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357337_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023640/ERR1023640_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357337_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023640/ERR1023640_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357338_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023641/ERR1023641_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357338_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023641/ERR1023641_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357339_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023642/ERR1023642_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357339_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023642/ERR1023642_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357340_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023643/ERR1023643_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357340_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023643/ERR1023643_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357341_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023644/ERR1023644_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357341_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023644/ERR1023644_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357342_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023645/ERR1023645_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357342_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023645/ERR1023645_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357343_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023646/ERR1023646_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357343_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023646/ERR1023646_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357344_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023647/ERR1023647_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357344_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023647/ERR1023647_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357345_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023648/ERR1023648_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357345_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023648/ERR1023648_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357346_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023649/ERR1023649_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357346_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023649/ERR1023649_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357347_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023650/ERR1023650_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357347_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023650/ERR1023650_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357348_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023651/ERR1023651_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357348_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023651/ERR1023651_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357349_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023652/ERR1023652_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357349_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023652/ERR1023652_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357350_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023653/ERR1023653_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357350_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023653/ERR1023653_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357351_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023654/ERR1023654_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357351_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023654/ERR1023654_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357352_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/001/ERR1215631/ERR1215631_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357352_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/001/ERR1215631/ERR1215631_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357353_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023655/ERR1023655_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357353_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023655/ERR1023655_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357354_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023656/ERR1023656_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357354_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023656/ERR1023656_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357355_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023657/ERR1023657_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357355_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023657/ERR1023657_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357356_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023658/ERR1023658_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357356_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023658/ERR1023658_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357357_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023659/ERR1023659_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357357_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023659/ERR1023659_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357358_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023660/ERR1023660_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357358_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023660/ERR1023660_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357359_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023661/ERR1023661_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357359_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023661/ERR1023661_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357360_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023662/ERR1023662_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357360_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023662/ERR1023662_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357361_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023663/ERR1023663_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357361_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023663/ERR1023663_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357362_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023664/ERR1023664_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357362_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023664/ERR1023664_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357363_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023665/ERR1023665_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357363_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023665/ERR1023665_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357364_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023666/ERR1023666_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357364_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023666/ERR1023666_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357365_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015324/ERR1015324_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357365_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015324/ERR1015324_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357366_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023667/ERR1023667_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357366_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023667/ERR1023667_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357367_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015325/ERR1015325_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357367_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015325/ERR1015325_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357368_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023668/ERR1023668_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357368_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023668/ERR1023668_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357369_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015326/ERR1015326_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357369_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015326/ERR1015326_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357370_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023669/ERR1023669_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357370_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023669/ERR1023669_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357371_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015327/ERR1015327_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357371_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015327/ERR1015327_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357372_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023670/ERR1023670_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357372_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023670/ERR1023670_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357373_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015328/ERR1015328_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357373_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015328/ERR1015328_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357374_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023671/ERR1023671_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357374_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023671/ERR1023671_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357375_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015329/ERR1015329_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357375_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015329/ERR1015329_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357376_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023672/ERR1023672_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357376_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023672/ERR1023672_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357377_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015330/ERR1015330_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357377_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015330/ERR1015330_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357378_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023673/ERR1023673_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357378_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023673/ERR1023673_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357379_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/002/ERR1215622/ERR1215622_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357379_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/002/ERR1215622/ERR1215622_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357380_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015331/ERR1015331_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357380_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015331/ERR1015331_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357381_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023674/ERR1023674_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357381_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023674/ERR1023674_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357382_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015332/ERR1015332_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357382_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015332/ERR1015332_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357383_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023675/ERR1023675_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357383_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023675/ERR1023675_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357384_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015333/ERR1015333_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357384_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015333/ERR1015333_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357385_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023676/ERR1023676_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357385_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023676/ERR1023676_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357386_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015334/ERR1015334_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357386_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015334/ERR1015334_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357387_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015335/ERR1015335_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357387_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015335/ERR1015335_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357388_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023677/ERR1023677_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357388_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023677/ERR1023677_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357389_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/003/ERR1215623/ERR1215623_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357389_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/003/ERR1215623/ERR1215623_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357390_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023678/ERR1023678_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357390_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023678/ERR1023678_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357391_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015336/ERR1015336_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357391_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015336/ERR1015336_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357392_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023679/ERR1023679_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357392_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023679/ERR1023679_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357393_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015337/ERR1015337_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357393_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015337/ERR1015337_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357394_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023680/ERR1023680_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357394_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023680/ERR1023680_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357395_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015338/ERR1015338_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357395_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015338/ERR1015338_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357396_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023681/ERR1023681_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357396_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023681/ERR1023681_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357397_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015339/ERR1015339_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357397_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015339/ERR1015339_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357398_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023682/ERR1023682_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357398_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023682/ERR1023682_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357399_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015340/ERR1015340_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357399_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015340/ERR1015340_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357400_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015341/ERR1015341_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357400_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015341/ERR1015341_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357401_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023683/ERR1023683_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357401_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023683/ERR1023683_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357402_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015342/ERR1015342_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357402_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015342/ERR1015342_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357403_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023684/ERR1023684_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357403_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023684/ERR1023684_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357404_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015343/ERR1015343_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357404_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015343/ERR1015343_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357405_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023685/ERR1023685_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357405_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023685/ERR1023685_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357406_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015344/ERR1015344_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357406_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015344/ERR1015344_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357407_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015345/ERR1015345_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357407_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015345/ERR1015345_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357408_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023686/ERR1023686_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357408_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023686/ERR1023686_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357409_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015346/ERR1015346_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357409_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015346/ERR1015346_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357410_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023687/ERR1023687_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357410_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023687/ERR1023687_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357411_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015347/ERR1015347_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357411_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015347/ERR1015347_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357412_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023688/ERR1023688_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357412_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023688/ERR1023688_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357413_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015348/ERR1015348_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357413_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015348/ERR1015348_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357414_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023689/ERR1023689_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357414_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023689/ERR1023689_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357415_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015349/ERR1015349_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357415_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015349/ERR1015349_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357416_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023690/ERR1023690_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357416_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023690/ERR1023690_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357417_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015350/ERR1015350_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357417_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015350/ERR1015350_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357418_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023691/ERR1023691_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357418_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023691/ERR1023691_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357419_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023692/ERR1023692_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357419_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023692/ERR1023692_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357420_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/004/ERR1215624/ERR1215624_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357420_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/004/ERR1215624/ERR1215624_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357421_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023693/ERR1023693_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357421_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023693/ERR1023693_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357422_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015351/ERR1015351_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357422_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015351/ERR1015351_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357423_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/002/ERR1215632/ERR1215632_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357423_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/002/ERR1215632/ERR1215632_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357424_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015352/ERR1015352_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357424_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015352/ERR1015352_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357425_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015353/ERR1015353_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357425_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015353/ERR1015353_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357426_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023694/ERR1023694_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357426_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023694/ERR1023694_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357427_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023695/ERR1023695_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357427_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023695/ERR1023695_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357428_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015354/ERR1015354_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357428_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015354/ERR1015354_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357429_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023696/ERR1023696_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357429_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023696/ERR1023696_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357430_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015355/ERR1015355_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357430_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015355/ERR1015355_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357431_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023697/ERR1023697_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357431_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023697/ERR1023697_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357432_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015356/ERR1015356_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357432_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015356/ERR1015356_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357433_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023698/ERR1023698_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357433_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023698/ERR1023698_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357434_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015357/ERR1015357_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357434_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015357/ERR1015357_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357435_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023699/ERR1023699_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357435_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023699/ERR1023699_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357436_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015358/ERR1015358_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357436_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015358/ERR1015358_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357437_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023700/ERR1023700_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357437_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023700/ERR1023700_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357438_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015359/ERR1015359_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357438_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015359/ERR1015359_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357439_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023701/ERR1023701_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357439_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023701/ERR1023701_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357440_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015360/ERR1015360_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357440_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015360/ERR1015360_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357441_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023702/ERR1023702_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357441_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023702/ERR1023702_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357442_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015361/ERR1015361_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357442_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015361/ERR1015361_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357443_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023703/ERR1023703_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357443_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023703/ERR1023703_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357444_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023725/ERR1023725_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357444_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023725/ERR1023725_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357445_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/003/ERR1215633/ERR1215633_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357445_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/003/ERR1215633/ERR1215633_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357446_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/005/ERR1215625/ERR1215625_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357446_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/005/ERR1215625/ERR1215625_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357447_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023704/ERR1023704_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357447_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023704/ERR1023704_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357448_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015362/ERR1015362_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357448_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015362/ERR1015362_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357449_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023705/ERR1023705_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357449_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023705/ERR1023705_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357450_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/006/ERR1215626/ERR1215626_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357450_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/006/ERR1215626/ERR1215626_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357451_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/004/ERR1215634/ERR1215634_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357451_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/004/ERR1215634/ERR1215634_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357452_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023706/ERR1023706_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357452_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023706/ERR1023706_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357453_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015363/ERR1015363_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357453_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015363/ERR1015363_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357454_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023707/ERR1023707_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357454_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023707/ERR1023707_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357455_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015364/ERR1015364_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357455_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015364/ERR1015364_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357456_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023708/ERR1023708_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357456_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023708/ERR1023708_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357457_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015365/ERR1015365_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357457_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015365/ERR1015365_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357458_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015366/ERR1015366_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357458_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015366/ERR1015366_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357459_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023709/ERR1023709_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357459_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023709/ERR1023709_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357460_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/007/ERR1215627/ERR1215627_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357460_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/007/ERR1215627/ERR1215627_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357461_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/005/ERR1215635/ERR1215635_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357461_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/005/ERR1215635/ERR1215635_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357462_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015367/ERR1015367_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357462_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015367/ERR1015367_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357463_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023710/ERR1023710_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357463_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023710/ERR1023710_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357464_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015368/ERR1015368_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357464_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015368/ERR1015368_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357465_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015369/ERR1015369_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357465_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015369/ERR1015369_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357466_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023711/ERR1023711_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357466_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023711/ERR1023711_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357467_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/006/ERR1215636/ERR1215636_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357467_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/006/ERR1215636/ERR1215636_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357468_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015370/ERR1015370_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357468_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015370/ERR1015370_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357469_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023712/ERR1023712_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357469_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023712/ERR1023712_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357470_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015371/ERR1015371_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357470_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015371/ERR1015371_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357471_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/007/ERR1215637/ERR1215637_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357471_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/007/ERR1215637/ERR1215637_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357472_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015372/ERR1015372_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357472_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015372/ERR1015372_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357473_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023713/ERR1023713_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357473_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023713/ERR1023713_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357474_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015373/ERR1015373_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357474_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015373/ERR1015373_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357475_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023714/ERR1023714_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357475_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023714/ERR1023714_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357476_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023726/ERR1023726_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357476_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023726/ERR1023726_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357477_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/008/ERR1215638/ERR1215638_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357477_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/008/ERR1215638/ERR1215638_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357478_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015374/ERR1015374_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357478_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015374/ERR1015374_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357479_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015375/ERR1015375_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357479_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015375/ERR1015375_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357480_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015376/ERR1015376_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357480_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015376/ERR1015376_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357481_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015377/ERR1015377_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357481_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015377/ERR1015377_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357482_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015378/ERR1015378_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357482_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015378/ERR1015378_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357483_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015379/ERR1015379_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357483_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015379/ERR1015379_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357484_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023727/ERR1023727_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357484_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/007/ERR1023727/ERR1023727_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357485_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015380/ERR1015380_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357485_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015380/ERR1015380_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357486_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015381/ERR1015381_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357486_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015381/ERR1015381_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357487_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015382/ERR1015382_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357487_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015382/ERR1015382_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357488_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015383/ERR1015383_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357488_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015383/ERR1015383_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357489_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015384/ERR1015384_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357489_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015384/ERR1015384_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357490_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015385/ERR1015385_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357490_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015385/ERR1015385_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357491_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015386/ERR1015386_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357491_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015386/ERR1015386_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357492_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015387/ERR1015387_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357492_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015387/ERR1015387_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357493_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015388/ERR1015388_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357493_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015388/ERR1015388_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357494_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015389/ERR1015389_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357494_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015389/ERR1015389_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357495_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015390/ERR1015390_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357495_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015390/ERR1015390_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357496_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015391/ERR1015391_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357496_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015391/ERR1015391_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357497_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015392/ERR1015392_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357497_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015392/ERR1015392_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357498_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015393/ERR1015393_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357498_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015393/ERR1015393_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357499_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015394/ERR1015394_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357499_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015394/ERR1015394_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357500_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015395/ERR1015395_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357500_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015395/ERR1015395_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357501_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015396/ERR1015396_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357501_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015396/ERR1015396_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357502_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015397/ERR1015397_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357502_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015397/ERR1015397_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357503_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015398/ERR1015398_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357503_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015398/ERR1015398_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357504_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015399/ERR1015399_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357504_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015399/ERR1015399_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357505_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015400/ERR1015400_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357505_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015400/ERR1015400_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357506_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015401/ERR1015401_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357506_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015401/ERR1015401_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357507_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015402/ERR1015402_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357507_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015402/ERR1015402_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357508_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015403/ERR1015403_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357508_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015403/ERR1015403_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357509_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015404/ERR1015404_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357509_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015404/ERR1015404_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357510_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015405/ERR1015405_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357510_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015405/ERR1015405_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357511_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015406/ERR1015406_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357511_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015406/ERR1015406_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357512_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023728/ERR1023728_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357512_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/008/ERR1023728/ERR1023728_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357513_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015407/ERR1015407_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357513_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015407/ERR1015407_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357514_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015408/ERR1015408_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357514_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015408/ERR1015408_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357515_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015409/ERR1015409_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357515_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015409/ERR1015409_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357516_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015410/ERR1015410_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357516_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015410/ERR1015410_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357517_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015411/ERR1015411_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357517_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015411/ERR1015411_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357518_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015412/ERR1015412_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357518_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015412/ERR1015412_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357519_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015413/ERR1015413_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357519_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015413/ERR1015413_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357520_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/008/ERR1215628/ERR1215628_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357520_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/008/ERR1215628/ERR1215628_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357521_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015414/ERR1015414_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357521_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015414/ERR1015414_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357522_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015415/ERR1015415_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357522_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015415/ERR1015415_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357523_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015416/ERR1015416_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357523_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015416/ERR1015416_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357524_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015417/ERR1015417_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357524_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015417/ERR1015417_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357525_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015418/ERR1015418_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357525_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015418/ERR1015418_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357526_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023729/ERR1023729_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357526_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/009/ERR1023729/ERR1023729_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357527_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015419/ERR1015419_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357527_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015419/ERR1015419_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357528_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015420/ERR1015420_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357528_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015420/ERR1015420_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357529_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015421/ERR1015421_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357529_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015421/ERR1015421_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357530_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015422/ERR1015422_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357530_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015422/ERR1015422_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357531_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015423/ERR1015423_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357531_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015423/ERR1015423_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357532_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015424/ERR1015424_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357532_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015424/ERR1015424_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357533_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015425/ERR1015425_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357533_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015425/ERR1015425_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357534_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015426/ERR1015426_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357534_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015426/ERR1015426_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357535_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015427/ERR1015427_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357535_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015427/ERR1015427_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357536_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015428/ERR1015428_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357536_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015428/ERR1015428_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357537_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015429/ERR1015429_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357537_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015429/ERR1015429_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357538_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015430/ERR1015430_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357538_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015430/ERR1015430_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357539_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015431/ERR1015431_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357539_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015431/ERR1015431_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357540_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/009/ERR1215629/ERR1215629_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357540_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/009/ERR1215629/ERR1215629_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357541_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023730/ERR1023730_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357541_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/000/ERR1023730/ERR1023730_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357542_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015432/ERR1015432_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357542_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015432/ERR1015432_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357543_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015433/ERR1015433_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357543_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015433/ERR1015433_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357544_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023731/ERR1023731_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357544_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/001/ERR1023731/ERR1023731_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357545_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015434/ERR1015434_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357545_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015434/ERR1015434_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357546_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015435/ERR1015435_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357546_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015435/ERR1015435_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357547_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/000/ERR1215630/ERR1215630_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357547_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/000/ERR1215630/ERR1215630_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357548_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015436/ERR1015436_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357548_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015436/ERR1015436_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357549_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015437/ERR1015437_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357549_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1015437/ERR1015437_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357550_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015438/ERR1015438_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357550_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1015438/ERR1015438_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357555_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023732/ERR1023732_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357555_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/002/ERR1023732/ERR1023732_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357556_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015439/ERR1015439_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357556_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1015439/ERR1015439_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357557_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015440/ERR1015440_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357557_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1015440/ERR1015440_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357558_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023733/ERR1023733_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357558_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/003/ERR1023733/ERR1023733_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357559_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015441/ERR1015441_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357559_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1015441/ERR1015441_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357560_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015442/ERR1015442_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357560_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1015442/ERR1015442_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357561_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023734/ERR1023734_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357561_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/004/ERR1023734/ERR1023734_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357562_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023735/ERR1023735_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357562_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/005/ERR1023735/ERR1023735_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357563_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023736/ERR1023736_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357563_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/006/ERR1023736/ERR1023736_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357564_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015443/ERR1015443_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357564_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1015443/ERR1015443_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357565_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015444/ERR1015444_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357565_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1015444/ERR1015444_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357566_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015445/ERR1015445_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357566_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1015445/ERR1015445_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357567_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015446/ERR1015446_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA3357567_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1015446/ERR1015446_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112194_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/001/SRR5082451/SRR5082451_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112194_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/001/SRR5082451/SRR5082451_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112195_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/008/SRR5082468/SRR5082468_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112195_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/008/SRR5082468/SRR5082468_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112196_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/000/SRR5082490/SRR5082490_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112196_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/000/SRR5082490/SRR5082490_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112197_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/006/SRR5082456/SRR5082456_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112197_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/006/SRR5082456/SRR5082456_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112198_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/005/SRR5082475/SRR5082475_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112198_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/005/SRR5082475/SRR5082475_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112199_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/009/SRR5082489/SRR5082489_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112199_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/009/SRR5082489/SRR5082489_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112200_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/007/SRR5082487/SRR5082487_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112200_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/007/SRR5082487/SRR5082487_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112201_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/001/SRR5082481/SRR5082481_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112201_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/001/SRR5082481/SRR5082481_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112202_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/007/SRR5082477/SRR5082477_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112202_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/007/SRR5082477/SRR5082477_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112203_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/000/SRR5082460/SRR5082460_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112203_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/000/SRR5082460/SRR5082460_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112205_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/006/SRR5082476/SRR5082476_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112205_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/006/SRR5082476/SRR5082476_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112206_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/006/SRR5082486/SRR5082486_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112206_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/006/SRR5082486/SRR5082486_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112207_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/002/SRR5082452/SRR5082452_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112207_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/002/SRR5082452/SRR5082452_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112214_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/001/SRR5082471/SRR5082471_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112214_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/001/SRR5082471/SRR5082471_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112217_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/000/SRR5082450/SRR5082450_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112217_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/000/SRR5082450/SRR5082450_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112218_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/009/SRR5082459/SRR5082459_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112218_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/009/SRR5082459/SRR5082459_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112219_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/008/SRR5082458/SRR5082458_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112219_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/008/SRR5082458/SRR5082458_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112220_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/005/SRR5082455/SRR5082455_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112220_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/005/SRR5082455/SRR5082455_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112221_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/007/SRR5082447/SRR5082447_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112221_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/007/SRR5082447/SRR5082447_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112222_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/004/SRR5082454/SRR5082454_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112222_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/004/SRR5082454/SRR5082454_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112223_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/005/SRR5082445/SRR5082445_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112223_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/005/SRR5082445/SRR5082445_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112224_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/009/SRR5082469/SRR5082469_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112224_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/009/SRR5082469/SRR5082469_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112225_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/001/SRR5082461/SRR5082461_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112225_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/001/SRR5082461/SRR5082461_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112226_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/009/SRR5082449/SRR5082449_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112226_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/009/SRR5082449/SRR5082449_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112227_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/003/SRR5082453/SRR5082453_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112227_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/003/SRR5082453/SRR5082453_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112228_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/003/SRR5082463/SRR5082463_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112228_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/003/SRR5082463/SRR5082463_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112229_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/005/SRR5082465/SRR5082465_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112229_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/005/SRR5082465/SRR5082465_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112230_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/005/SRR5082485/SRR5082485_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112230_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/005/SRR5082485/SRR5082485_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112231_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/004/SRR5082464/SRR5082464_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112231_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/004/SRR5082464/SRR5082464_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112241_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/003/SRR5082483/SRR5082483_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN06112241_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR508/003/SRR5082483/SRR5082483_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN07211279_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR566/009/SRR5665579/SRR5665579_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN07211279_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR566/009/SRR5665579/SRR5665579_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN07211280_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR566/008/SRR5665578/SRR5665578_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN07211280_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR566/008/SRR5665578/SRR5665578_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN07211281_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR566/001/SRR5665581/SRR5665581_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN07211281_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR566/001/SRR5665581/SRR5665581_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN07211282_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR566/000/SRR5665580/SRR5665580_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN07211282_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR566/000/SRR5665580/SRR5665580_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN07738870_1.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR617/003/SRR6175453/SRR6175453_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMN07738870_2.fastq.gz ftp.sra.ebi.ac.uk/vol1/fastq/SRR617/003/SRR6175453/SRR6175453_2.fastq.gz
```

Sanity check that the downloads look good (`_1.fastq.gz` and `_2.fastq.gz` files have the same number of reads):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/reads
for s in $(ls *_1.fastq.gz | sed 's/_1.fastq.gz//'); do
    r1_count=$(fast_count "$s"_1.fastq.gz | cut -f2)
    r2_count=$(fast_count "$s"_2.fastq.gz | cut -f2)
    if [[ "$r1_count" == "$r2_count" ]]; then
        echo $s"\t"$r1_count"\tmatch"
    else
        echo $s"\t"$r1_count"\t"$r2_count"\tMISMATCH"
    fi
done
```




# Species identification

I know that a lot of these genomes aren't Klebs, so I'll do a Mash species check using the reads before I assemble:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/reads
wget https://github.com/katholt/Kleborate/raw/main/kleborate/data/species_mash_sketches.msh
for r1 in *_1.fastq.gz; do
    mash sketch -m 2 "$r1"
    printf $r1"\t" >> species_results.tsv
    mash dist species_mash_sketches.msh "$r1".msh | sort -nk3,3 | head -n1 | cut -f1,3 | perl -pe 's|/.+\t|\t|' | sed 's/_/ /g' >> species_results.tsv
    rm "$r1".msh
done
cat species_results.tsv | grep -v "Klebsiella"
rm species_mash_sketches.msh
```

This revealed that 106 read sets were non-Klebs, which I deleted:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/reads
for s in SAMEA3357288 SAMEA3357353 SAMEA3357365 SAMEA3357367 SAMEA3357369 SAMEA3357371 SAMEA3357375 SAMEA3357379 SAMEA3357380 SAMEA3357382 SAMEA3357384 SAMEA3357386 SAMEA3357387 SAMEA3357389 SAMEA3357391 SAMEA3357393 SAMEA3357397 SAMEA3357399 SAMEA3357402 SAMEA3357403 SAMEA3357404 SAMEA3357406 SAMEA3357407 SAMEA3357411 SAMEA3357415 SAMEA3357417 SAMEA3357420 SAMEA3357422 SAMEA3357424 SAMEA3357425 SAMEA3357432 SAMEA3357436 SAMEA3357438 SAMEA3357440 SAMEA3357442 SAMEA3357444 SAMEA3357450 SAMEA3357452 SAMEA3357453 SAMEA3357454 SAMEA3357456 SAMEA3357457 SAMEA3357459 SAMEA3357460 SAMEA3357462 SAMEA3357463 SAMEA3357465 SAMEA3357467 SAMEA3357468 SAMEA3357469 SAMEA3357470 SAMEA3357471 SAMEA3357472 SAMEA3357473 SAMEA3357474 SAMEA3357475 SAMEA3357476 SAMEA3357478 SAMEA3357479 SAMEA3357480 SAMEA3357481 SAMEA3357482 SAMEA3357483 SAMEA3357485 SAMEA3357486 SAMEA3357488 SAMEA3357489 SAMEA3357490 SAMEA3357491 SAMEA3357492 SAMEA3357493 SAMEA3357494 SAMEA3357495 SAMEA3357497 SAMEA3357498 SAMEA3357499 SAMEA3357500 SAMEA3357501 SAMEA3357502 SAMEA3357503 SAMEA3357504 SAMEA3357505 SAMEA3357506 SAMEA3357507 SAMEA3357508 SAMEA3357509 SAMEA3357510 SAMEA3357513 SAMEA3357514 SAMEA3357516 SAMEA3357517 SAMEA3357518 SAMEA3357519 SAMEA3357520 SAMEA3357521 SAMEA3357522 SAMEA3357523 SAMEA3357524 SAMEA3357526 SAMEA3357527 SAMEA3357528 SAMEA3357530 SAMEA3357531 SAMEA3357532 SAMEA3357533 SAMEA3357534; do
    rm "$s"_1.fastq.gz "$s"_2.fastq.gz
done
```

Leaving me with 547 Klebs genomes.





# Unicycler assemblies

```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies
for r1 in /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/reads/*_1.fastq.gz; do
    r2=${r1/_1.fastq.gz/_2.fastq.gz}
    s=$(echo "$r1" | grep -oP "SAM[EAN]+\d+")
    cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies
    mkdir "$s"; cd "$s"
    sbatch --job-name="$s" --time=0-4:00:00 --partition=genomics --qos=genomics --ntasks=1 --mem=64000 --cpus-per-task=8 --account md52 --wrap "module load spades/3.15.3; module load blast+/2.9.0; fastp --in1 "$r1" --in2 "$r2" --out1 illumina_1.fastq.gz --out2 illumina_2.fastq.gz --unpaired1 illumina_u.fastq.gz --unpaired2 illumina_u.fastq.gz; /home/rwic0002/programs/Unicycler/unicycler-runner.py -1 illumina_1.fastq.gz -2 illumina_2.fastq.gz -s illumina_u.fastq.gz -o unicycler --threads 8; rm illumina_*.fastq.gz"
done
```
Four read sets were very low depth (<5x) and didn't assemble, leaving 543 assemblies.




# Read and assembly stats

Total read bases:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/reads
for r1 in *_1.fastq.gz; do
    r2=${r1/_1.fastq.gz/_2.fastq.gz}
    s=$(echo "$r1" | grep -oP "SAM[EAN]+\d+")
    r1bases=$(fast_count "$r1" | cut -f3)
    r2bases=$(fast_count "$r2" | cut -f3)
    totalbases=$(( $r1bases + $r2bases ))
    echo $s"\t"$totalbases
done
```

fastp filtering:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies
for s in SAM*; do
    r1_bases_before=$(cat "$s"/slurm-*.out | grep -A2 "Read1 before filtering:" | grep "total bases:" | grep -oP "\d+")
    r2_bases_before=$(cat "$s"/slurm-*.out | grep -A2 "Read2 before filtering:" | grep "total bases:" | grep -oP "\d+")
    r1_bases_after=$(cat "$s"/slurm-*.out | grep -A2 "Read1 after filtering:" | grep "total bases:" | grep -oP "\d+")
    r2_bases_after=$(cat "$s"/slurm-*.out | grep -A2 "Read2 after filtering:" | grep "total bases:" | grep -oP "\d+")
    printf $s"\t"
    echo $r1_bases_before"\t"$r2_bases_before"\t"$r1_bases_after"\t"$r2_bases_after | awk '{print ($3+$4)/($1+$2);}'
done
```

Assembly size (from fasta):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies
for s in SAM*; do
    size=$(fast_count "$s"/unicycler/assembly.fasta | cut -f3)
    echo $s"\t"$size
done
```

Assembly N50 (from fasta):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies
for s in SAM*; do
    n50=$(fast_count "$s"/unicycler/assembly.fasta | cut -f6)
    echo $s"\t"$n50
done
```

Assembly contigs (from fasta):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies
for s in SAM*; do
    n50=$(fast_count "$s"/unicycler/assembly.fasta | cut -f2)
    echo $s"\t"$n50
done
```

Assembly dead ends (from gfa):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies
for s in SAM*; do
    dead=$(deadends "$s"/unicycler/assembly.gfa)
    echo $s"\t"$dead
done
```




# Species check

Just to ensure that there were no mix-ups, I checked each assembly against the Kleborate species database:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies
wget https://github.com/katholt/Kleborate/raw/main/kleborate/data/species_mash_sketches.msh
for s in SAM*; do
    printf $s"\t" >> species_results.tsv
    if [ -f "$s"/unicycler/assembly.fasta ]; then
        mash dist species_mash_sketches.msh "$s"/unicycler/assembly.fasta | sort -nk3,3 | head -n1 | cut -f1,3 | perl -pe 's|/.+\t|\t|' | sed 's/_/ /g' >> species_results.tsv
    else
        printf "\n" >> species_results.tsv
    fi
done
rm species_mash_sketches.msh
```
Four were not _Klebsiella_ (since their reads registered as Klebs, I'm guessing that there was Klebs contamination in the reads).




# QC

I rejected samples where any of the following was true:
* fastp pass rate <10% (none)
* Failed to assemble (4 assemblies)
* Assembly size >7 Mbp (6 assemblies)
* Assembly N50 <15 kbp (1 assemblies)
* Assembly graph dead ends >100 (4 assemblies)
* Heterogeneity (bubbles) in assembly graph (2 assemblies)
* Not Klebsiella (4 assemblies)

```bash
mkdir /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/reads/qc_fail
mkdir /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies/qc_fail

for s in SAMEA3356975 SAMEA3357051 SAMEA3357151 SAMEA3357188 SAMEA3357231 SAMEA3357255 SAMEA3357271 SAMEA3357279 SAMEA3357312 SAMEA3357348 SAMEA3357355 SAMEA3357361 SAMEA3357366 SAMEA3357383 SAMEA3357385 SAMEA3357395 SAMEA3357401 SAMEA3357448 SAMEA3357455 SAMEA3357477 SAMEA3357512; do
    cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/reads
    mv "$s"_*.fastq.gz qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies
    mv "$s" qc_fail
done
```
This left me with 526 assemblies.

Going forward, I only need the assembly FASTAs, so I'll move the Unicycler files elsewhere and just copy out the final result:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred
mv assemblies assemblies_working_files
mkdir assemblies
cd assemblies_working_files
for s in SAM*; do
    cp "$s"/unicycler/assembly.fasta ../assemblies/"$s".fasta
done
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies
gzip *.fasta
```




# Reference genome

```bash
cd /projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/598/005/GCF_000598005.1_ASM59800v1/GCF_000598005.1_ASM59800v1_genomic.fna.gz
echo ">Reference" > Reference.fasta
seqtk seq GCF_000598005.1_ASM59800v1_genomic.fna.gz | head -n2 | tail -n1 >> Reference.fasta
rm GCF_000598005.1_ASM59800v1_genomic.fna.gz

sed 's/GACGTGCTGGGACNGGTAAAATGCCGC/GACGTGCTGGGACAGGTAAAATGCCGC/' Reference.fasta > Reference_no_ambiguous.fasta
```



# K. variicola species hybrids

For the variicola-pneumo hybrids, I wanted to do a bit more analysis. First MLST:
```bash
conda activate mlst
cd ~/Verticall_paper/Klebsiella_Alfred
mkdir genome_painter; cd genome_painter

mkdir my_assemblies
for a in SAMEA3356968 SAMEA3357194 SAMN06112230 SAMN06112220 SAMEA3357131 SAMEA3357148 SAMEA3357331 SAMEA3357320 SAMEA3357215 SAMEA3357335 SAMEA3357152 SAMEA3357218 SAMEA3357147 SAMEA3357071 SAMEA3357294 SAMEA3357339; do
    cp ../assemblies/"$a".fasta.gz my_assemblies
done
gunzip my_assemblies/*.fasta.gz
mlst --scheme klebsiella my_assemblies/*.fasta > mlst.tsv
```

Then [Stephen's Genome Painter](https://github.com/scwatts/genome_painter) tool for a quantification of their hybrid nature.
```bash
cd ~/Verticall_paper/Klebsiella_Alfred/genome_painter/my_assemblies
genomepainter_paint_genome --genome_fps *.fasta --kmer_db_fp klebsiella_2021_t20_a0.bin --output_dir .
genomepainter_summarise_species.py . > species_summary.tsv
```

I also ran Genome Painter on the publicly available completed genomes, for nicer visualisations:
```bash
cd ~/Verticall_paper/Klebsiella_Alfred/genome_painter
mkdir complete_genomes; cd complete_genomes
wget -O SAMEA3356968.fasta.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/904/863/055/GCF_904863055.1_INF022/GCF_904863055.1_INF022_genomic.fna.gz
wget -O SAMEA3357194.fasta.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/904/866/545/GCA_904866545.1_INF232/GCA_904866545.1_INF232_genomic.fna.gz
wget -O SAMEA3357320.fasta.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/904/863/415/GCA_904863415.1_KSB1_8D/GCA_904863415.1_KSB1_8D_genomic.fna.gz
wget -O SAMEA3357218.fasta.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/904/866/525/GCA_904866525.1_INF336/GCA_904866525.1_INF336_genomic.fna.gz
wget -O SAMEA3357147.fasta.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/904/864/495/GCA_904864495.1_INF208/GCA_904864495.1_INF208_genomic.fna.gz
wget -O SAMEA3357071.fasta.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/904/866/265/GCA_904866265.1_INF154/GCA_904866265.1_INF154_genomic.fna.gz
wget -O SAMEA3357294.fasta.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/904/865/775/GCA_904865775.1_INF290/GCA_904865775.1_INF290_genomic.fna.gz
wget -O SAMEA3357339.fasta.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/904/865/705/GCA_904865705.1_KSB1_9F/GCA_904865705.1_KSB1_9F_genomic.fna.gz

# Get just the chromosome:
for a in SAMEA3356968 SAMEA3357071 SAMEA3357147 SAMEA3357194 SAMEA3357218 SAMEA3357294 SAMEA3357320 SAMEA3357339; do
    seqtk seq "$a".fasta.gz | head -n2 > "$a".fasta
done
rm *.fasta.gz

mlst --scheme klebsiella *.fasta > mlst.tsv
genomepainter_paint_genome --genome_fps *.fasta --kmer_db_fp ../klebsiella_2021_t20_a0.bin --output_dir .
genomepainter_summarise_species.py . > species_summary.tsv
for a in SAMEA3356968 SAMEA3357071 SAMEA3357147 SAMEA3357194 SAMEA3357218 SAMEA3357294 SAMEA3357320 SAMEA3357339; do
    genomepainter_plot_painting.py --genome_painter_fp "$a"_painted.tsv.gz --output_fp "$a".html
    ~/programs/genome_painter/scripts/find_blocks.py "$a"_painted.tsv.gz > "$a".blocks
done
```



# Final paths

* Assemblies: `/projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/assemblies/*.fasta.gz`
* Reads: `/projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/reads/*_[12].fastq.gz`
* Reference: `/projects/js66/individuals/ryan/Verticall_paper/Klebsiella_Alfred/Reference.fasta`
