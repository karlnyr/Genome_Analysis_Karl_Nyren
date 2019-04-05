## Day-04-04-2019: 
Today I am getting set up for Canu, getting used to the data available. 
Today PacBio data is mainly of inportance 
```shell
$ ls /proj/g2019003/nobackup/private/1_Zhang_2017/genomics_data/PacBio/
m131023_233432_42174_c100519312550000001823081209281335_s1_X0.1.subreads.fastq.gz
m131023_233432_42174_c100519312550000001823081209281335_s1_X0.1.subreads.fastq.gz.save
m131023_233432_42174_c100519312550000001823081209281335_s1_X0.2.subreads.fastq.gz
m131023_233432_42174_c100519312550000001823081209281335_s1_X0.3.subreads.fastq.gz
m131024_200535_42174_c100563672550000001823084212221342_s1_p0.1.subreads.fastq.gz
m131024_200535_42174_c100563672550000001823084212221342_s1_p0.2.subreads.fastq.gz
m131024_200535_42174_c100563672550000001823084212221342_s1_p0.3.subreads.fastq.gz

$ ln -s /proj/g2019003/nobackup/private/1_Zhang_2017/genomics_data
```
Canu runs on a whole folder, thereby I will pass. I created a folder genomics_data, which is actually containing all the genomic data from the article. Tn-seq, Nanopore, Pacbio, Illumina short reads, you name it.

Genome size estimated to [3.1 Mbp](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3433357/)

```shell
$ canu -p Genome_Assembly_E745_3.1M -d /home/karlnyr/Molecular_Evolution/Genome_Assembly -pacbio-corrected /home/karlnyr/Molecular_Evolution/raw_data/genomics_data/PacBio/*gz
```
Submitted the above script with sbatch, now on to doing Illumina reads. First we perform a FastQC check, saving the data into metadata folder.
```shell
$ fastqc *fq.gz --outdir=/home/karlnyr/Molecular_Evolution/Metadata 
```
## Day-05-04-2019
Today, check the asembly. BWA-mem.

for BWA-mem, maybe use this code?
```shell
$ bwa mem ref.fa read1.fq read2.fq > aln-pe.sam
```
Due to issues with Canu, no files was had any content in the output. Thereby the only thing that had process was an elaboration of the project plan and running canu another time, with a few alterations to it, using the -l flag in the bash environment seemed to do the trick, now the assembly is done, next time we will check the assembly.  
