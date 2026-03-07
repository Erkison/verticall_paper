# Paper

The data originally came from this paper: https://www.science.org/doi/full/10.1126/science.1198545
And then it was reused for recombination-filtering in this paper: https://academic.oup.com/nar/article/46/22/e134/5089898

The [supp data](https://www.science.org/doi/suppl/10.1126/science.1198545/suppl_file/1198545s2-rev.xls) has 241 samples, but 19 don't have years. I also decided to exclude the outgroup isolate (BM4200, ERS005337), because distance-based tree algorithms often struggle with distant outgroups, and these isolates have dates, so we can root using those instead (best root-to-tip correlation). This left me with 221 genomes.




# Prep directories

```bash
cd /scratch/kr58/ryan/Verticall_paper
mkdir S_pneumo_PMEN1

cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1
mkdir reads
mkdir assemblies
mkdir alignments
```




# Download reads

The [supp data](https://www.science.org/doi/suppl/10.1126/science.1198545/suppl_file/1198545s2-rev.xls) gives accessions as ERS numbers, but to download the reads, I needed BioSample accessions. I found that the ENA records were very strange for these BioSamples - most of them had multiple SRA runs, with the same SRA run often showing up in multiple BioSamples. For example, ERR019724 was associated with SAMEA677436, SAMEA677438, SAMEA677440, SAMEA677441, SAMEA677443, SAMEA677445, SAMEA677448 and SAMEA677748. This meant that I couldn't use [ENA's downloader tool](https://github.com/enasequence/ena-ftp-downloader) to get the reads.

I instead used NCBI, with a custom script to turn BioSample accessions into SRA run accessions. Even this was rough, as some caused the script to crash, as some BioSamples linked to lots of SRA runs, only one of which (e.g. ERR024236) linked back, causing mayhem. And others (e.g. SAMEA677615) had no SRA run linked in NCBI but _did_ with ENA (though I had to filter out the multiply-linked ones).

So it took a fair bit of manual curation to get the SRA records!

I managed to hack this together a script (using [this](https://askubuntu.com/a/547126)) to get a BioSample accession from each SRA sample:
```bash
for ers in ERS009226 ERS009778 ERS009779 ERS009780 ERS009781 ERS009788 ERS009785 ERS004773 ERS004775 ERS004791 ERS004779 ERS004778 ERS004781 ERS004844 ERS004880 ERS004845 ERS004846 ERS009227 ERS005718 ERS004814 ERS005339 ERS005341 ERS005342 ERS005340 ERS005344 ERS005343 ERS005345 ERS005347 ERS005295 ERS005293 ERS005273 ERS005274 ERS005275 ERS005276 ERS005278 ERS005277 ERS005281 ERS005279 ERS005271 ERS005272 ERS005280 ERS005282 ERS005284 ERS005287 ERS005288 ERS005316 ERS005307 ERS005269 ERS005308 ERS005289 ERS005290 ERS005270 ERS005285 ERS004799 ERS004800 ERS004802 ERS004804 ERS004789 ERS004797 ERS004796 ERS004798 ERS004787 ERS004795 ERS004794 ERS004806 ERS004808 ERS004801 ERS004803 ERS004805 ERS004807 ERS004782 ERS004780 ERS004783 ERS009222 ERS009221 ERS009218 ERS009211 ERS009212 ERS009220 ERS009217 ERS009213 ERS009214 ERS009215 ERS009219 ERS009216 ERS005283 ERS005323 ERS005324 ERS005319 ERS005322 ERS005327 ERS005325 ERS005331 ERS005318 ERS004784 ERS004785 ERS004776 ERS004777 ERS005268 ERS005256 ERS005265 ERS005267 ERS005259 ERS005249 ERS005266 ERS005247 ERS005719 ERS005264 ERS005260 ERS004830 ERS005185 ERS005714 ERS005190 ERS005189 ERS005193 ERS005191 ERS005196 ERS005188 ERS005192 ERS005194 ERS005195 ERS005201 ERS005204 ERS005206 ERS005199 ERS005202 ERS005209 ERS005213 ERS005219 ERS005210 ERS005227 ERS005228 ERS005244 ERS005235 ERS005236 ERS004873 ERS005291 ERS005292 ERS004875 ERS005286 ERS009210 ERS009209 ERS004788 ERS004790 ERS004786 ERS004792 ERS004833 ERS004832 ERS004835 ERS004836 ERS004838 ERS004837 ERS004841 ERS004839 ERS004840 ERS004842 ERS004843 ERS002795 ERS002796 ERS002797 ERS002798 ERS002781 ERS002782 ERS002783 ERS002784 ERS002785 ERS002787 ERS002788 ERS002789 ERS005364 ERS005375 ERS002790 ERS002791 ERS002792 ERS002793 ERS002794 ERS009223 ERS009224 ERS009225 ERS009229 ERS009228 ERS004821 ERS002800 ERS004823 ERS004811 ERS004809 ERS004810 ERS002799 ERS004815 ERS004881 ERS004816 ERS004817 ERS004818 ERS004819 ERS004882 ERS004824 ERS004825 ERS004826 ERS004827 ERS004828 ERS004829 ERS009230 ERS009201 ERS009202 ERS009203 ERS009204 ERS009205 ERS009206 ERS009207 ERS009208 ERS004762 ERS004767 ERS004774 ERS004771 ERS004759 ERS004753 ERS004756 ERS004765 ERS004769 ERS004761 ERS004793; do
    printf $ers"\t"$(phantomjs save_page.js https://www.ebi.ac.uk/ena/browser/view/"$ers" | grep -oP "SAM[EAN]+\d+" | uniq)"\n"
done
```

A few samples genuinely had multiple SRA runs, which I downloaded separately:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1931624_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR406/ERR406040/ERR406040_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA1931624_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR406/ERR406040/ERR406040_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA2042016_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR406/ERR406039/ERR406039_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA2042016_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR406/ERR406039/ERR406039_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677398_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024259/ERR024259_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677398_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024259/ERR024259_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677399_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016725/ERR016725_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677399_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016725/ERR016725_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677400_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016728/ERR016728_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677400_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016728/ERR016728_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677401_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016726/ERR016726_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677401_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016726/ERR016726_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677403_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016730/ERR016730_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677403_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016730/ERR016730_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677404_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016731/ERR016731_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677404_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016731/ERR016731_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677405_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016727/ERR016727_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677405_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016727/ERR016727_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677406_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016729/ERR016729_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677406_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016729/ERR016729_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677410_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016758/ERR016758_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677410_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016758/ERR016758_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677412_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016794/ERR016794_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677412_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016794/ERR016794_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677415_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024253/ERR024253_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677415_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024253/ERR024253_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677416_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024252/ERR024252_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677416_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024252/ERR024252_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677417_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016793/ERR016793_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677417_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016793/ERR016793_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677421_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016747/ERR016747_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677421_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016747/ERR016747_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677422_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024254/ERR024254_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677422_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024254/ERR024254_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677425_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024246/ERR024246_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677425_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024246/ERR024246_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677426_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024274/ERR024274_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677426_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024274/ERR024274_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677429_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024240/ERR024240_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677429_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024240/ERR024240_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677433_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016753/ERR016753_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677433_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016753/ERR016753_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677436a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019726/ERR019726_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677436a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019726/ERR019726_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677436b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019715/ERR019715_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677436b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019715/ERR019715_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677436c_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016852/ERR016852_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677436c_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016852/ERR016852_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677438a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019734/ERR019734_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677438a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019734/ERR019734_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677438b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019723/ERR019723_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677438b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019723/ERR019723_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677438c_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016860/ERR016860_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677438c_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016860/ERR016860_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677440a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019733/ERR019733_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677440a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019733/ERR019733_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677440b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019722/ERR019722_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677440b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019722/ERR019722_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677440c_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016859/ERR016859_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677440c_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016859/ERR016859_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677441a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019732/ERR019732_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677441a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019732/ERR019732_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677441b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019721/ERR019721_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677441b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019721/ERR019721_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677441c_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016858/ERR016858_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677441c_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016858/ERR016858_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677443a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019731/ERR019731_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677443a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019731/ERR019731_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677443b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019720/ERR019720_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677443b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019720/ERR019720_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677443c_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016857/ERR016857_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677443c_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016857/ERR016857_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677445a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019730/ERR019730_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677445a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019730/ERR019730_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677445b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019719/ERR019719_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677445b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019719/ERR019719_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677445c_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016856/ERR016856_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677445c_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016856/ERR016856_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677448a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019728/ERR019728_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677448a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019728/ERR019728_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677448b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019717/ERR019717_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677448b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019717/ERR019717_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677448c_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016854/ERR016854_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677448c_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016854/ERR016854_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677450_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016698/ERR016698_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677450_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016698/ERR016698_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677451_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016697/ERR016697_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677451_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016697/ERR016697_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677452_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016696/ERR016696_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677452_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016696/ERR016696_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677453_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016635/ERR016635_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677453_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016635/ERR016635_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677454_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016692/ERR016692_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677454_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016692/ERR016692_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677456_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016640/ERR016640_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677456_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016640/ERR016640_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677458_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024243/ERR024243_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677458_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024243/ERR024243_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677459_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016699/ERR016699_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677459_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016699/ERR016699_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677460_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016700/ERR016700_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677460_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016700/ERR016700_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677466_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024239/ERR024239_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677466_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024239/ERR024239_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677468_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016774/ERR016774_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677468_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016774/ERR016774_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677469_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016752/ERR016752_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677469_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016752/ERR016752_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677470_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016751/ERR016751_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677470_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016751/ERR016751_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677471_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016750/ERR016750_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677471_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016750/ERR016750_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677473_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016757/ERR016757_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677473_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016757/ERR016757_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677474_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016754/ERR016754_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677474_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016754/ERR016754_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677475_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016777/ERR016777_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677475_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016777/ERR016777_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677476_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024242/ERR024242_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677476_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024242/ERR024242_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677483_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024212/ERR024212_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677483_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024212/ERR024212_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677485_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024214/ERR024214_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677485_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024214/ERR024214_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677486_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016756/ERR016756_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677486_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016756/ERR016756_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677487_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016738/ERR016738_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677487_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016738/ERR016738_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677488_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016739/ERR016739_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677488_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016739/ERR016739_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677489_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016684/ERR016684_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677489_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016684/ERR016684_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677491_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016687/ERR016687_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677491_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016687/ERR016687_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677492_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024258/ERR024258_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677492_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024258/ERR024258_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677494_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016688/ERR016688_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677494_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016688/ERR016688_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677495_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016689/ERR016689_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677495_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016689/ERR016689_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677496_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016682/ERR016682_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677496_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016682/ERR016682_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677497_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016690/ERR016690_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677497_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016690/ERR016690_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677498_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016706/ERR016706_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677498_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016706/ERR016706_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677500_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024244/ERR024244_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677500_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024244/ERR024244_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677503_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016773/ERR016773_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677503_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016773/ERR016773_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677504_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024245/ERR024245_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677504_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024245/ERR024245_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677505_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024230/ERR024230_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677505_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024230/ERR024230_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677507_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016769/ERR016769_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677507_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016769/ERR016769_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677508_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016771/ERR016771_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677508_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016771/ERR016771_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677510_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016766/ERR016766_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677510_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016766/ERR016766_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677512_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016765/ERR016765_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677512_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016765/ERR016765_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677513_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016737/ERR016737_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677513_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016737/ERR016737_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677514_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018822/ERR018822_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677514_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018822/ERR018822_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677515_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024247/ERR024247_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677515_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024247/ERR024247_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677516_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016735/ERR016735_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677516_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016735/ERR016735_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677517a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023430/ERR023430_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677517a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023430/ERR023430_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677517b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023452/ERR023452_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677517b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023452/ERR023452_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677518a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023436/ERR023436_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677518a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023436/ERR023436_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677518b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023458/ERR023458_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677518b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023458/ERR023458_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677519_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024249/ERR024249_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677519_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024249/ERR024249_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677520a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023432/ERR023432_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677520a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023432/ERR023432_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677520b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023454/ERR023454_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677520b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023454/ERR023454_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677521a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023431/ERR023431_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677521a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023431/ERR023431_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677521b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023453/ERR023453_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677521b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023453/ERR023453_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677522a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023429/ERR023429_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677522a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023429/ERR023429_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677522b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023451/ERR023451_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677522b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023451/ERR023451_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677523_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024261/ERR024261_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677523_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024261/ERR024261_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677524_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016744/ERR016744_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677524_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016744/ERR016744_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677525a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023435/ERR023435_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677525a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023435/ERR023435_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677525b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023457/ERR023457_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677525b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023457/ERR023457_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677526a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023434/ERR023434_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677526a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023434/ERR023434_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677526b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023456/ERR023456_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677526b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023456/ERR023456_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677527a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023433/ERR023433_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677527a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023433/ERR023433_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677527b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023455/ERR023455_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677527b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023455/ERR023455_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677528_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016741/ERR016741_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677528_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016741/ERR016741_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677529_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016740/ERR016740_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677529_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016740/ERR016740_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677530a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023438/ERR023438_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677530a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023438/ERR023438_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677530b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023460/ERR023460_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677530b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023460/ERR023460_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677531a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023437/ERR023437_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677531a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023437/ERR023437_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677531b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023459/ERR023459_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677531b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023459/ERR023459_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677532_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024256/ERR024256_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677532_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024256/ERR024256_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677533_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016711/ERR016711_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677533_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016711/ERR016711_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677534_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016710/ERR016710_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677534_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016710/ERR016710_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677535_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016712/ERR016712_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677535_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016712/ERR016712_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677536_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016705/ERR016705_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677536_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016705/ERR016705_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677537_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016707/ERR016707_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677537_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016707/ERR016707_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677538_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016709/ERR016709_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677538_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016709/ERR016709_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677539_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016708/ERR016708_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677539_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016708/ERR016708_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677540_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016761/ERR016761_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677540_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016761/ERR016761_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677541_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023230/ERR023230_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677541_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023230/ERR023230_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677542_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016719/ERR016719_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677542_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016719/ERR016719_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677543_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016841/ERR016841_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677543_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016841/ERR016841_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677544_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016844/ERR016844_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677544_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016844/ERR016844_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677545_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016846/ERR016846_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677545_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016846/ERR016846_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677546_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016847/ERR016847_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677546_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016847/ERR016847_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677547_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016843/ERR016843_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677547_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016843/ERR016843_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677548_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016845/ERR016845_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677548_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016845/ERR016845_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677549_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016839/ERR016839_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677549_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016839/ERR016839_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677550_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016840/ERR016840_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677550_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016840/ERR016840_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677551_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016848/ERR016848_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677551_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016848/ERR016848_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677552_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016849/ERR016849_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677552_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016849/ERR016849_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677553_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016656/ERR016656_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677553_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016656/ERR016656_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677554_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016646/ERR016646_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677554_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016646/ERR016646_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677555_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016658/ERR016658_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677555_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016658/ERR016658_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677556_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016647/ERR016647_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677556_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016647/ERR016647_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677557_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016654/ERR016654_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677557_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016654/ERR016654_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677558_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016652/ERR016652_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677558_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016652/ERR016652_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677559_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016655/ERR016655_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677559_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016655/ERR016655_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677560_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016653/ERR016653_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677560_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016653/ERR016653_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677562_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016661/ERR016661_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677562_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016661/ERR016661_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677563_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016648/ERR016648_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677563_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016648/ERR016648_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677564_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024278/ERR024278_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677564_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024278/ERR024278_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677565a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023444/ERR023444_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677565a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023444/ERR023444_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677565b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023422/ERR023422_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677565b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023422/ERR023422_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677566a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023445/ERR023445_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677566a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023445/ERR023445_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677566b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023423/ERR023423_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677566b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023423/ERR023423_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677568a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023447/ERR023447_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677568a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023447/ERR023447_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677568b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023425/ERR023425_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677568b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023425/ERR023425_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677569_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016734/ERR016734_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677569_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016734/ERR016734_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677570a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023440/ERR023440_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677570a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023440/ERR023440_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677570b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023418/ERR023418_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677570b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023418/ERR023418_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677571a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023442/ERR023442_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677571a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023442/ERR023442_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677571b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023420/ERR023420_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677571b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023420/ERR023420_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677572a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023443/ERR023443_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677572a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023443/ERR023443_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677572b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023421/ERR023421_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677572b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023421/ERR023421_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677573a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023448/ERR023448_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677573a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023448/ERR023448_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677573b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023426/ERR023426_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677573b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023426/ERR023426_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677574a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023449/ERR023449_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677574a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023449/ERR023449_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677574b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023427/ERR023427_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677574b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023427/ERR023427_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677575_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016736/ERR016736_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677575_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016736/ERR016736_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677577_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016641/ERR016641_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677577_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016641/ERR016641_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677579_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019703/ERR019703_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677579_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019703/ERR019703_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677580_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019702/ERR019702_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677580_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019702/ERR019702_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677583_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016637/ERR016637_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677583_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016637/ERR016637_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677585_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016639/ERR016639_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677585_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016639/ERR016639_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677586_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016685/ERR016685_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677586_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016685/ERR016685_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677587_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016828/ERR016828_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677587_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016828/ERR016828_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677588_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016838/ERR016838_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677588_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016838/ERR016838_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677589_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016830/ERR016830_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677589_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016830/ERR016830_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677590_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016829/ERR016829_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677590_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016829/ERR016829_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677591_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016832/ERR016832_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677591_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016832/ERR016832_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677592_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016831/ERR016831_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677592_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016831/ERR016831_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677595_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016836/ERR016836_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677595_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016836/ERR016836_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677597_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016645/ERR016645_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677597_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016645/ERR016645_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677599_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023228/ERR023228_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677599_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023228/ERR023228_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677601_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016703/ERR016703_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677601_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016703/ERR016703_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677603_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016702/ERR016702_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677603_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016702/ERR016702_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677606_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024231/ERR024231_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677606_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024231/ERR024231_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677608_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016650/ERR016650_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677608_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016650/ERR016650_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677609_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023231/ERR023231_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677609_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023231/ERR023231_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677611_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016651/ERR016651_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677611_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016651/ERR016651_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677612_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024257/ERR024257_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677612_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024257/ERR024257_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677613_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016809/ERR016809_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677613_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016809/ERR016809_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677615_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024282/ERR024282_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677615_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024282/ERR024282_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677622_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016681/ERR016681_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677622_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016681/ERR016681_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677627_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016826/ERR016826_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677627_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016826/ERR016826_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677634_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018819/ERR018819_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677634_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018819/ERR018819_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677638_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016695/ERR016695_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677638_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016695/ERR016695_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677639_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018829/ERR018829_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677639_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018829/ERR018829_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677641_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024272/ERR024272_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677641_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024272/ERR024272_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677642_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024276/ERR024276_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677642_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024276/ERR024276_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677643_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024264/ERR024264_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677643_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024264/ERR024264_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677646_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016716/ERR016716_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677646_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016716/ERR016716_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677652_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024241/ERR024241_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677652_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024241/ERR024241_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677654_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016714/ERR016714_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677654_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016714/ERR016714_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677655_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024255/ERR024255_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677655_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024255/ERR024255_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677656_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016693/ERR016693_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677656_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016693/ERR016693_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677657_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024277/ERR024277_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677657_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024277/ERR024277_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677659_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016665/ERR016665_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677659_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016665/ERR016665_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677660_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024269/ERR024269_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677660_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024269/ERR024269_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677662_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016802/ERR016802_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677662_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016802/ERR016802_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677664_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016694/ERR016694_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677664_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016694/ERR016694_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677665_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016813/ERR016813_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677665_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016813/ERR016813_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677670_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016743/ERR016743_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677670_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016743/ERR016743_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677672_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016823/ERR016823_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677672_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016823/ERR016823_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677674_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018823/ERR018823_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677674_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018823/ERR018823_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677675_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018821/ERR018821_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677675_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018821/ERR018821_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677676_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018824/ERR018824_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677676_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018824/ERR018824_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677677_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018825/ERR018825_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677677_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018825/ERR018825_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677678_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018826/ERR018826_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677678_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018826/ERR018826_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677681_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016755/ERR016755_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677681_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016755/ERR016755_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677682_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016825/ERR016825_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677682_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016825/ERR016825_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677684_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016720/ERR016720_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677684_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016720/ERR016720_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677686_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016721/ERR016721_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677686_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016721/ERR016721_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677687_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024262/ERR024262_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677687_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024262/ERR024262_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677688a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023441/ERR023441_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677688a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023441/ERR023441_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677688b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023419/ERR023419_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677688b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR023/ERR023419/ERR023419_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677689_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016670/ERR016670_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677689_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016670/ERR016670_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677690_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016660/ERR016660_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677690_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016660/ERR016660_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677691_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016649/ERR016649_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677691_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016649/ERR016649_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677692_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016662/ERR016662_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677692_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016662/ERR016662_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677693_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016663/ERR016663_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677693_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016663/ERR016663_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677694_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016666/ERR016666_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677694_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016666/ERR016666_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677695_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016664/ERR016664_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677695_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016664/ERR016664_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677696_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016667/ERR016667_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677696_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016667/ERR016667_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677698_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016668/ERR016668_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677698_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016668/ERR016668_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677699_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016659/ERR016659_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677699_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016659/ERR016659_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677701_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016732/ERR016732_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677701_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016732/ERR016732_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677702_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019705/ERR019705_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677702_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019705/ERR019705_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677707_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019708/ERR019708_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677707_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019708/ERR019708_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677708_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019710/ERR019710_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677708_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019710/ERR019710_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677712_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016701/ERR016701_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677712_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016701/ERR016701_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677714_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016842/ERR016842_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677714_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016842/ERR016842_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677716_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016800/ERR016800_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677716_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016800/ERR016800_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677722_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018828/ERR018828_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677722_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR018/ERR018828/ERR018828_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677724_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024267/ERR024267_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677724_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024267/ERR024267_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677727_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024268/ERR024268_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677727_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024268/ERR024268_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677730_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024265/ERR024265_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677730_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024265/ERR024265_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677733_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024266/ERR024266_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677733_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024266/ERR024266_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677735_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024251/ERR024251_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677735_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024251/ERR024251_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677737_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016745/ERR016745_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677737_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016745/ERR016745_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677740_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024263/ERR024263_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677740_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024263/ERR024263_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677742_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024250/ERR024250_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677742_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024250/ERR024250_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677744_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016742/ERR016742_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677744_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016742/ERR016742_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677746_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024270/ERR024270_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677746_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR024/ERR024270/ERR024270_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677747_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016671/ERR016671_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677747_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016671/ERR016671_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677748a_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019725/ERR019725_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677748a_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019725/ERR019725_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677748b_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019714/ERR019714_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677748b_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR019/ERR019714/ERR019714_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677748c_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016851/ERR016851_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677748c_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016851/ERR016851_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677750_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016782/ERR016782_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677750_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016782/ERR016782_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677751_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016672/ERR016672_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677751_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016672/ERR016672_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677752_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016673/ERR016673_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677752_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016673/ERR016673_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677753_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016678/ERR016678_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677753_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016678/ERR016678_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677754_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016679/ERR016679_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677754_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016679/ERR016679_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677755_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016676/ERR016676_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677755_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016676/ERR016676_2.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677756_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016677/ERR016677_1.fastq.gz
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 -O SAMEA677756_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR016/ERR016677/ERR016677_2.fastq.gz
```

Sanity check that the downloads look good (`_1.fastq.gz` and `_2.fastq.gz` files have the same number of reads):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads
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

I assembled each read set with Unicycler. Samples with multiple read sets were assembled separately:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
for r1 in /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads/*_1.fastq.gz; do
    r2=${r1/_1.fastq.gz/_2.fastq.gz}
    s=$(echo "$r1" | grep -oP "SAM[EAN]+\d+a?b?c?")
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
    mkdir "$s"; cd "$s"
    sbatch --job-name="$s" --time=0-4:00:00 --partition=genomics --qos=genomics --ntasks=1 --mem=64000 --cpus-per-task=8 --account md52 --wrap "module load spades/3.15.3; module load blast+/2.9.0; fastp --in1 "$r1" --in2 "$r2" --out1 illumina_1.fastq.gz --out2 illumina_2.fastq.gz --unpaired1 illumina_u.fastq.gz --unpaired2 illumina_u.fastq.gz; /home/rwic0002/programs/Unicycler/unicycler-runner.py -1 illumina_1.fastq.gz -2 illumina_2.fastq.gz -s illumina_u.fastq.gz -o unicycler --threads 8; rm illumina_*.fastq.gz"
done
```




# Choose best read set

There were multiple read sets for some samples, and I decided to just use a single best one for each (i.e. not pool them in case there was heterogeneity between sets). I used assembly N50 (higher is better) to decide which read set was best, and if there was a tie I broke it with read depth (higher is better).

```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
for s in $(ls | grep -P "SAM[EAN]+\d+[abc]"); do
    n50=$(fast_count "$s"/unicycler/assembly.fasta | cut -f6)
    echo $s"\t"$n50
done
```

Here are the assembly N50s, with a star indicating best:

| sample      | A      | B      | C      |
|-------------|--------|--------|--------|
| SAMEA677436 | 48085* | 11870  | 42441  |
| SAMEA677438 | failed | 13032  | 42441* |
| SAMEA677440 | 53376* | 11391  | 50559  |
| SAMEA677441 | 50631* | 9503   | 45995  |
| SAMEA677443 | 47746* | 13282  | 45232  |
| SAMEA677445 | 45233  | 8320   | 45968* |
| SAMEA677448 | 41287* | 7585   | 38739  |
| SAMEA677517 | 42961* | 38741  |        |
| SAMEA677518 | 48085* | 42202  |        |
| SAMEA677520 | 49174* | 48998  |        |
| SAMEA677521 | 38667* | 34775  |        |
| SAMEA677522 | 48085* | 45010  |        |
| SAMEA677525 | 48085  | 55043* |        |
| SAMEA677526 | 48085  | 48914* |        |
| SAMEA677527 | 48856* | 47642  |        |
| SAMEA677530 | 45555* | 38687  |        |
| SAMEA677531 | 45010  | 45121* |        |
| SAMEA677565 | 50554* | 48172  |        |
| SAMEA677566 | 45121* | 42672  |        |
| SAMEA677568 | 48085  | 56687* |        |
| SAMEA677570 | 63359* | 41570  |        |
| SAMEA677571 | 47642* | 45622  |        |
| SAMEA677572 | 46964  | 48085* |        |
| SAMEA677573 | 42417* | 39296  |        |
| SAMEA677574 | 42446  | 44661* |        |
| SAMEA677688 | 42202* | 34707  |        |
| SAMEA677748 | 38687  | 6501   | 45968* |

For assemblies and reads, I renamed the best set to not have a letter and moved the others into an `unused` directory:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
mkdir unused
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads
mkdir unused

# assembly A is the best
for s in SAMEA677436 SAMEA677440 SAMEA677441 SAMEA677443 SAMEA677448 SAMEA677517 SAMEA677518 SAMEA677520 SAMEA677521 SAMEA677522 SAMEA677527 SAMEA677530 SAMEA677565 SAMEA677566 SAMEA677570 SAMEA677571 SAMEA677573 SAMEA677688; do
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
    mv "$s"a "$s"; mv "$s"[bc] unused
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads
    mv "$s"a_1.fastq.gz "$s"_1.fastq.gz; mv "$s"a_2.fastq.gz "$s"_2.fastq.gz; mv "$s"[bc]_[12].fastq.gz unused
done

# assembly B is the best
for s in SAMEA677525 SAMEA677526 SAMEA677531 SAMEA677568 SAMEA677572 SAMEA677574; do
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
    mv "$s"b "$s"; mv "$s"[ac] unused
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads
    mv "$s"b_1.fastq.gz "$s"_1.fastq.gz; mv "$s"b_2.fastq.gz "$s"_2.fastq.gz; mv "$s"[ac]_[12].fastq.gz unused
done

# assembly C is the best
for s in SAMEA677438 SAMEA677445 SAMEA677748; do
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
    mv "$s"c "$s"; mv "$s"[ab] unused
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads
    mv "$s"c_1.fastq.gz "$s"_1.fastq.gz; mv "$s"c_2.fastq.gz "$s"_2.fastq.gz; mv "$s"[ab]_[12].fastq.gz unused
done
```




# Read and assembly stats

Total read bases:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads
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
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
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
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
for s in SAM*; do
    size=$(fast_count "$s"/unicycler/assembly.fasta | cut -f3)
    echo $s"\t"$size
done
```

Assembly N50 (from fasta):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
for s in SAM*; do
    n50=$(fast_count "$s"/unicycler/assembly.fasta | cut -f6)
    echo $s"\t"$n50
done
```

Assembly contigs (from fasta):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
for s in SAM*; do
    n50=$(fast_count "$s"/unicycler/assembly.fasta | cut -f2)
    echo $s"\t"$n50
done
```

Assembly dead ends (from gfa):
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
for s in SAM*; do
    dead=$(deadends "$s"/unicycler/assembly.gfa)
    echo $s"\t"$dead
done
```




# QC

I rejected samples where any of the following was true:
* fastp pass rate <10% (none)
* Failed to assemble (2 assemblies)
* Assembly size >2.5 Mbp (none)
* Assembly N50 <15 kbp (20 assemblies)
* Assembly graph dead ends >100 (44 assemblies)

I didn't need a read depth filter, because anything with a bad read depth (e.g. <30x) already failed one of the other criteria.

```bash
mkdir /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies/qc_fail
mkdir /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads/qc_fail

for s in SAMEA677399 SAMEA677401 SAMEA677403 SAMEA677410 SAMEA677421 SAMEA677422 SAMEA677452 SAMEA677453 SAMEA677454 SAMEA677456 SAMEA677470 SAMEA677489 SAMEA677494 SAMEA677496 SAMEA677497 SAMEA677498 SAMEA677505 SAMEA677507 SAMEA677512 SAMEA677514 SAMEA677534 SAMEA677544 SAMEA677553 SAMEA677554 SAMEA677555 SAMEA677556 SAMEA677557 SAMEA677558 SAMEA677559 SAMEA677563 SAMEA677575 SAMEA677577 SAMEA677579 SAMEA677580 SAMEA677583 SAMEA677585 SAMEA677586 SAMEA677590 SAMEA677591 SAMEA677592 SAMEA677601 SAMEA677608 SAMEA677611 SAMEA677613 SAMEA677622 SAMEA677659 SAMEA677681 SAMEA677689 SAMEA677690 SAMEA677691 SAMEA677692 SAMEA677693 SAMEA677694 SAMEA677695 SAMEA677696 SAMEA677699 SAMEA677702 SAMEA677707 SAMEA677708 SAMEA677747 SAMEA677751 SAMEA677752 SAMEA677753 SAMEA677754 SAMEA677755 SAMEA677756; do
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads
    mv "$s"_*.fastq.gz qc_fail
    cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
    mv "$s" qc_fail
done
```
This left me with 154 assemblies.

Going forward, I only need the assembly FASTAs, so I'll move the Unicycler files elsewhere and just copy out the final result:
```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1
mv assemblies assemblies_working_files
mkdir assemblies
cd assemblies_working_files
for s in SAM*; do
    cp "$s"/unicycler/assembly.fasta ../assemblies/"$s".fasta
done
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies
gzip *.fasta
```




# Reference genome

```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/026/665/GCF_000026665.1_ASM2666v1/GCF_000026665.1_ASM2666v1_genomic.fna.gz
echo ">Reference" > Reference.fasta
seqtk seq GCF_000026665.1_ASM2666v1_genomic.fna.gz | head -n2 | tail -n1 >> Reference.fasta
rm GCF_000026665.1_ASM2666v1_genomic.fna.gz
```



# Scale trees

There is a group of 25 isolates which seem pretty close to each other in the Snippy tree (i.e. without recombination filtering), so I'm going to use them to scale the tree distances for the BactDating figure.

```bash
cd /projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies

files=(SAMEA677398 SAMEA677405 SAMEA677415 SAMEA677416 SAMEA677518 SAMEA677519 SAMEA677522 SAMEA677524 SAMEA677526 SAMEA677543 SAMEA677545 SAMEA677546 SAMEA677547 SAMEA677548 SAMEA677551 SAMEA677552 SAMEA677565 SAMEA677566 SAMEA677612 SAMEA677634 SAMEA677654 SAMEA677655 SAMEA677687 SAMEA677714 SAMEA677740)
max=${#files[@]}

for ((i=1; i<=max; i++)); do
    for ((j=i+1; j<=max; j++)); do
        catpac.py --minreldepth 0.5 --maxreldepth 1.5 "$files[$i]".fasta "$files[$j]".fasta
        printf $files[$i]"\t"$files[$j]"\t" >> snp_counts
        grep -c "SNP" catpac_variants.csv >> snp_counts
        rm catpac_*
    done
done

sort -nk3,3 snp_counts | cut -f3 | awk '{a[i++]=$1;} END {print a[int(i/2)];}'  # get the median SNP count
```

The median pairwise SNP count in this group was 92.




# Final paths

* Assemblies: `/projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/assemblies/*.fasta.gz`
* Reads: `/projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/reads/*_[12].fastq.gz`
* Reference: `/projects/js66/individuals/ryan/Verticall_paper/S_pneumo_PMEN1/Reference.fasta`
