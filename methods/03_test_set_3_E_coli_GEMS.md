# Paper

The data came from this paper: https://www.nature.com/articles/nmicrobiol201510#MOESM247

I am just using the 196 _E. coli_ genomes sequenced for this paper, not the other public genomes (some of which are old 454 assemblies).




# Prep directories

```bash
cd /projects/js66/individuals/ryan/Verticall_paper
mkdir E_coli_GEMS

cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS
mkdir reads
mkdir assemblies
mkdir alignments
```




# Download reads

```bash
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/reads
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466096_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134533/ERR134533_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466096_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134533/ERR134533_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466097_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124662/ERR124662_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466097_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124662/ERR124662_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466098_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134515/ERR134515_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466098_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134515/ERR134515_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466099_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137789/ERR137789_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466099_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137789/ERR137789_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466100_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137810/ERR137810_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466100_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137810/ERR137810_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466101_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137794/ERR137794_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466101_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137794/ERR137794_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466102_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134525/ERR134525_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466102_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134525/ERR134525_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466103_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124656/ERR124656_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466103_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124656/ERR124656_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466104_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134547/ERR134547_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466104_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134547/ERR134547_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466105_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137806/ERR137806_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466105_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137806/ERR137806_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466106_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134553/ERR134553_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466106_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134553/ERR134553_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466107_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134534/ERR134534_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466107_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134534/ERR134534_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466108_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137824/ERR137824_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466108_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137824/ERR137824_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466110_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124654/ERR124654_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466110_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124654/ERR124654_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466111_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134524/ERR134524_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466111_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134524/ERR134524_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466112_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137804/ERR137804_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466112_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137804/ERR137804_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466113_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137819/ERR137819_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466113_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137819/ERR137819_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466114_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134559/ERR134559_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466114_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134559/ERR134559_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466115_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134546/ERR134546_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466115_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134546/ERR134546_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466116_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137805/ERR137805_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466116_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137805/ERR137805_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466117_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134560/ERR134560_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466117_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134560/ERR134560_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466118_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134535/ERR134535_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466118_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134535/ERR134535_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466119_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137795/ERR137795_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466119_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137795/ERR137795_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466120_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137825/ERR137825_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466120_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137825/ERR137825_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466121_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134554/ERR134554_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466121_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134554/ERR134554_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466122_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134514/ERR134514_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466122_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134514/ERR134514_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466123_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124655/ERR124655_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466123_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124655/ERR124655_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466124_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137822/ERR137822_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466124_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137822/ERR137822_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466125_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137812/ERR137812_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466125_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137812/ERR137812_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466126_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137792/ERR137792_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466126_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137792/ERR137792_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466127_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134544/ERR134544_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466127_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134544/ERR134544_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466128_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134551/ERR134551_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466128_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134551/ERR134551_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466129_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124653/ERR124653_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466129_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124653/ERR124653_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466130_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134531/ERR134531_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466130_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134531/ERR134531_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466131_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137803/ERR137803_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466131_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137803/ERR137803_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466132_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137782/ERR137782_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466132_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137782/ERR137782_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466133_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124663/ERR124663_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466133_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124663/ERR124663_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466134_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134513/ERR134513_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466134_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134513/ERR134513_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466135_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134545/ERR134545_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466135_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134545/ERR134545_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466136_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137791/ERR137791_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466136_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137791/ERR137791_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466137_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134527/ERR134527_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466137_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134527/ERR134527_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466138_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137823/ERR137823_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466138_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137823/ERR137823_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466139_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137793/ERR137793_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466139_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137793/ERR137793_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466140_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134532/ERR134532_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466140_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134532/ERR134532_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466141_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137802/ERR137802_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466141_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137802/ERR137802_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466142_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134543/ERR134543_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466142_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134543/ERR134543_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466143_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134526/ERR134526_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466143_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134526/ERR134526_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466144_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134552/ERR134552_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466144_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134552/ERR134552_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466145_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137783/ERR137783_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466145_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137783/ERR137783_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466146_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137813/ERR137813_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466146_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137813/ERR137813_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466147_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124657/ERR124657_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466147_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124657/ERR124657_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466148_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134549/ERR134549_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466148_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134549/ERR134549_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466149_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137800/ERR137800_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466149_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137800/ERR137800_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466150_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134542/ERR134542_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466150_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134542/ERR134542_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466151_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134538/ERR134538_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466151_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134538/ERR134538_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466152_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134529/ERR134529_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466152_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134529/ERR134529_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466153_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137799/ERR137799_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466153_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137799/ERR137799_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466154_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134519/ERR134519_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466154_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134519/ERR134519_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466155_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137790/ERR137790_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466155_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137790/ERR137790_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466156_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137798/ERR137798_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466156_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137798/ERR137798_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466158_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137784/ERR137784_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466158_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137784/ERR137784_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466159_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137814/ERR137814_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466159_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137814/ERR137814_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466160_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137829/ERR137829_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466160_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137829/ERR137829_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466161_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134541/ERR134541_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466161_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134541/ERR134541_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466162_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137821/ERR137821_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466162_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137821/ERR137821_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466163_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134555/ERR134555_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466163_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134555/ERR134555_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466164_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134550/ERR134550_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466164_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134550/ERR134550_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466165_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137801/ERR137801_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466165_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137801/ERR137801_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466166_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137816/ERR137816_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466166_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137816/ERR137816_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466167_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124664/ERR124664_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466167_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124664/ERR124664_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466168_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134520/ERR134520_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466168_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134520/ERR134520_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466169_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137809/ERR137809_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466169_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137809/ERR137809_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466170_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134530/ERR134530_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466170_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134530/ERR134530_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466171_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134528/ERR134528_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466171_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134528/ERR134528_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466172_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124658/ERR124658_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466172_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124658/ERR124658_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466173_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137820/ERR137820_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466173_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137820/ERR137820_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466174_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134556/ERR134556_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466174_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134556/ERR134556_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466175_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137785/ERR137785_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466175_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137785/ERR137785_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466176_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137815/ERR137815_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466176_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137815/ERR137815_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466177_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137817/ERR137817_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466177_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137817/ERR137817_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466178_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134521/ERR134521_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466178_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134521/ERR134521_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466179_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134518/ERR134518_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466179_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134518/ERR134518_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466180_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137826/ERR137826_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466180_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137826/ERR137826_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466181_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137808/ERR137808_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466181_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137808/ERR137808_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466182_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137827/ERR137827_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466182_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137827/ERR137827_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466183_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137786/ERR137786_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466183_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137786/ERR137786_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466184_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124659/ERR124659_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466184_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124659/ERR124659_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466185_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134517/ERR134517_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466185_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134517/ERR134517_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466186_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134536/ERR134536_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466186_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134536/ERR134536_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466187_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134540/ERR134540_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466187_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134540/ERR134540_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466188_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137796/ERR137796_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466188_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137796/ERR137796_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466189_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134522/ERR134522_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466189_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134522/ERR134522_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466190_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134537/ERR134537_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466190_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134537/ERR134537_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466192_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137818/ERR137818_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466192_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137818/ERR137818_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466193_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124661/ERR124661_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466193_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124661/ERR124661_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466194_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137807/ERR137807_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466194_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137807/ERR137807_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466195_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137797/ERR137797_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466195_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137797/ERR137797_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466196_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134516/ERR134516_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466196_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134516/ERR134516_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466197_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124660/ERR124660_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466197_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR124/ERR124660/ERR124660_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466198_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137787/ERR137787_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466198_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137787/ERR137787_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466199_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134539/ERR134539_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466199_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134539/ERR134539_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466200_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134548/ERR134548_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466200_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134548/ERR134548_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466201_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137828/ERR137828_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466201_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR137/ERR137828/ERR137828_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466202_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134558/ERR134558_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466202_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134558/ERR134558_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466203_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134523/ERR134523_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1466203_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134523/ERR134523_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527953_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175730/ERR175730_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527953_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175730/ERR175730_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527954_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175727/ERR175727_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527954_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175727/ERR175727_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527956_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175739/ERR175739_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527956_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175739/ERR175739_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527970_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175731/ERR175731_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527970_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175731/ERR175731_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527972_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175733/ERR175733_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527972_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175733/ERR175733_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527975_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175736/ERR175736_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527975_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175736/ERR175736_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527985_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175738/ERR175738_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527985_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175738/ERR175738_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527991_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175734/ERR175734_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527991_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175734/ERR175734_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527992_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175724/ERR175724_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1527992_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175724/ERR175724_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528003_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175735/ERR175735_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528003_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175735/ERR175735_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528004_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175726/ERR175726_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528004_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175726/ERR175726_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528005_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175725/ERR175725_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528005_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175725/ERR175725_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528013_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175737/ERR175737_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528013_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175737/ERR175737_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528021_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175728/ERR175728_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528021_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175728/ERR175728_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528041_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175729/ERR175729_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1528041_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR175/ERR175729/ERR175729_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530980_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178204/ERR178204_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530980_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178204/ERR178204_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530982_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178202/ERR178202_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530982_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178202/ERR178202_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530984_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178203/ERR178203_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530984_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178203/ERR178203_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530985_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178161/ERR178161_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530985_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178161/ERR178161_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530986_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178206/ERR178206_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530986_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178206/ERR178206_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530988_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178182/ERR178182_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530988_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178182/ERR178182_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530990_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178219/ERR178219_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530990_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178219/ERR178219_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530991_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178180/ERR178180_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530991_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178180/ERR178180_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530992_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178181/ERR178181_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530992_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178181/ERR178181_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530993_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178205/ERR178205_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530993_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178205/ERR178205_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530996_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178218/ERR178218_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530996_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178218/ERR178218_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530998_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178178/ERR178178_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530998_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178178/ERR178178_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530999_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178165/ERR178165_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1530999_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178165/ERR178165_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531000_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178150/ERR178150_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531000_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178150/ERR178150_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531001_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178179/ERR178179_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531001_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178179/ERR178179_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531002_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178217/ERR178217_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531002_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178217/ERR178217_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531004_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178164/ERR178164_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531004_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178164/ERR178164_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531005_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178166/ERR178166_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531005_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178166/ERR178166_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531007_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178201/ERR178201_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531007_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178201/ERR178201_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531008_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178175/ERR178175_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531008_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178175/ERR178175_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531009_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178176/ERR178176_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531009_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178176/ERR178176_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531010_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178216/ERR178216_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531010_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178216/ERR178216_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531012_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178221/ERR178221_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531012_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178221/ERR178221_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531014_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178200/ERR178200_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531014_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178200/ERR178200_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531015_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178167/ERR178167_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531015_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178167/ERR178167_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531016_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178177/ERR178177_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531016_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178177/ERR178177_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531017_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178215/ERR178215_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531017_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178215/ERR178215_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531019_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178214/ERR178214_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531019_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178214/ERR178214_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531020_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178153/ERR178153_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531020_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178153/ERR178153_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531021_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178168/ERR178168_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531021_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178168/ERR178168_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531022_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178223/ERR178223_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531022_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178223/ERR178223_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531023_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178189/ERR178189_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531023_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178189/ERR178189_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531024_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178154/ERR178154_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531024_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178154/ERR178154_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531025_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178195/ERR178195_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531025_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178195/ERR178195_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531026_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178174/ERR178174_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531026_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178174/ERR178174_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531027_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178213/ERR178213_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531027_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178213/ERR178213_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531028_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178188/ERR178188_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531028_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178188/ERR178188_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531029_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178222/ERR178222_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531029_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178222/ERR178222_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531030_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178169/ERR178169_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531030_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178169/ERR178169_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531031_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178155/ERR178155_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531031_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178155/ERR178155_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531032_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178173/ERR178173_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531032_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178173/ERR178173_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531033_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178212/ERR178212_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531033_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178212/ERR178212_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531034_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178196/ERR178196_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531034_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178196/ERR178196_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531035_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178172/ERR178172_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531035_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178172/ERR178172_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531036_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178151/ERR178151_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531036_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178151/ERR178151_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531037_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178198/ERR178198_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531037_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178198/ERR178198_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531038_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178211/ERR178211_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531038_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178211/ERR178211_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531039_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178197/ERR178197_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531039_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178197/ERR178197_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531040_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178226/ERR178226_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531040_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178226/ERR178226_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531041_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178152/ERR178152_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531041_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178152/ERR178152_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531042_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178171/ERR178171_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531042_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178171/ERR178171_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531043_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178210/ERR178210_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531043_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178210/ERR178210_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531044_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178199/ERR178199_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531044_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178199/ERR178199_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531045_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178224/ERR178224_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531045_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178224/ERR178224_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531046_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178225/ERR178225_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531046_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178225/ERR178225_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531047_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178170/ERR178170_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531047_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178170/ERR178170_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531048_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178149/ERR178149_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531048_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178149/ERR178149_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531049_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178158/ERR178158_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531049_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178158/ERR178158_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531050_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178228/ERR178228_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531050_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178228/ERR178228_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531052_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178184/ERR178184_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531052_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178184/ERR178184_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531053_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178148/ERR178148_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531053_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178148/ERR178148_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531054_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178192/ERR178192_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531054_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178192/ERR178192_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531055_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178183/ERR178183_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531055_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178183/ERR178183_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531056_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178159/ERR178159_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531056_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178159/ERR178159_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531057_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178227/ERR178227_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531057_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178227/ERR178227_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531058_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178191/ERR178191_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531058_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178191/ERR178191_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531059_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178187/ERR178187_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531059_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178187/ERR178187_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531060_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178193/ERR178193_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531060_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178193/ERR178193_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531061_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178156/ERR178156_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531061_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178156/ERR178156_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531062_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178186/ERR178186_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531062_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178186/ERR178186_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531063_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178207/ERR178207_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531063_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178207/ERR178207_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531064_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178157/ERR178157_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531064_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178157/ERR178157_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531065_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178194/ERR178194_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531065_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178194/ERR178194_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531066_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178209/ERR178209_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531066_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178209/ERR178209_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531068_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178208/ERR178208_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531068_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178208/ERR178208_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531070_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178185/ERR178185_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1531070_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR178/ERR178185/ERR178185_2.fastq.gz
```

