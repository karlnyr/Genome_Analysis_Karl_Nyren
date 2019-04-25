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

## Day-11-04-2019

Copied the contigs.fasta to separate folder and ran the indexing and then the mapping with the Illumina DNA reads. 
```shell
$ module load bioinfo-tools
$ module load bwa/0.7.17
$ bwa index Genome_Assembly_V.2.contigs.fasta

$ bwa mem -M Genome_Assembly_V.2.contigs.fasta ~/path/to/Illumina/DNA/read1 ~/path/to/Illumina/DNA/read2 
```

```shell
$ module load samtools/1.9
$ samtools view -b Mapped_Assembly_1.sam -o Formatted_Alignments_1.bam
$ samtools sort -o Sorted_Alignment_1.bam  Formatted_Alignments_1.bam 
$ samtools index Sorted_Alignment_1.bam 
```
Thus I gained an indexed, sorted alignment file, was passed into pilon for correction and evaluation of contigs. 

```shell
$ module load Pilon/1.22
$ pilon --genome Genome_Assembly_V.2.contigs.fasta --frags Sorted_Alignment_1.bam 
```
Gained a total of 8 contigs, where the Illumina reads had mean total coverage of 71.

Onto evaluation of the assembly, first of: Quast

```shell
$ module load quast/4.5.4
# Quast is a python programe that is located inside rackham, thus the path is given
$ python /sw/apps/bioinfo/quast/4.5.4/rackham/bin/quast.py -o quast_results/results_assembled_contigs_110419 # Evaluation to assembled genome 
$ python /sw/apps/bioinfo/quast/4.5.4/rackham/bin/quast.py -R GCA_001750885.1_ASM175088v1_genomic.fna -o quast_results/results_reference_genome_110419 # Evaluation to reference genome
```

For genome annotation we pass the assembly through prokka.

```shell
$ module load prokka/1.12-12547ca
$ prokka --outdir /home/karlnyr/Molecular_Evolution/Annotation/DNA/Genome_Assembly --prefix annotated_assembly Corrected_Assembly_Pilon_v1.contigs.fasta
```

IGV is not working properly (might try to fix this later if Tn-seq analysis is run). For now post analysis will be done in QUAST.

## Day-12-04-2019
Checking the assembly in quast, the quast output was in HTML, easy to move around in. 

## Day-24-04-2019

The output Prokka annotational data is both functional and structural, showing us what genes are associated to specific gene loci and thus the function of the genes themselves. In terms of evaluation of the annotation one can look at the number of observed genes in the assembly and compare it to the papers genes. In our analysis ṕrokka found 3044 CDS and in the paper they found 3095, meaning we are missing 51 genes, either due to the fact that the assembly is not complete or Prokka had some issues finding the codings sequences. 

## Day-25-04-2019

Reaslized that we can do some cool stuff with synteny, will be using E. hirae to find vancomycin relationships, even though its not enough to make functionality calls of restistances we can try to make some cunclusions later on after we do some expressional analysis. We will also compare the assemblies again through synteny to see if there are any major concerning differences. 

```shell
$ module load blast/2.7.1+
$ module load artemis/16.0.0
$ blast_queries]$ blastn -query ~/Molecular_Evolution/Synteny/Assembly/Corrected_Assembly_Pilon_v1.contigs.fasta -db ~/Molecular_Evolution/Synteny/E_Hirae/GCA_000393835.1_Ente_hira_ATCC8043_V1_genomic.fna -evalue 1 -task megablast -outfmt 6 > Assembly_E_Hirae.crunch
$ blastn -query ~/Molecular_Evolution/Synteny/Assembly/Corrected_Assembly_Pilon_v1.contigs.fasta -db ~/Molecular_Evolution/Synteny/Paper_Assembly/GCA_001750885.1_ASM175088v1_genomic.fna -evalue 1 -task megablast -outfmt 6 > Assembly_E_Faecium.crunch
```

Now we have two alignments, lets put them into ACT to do a sidewise comparison. 