Sanity check that the downloads look good (`_1.fastq.gz` and `_2.fastq.gz` files have the same number of reads):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/reads
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





# Unicycler assemblies

```bash
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies
for r1 in /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/reads/*_1.fastq.gz; do
    r2=${r1/_1.fastq.gz/_2.fastq.gz}
    s=$(echo "$r1" | grep -oP "SAM[EAN]+\d+")
    cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies
    mkdir "$s"; cd "$s"
    sbatch --job-name="$s" --time=0-4:00:00 --partition=genomics --qos=genomics --ntasks=1 --mem=64000 --cpus-per-task=8 --account md52 --wrap "module load spades/3.15.3; module load blast+/2.9.0; fastp --in1 "$r1" --in2 "$r2" --out1 illumina_1.fastq.gz --out2 illumina_2.fastq.gz --unpaired1 illumina_u.fastq.gz --unpaired2 illumina_u.fastq.gz; /home/rwic0002/programs/Unicycler/unicycler-runner.py -1 illumina_1.fastq.gz -2 illumina_2.fastq.gz -s illumina_u.fastq.gz -o unicycler --threads 8; rm illumina_*.fastq.gz"
done
```




# Read and assembly stats

Total read bases:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/reads
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
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies
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
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies
for s in SAM*; do
    size=$(fast_count "$s"/unicycler/assembly.fasta | cut -f3)
    echo $s"\t"$size
done
```

Assembly N50 (from fasta):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies
for s in SAM*; do
    n50=$(fast_count "$s"/unicycler/assembly.fasta | cut -f6)
    echo $s"\t"$n50
done
```

Assembly contigs (from fasta):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies
for s in SAM*; do
    n50=$(fast_count "$s"/unicycler/assembly.fasta | cut -f2)
    echo $s"\t"$n50
done
```

Assembly dead ends (from gfa):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies
for s in SAM*; do
    dead=$(deadends "$s"/unicycler/assembly.gfa)
    echo $s"\t"$dead
done
```




# Species check

Just to ensure that there were no mix-ups, I checked each assembly against the Kleborate species database:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies
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
All came back as _Escherichia coli_, as expected.




# QC

None of the assemblies failed any of my QC thresholds:
* fastp pass rate <10%
* Failed to assemble
* Assembly size >6 Mbp
* Assembly N50 <15 kbp
* Assembly graph dead ends >100

So I'm keeping all 196 - yay!

Going forward, I only need the assembly FASTAs, so I'll move the Unicycler files elsewhere and just copy out the final result:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS
mv assemblies assemblies_working_files
mkdir assemblies
cd assemblies_working_files
for s in SAM*; do
    cp "$s"/unicycler/assembly.fasta ../assemblies/"$s".fasta
done
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies
gzip *.fasta
```




# Reference genome

```bash
cd /projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/010/745/GCF_000010745.1_ASM1074v1/GCF_000010745.1_ASM1074v1_genomic.fna.gz
echo ">Reference" > Reference.fasta
seqtk seq GCF_000010745.1_ASM1074v1_genomic.fna.gz | head -n2 | tail -n1 >> Reference.fasta
rm GCF_000010745.1_ASM1074v1_genomic.fna.gz
```




# Final paths

* Assemblies: `/projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/assemblies/*.fasta.gz`
* Reads: `/projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/reads/*_[12].fastq.gz`
* Reference: `/projects/js66/individuals/ryan/Verticall_paper/E_coli_GEMS/Reference.fasta`
