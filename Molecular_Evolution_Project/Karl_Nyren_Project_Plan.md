# Project overview
The aim for the following project is to mimic a previous bioinformatic study to get a further understanding in the work flow as well as getting more familiar with the data used in such research. The paper that this project will work on is [Zhang et al. 2017](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-017-4299-9), where the group did a research on different fitness traits in a commensal bacteria *Enterococcus faecium* (*E. faecium*), in order to acquire further knowledge in how on in the future could attack the pathogenic properties of this bacterium. To do this they used a plethora of analytical tools and the combination of short (Illumina) and long (PacBio & Nanopore) reads. From this they assembled their own genome, and used expression data (RNA-seq) with the combination of transposon mutant library sequencing (Tn-seq) to infer the fitness of specific traits. Thus, in this project we will follow the steps 

# Chosen analysis and softwares to use
In the following section the tools and their purpose in the above mentioned article will be given.

## Genome assembly with PacBio reads.
Using the PacBio long reads data we don't use any quality checking tool. The reasong for this skip follows. Instead we channel this data into [Canu](https://canu.readthedocs.io/en/latest/) which is a de novo whole-genome shotgun assembler, replacing the Celera Assembler used in the paper (since Celera Assembler is decommissioned). As mentioned before, we skipped quality check and trimming since Canu does that for you. Following is some run of the required settings that will be used for Canu:
    
- Input is FASTA or FASTQ, uncompressed or compressed _Note: .zip is not supported_
- Approximate genome size, for coverage determination, and tech used for read generation. _

```shell
e.g canu -p <assembly-prefix> -d <assembly-directory> genomeSize=<number>[g|m|k] -pacbio-corrected/raw(if corrected or raw from the start)_
```

Correction is needed on the contigs, this will be a multiple step process integrating [BWA](http://bio-bwa.sourceforge.net/), [SAMtools](http://www.htslib.org/),and [Pilon](https://github.com/broadinstitute/pilon/wiki). 

- BWA will be run using multiple tools, index, mem and alignment. This will produce valid contigs, that can be used for further analysis in coverage.

```shell
$ bwa index ref.fa

$ bwa mem -M <ref.fa> <read1.fa> <read1.fa> > lane.sam
```

- Coverage of both the acquired assembly will be meassured with [SAMtools](http://www.htslib.org/) which is using short read alignments to the assembly created in the above BWA. SAMtools will report probable assembly and base-calling errors, which then can be corrected for.

```shell
# Format the alignments, find the format on the in file automatically by -S, b is output into bam file and -o
$ samtools view -Sb in.sam|in.bam|in.cram -o ~/home/user/out.bam

# Sort the alignment file before creating an index
$ samtools sort -O bam -o <lane_sorted.bam> -T </tmp/lane_temp> <lane_fixmate.sam>
# Finally create an index. 
$ samtools index -b aln.bam|aln.cram [out.index]
```
From this we will correct our assembly by using Pilon. Pilon requires FASTA in files along with the BAM files the FASTA file was aligned to.

```shell
$ pilon --genome genome.fasta --frags <frags.bam>
# --frags <frags.bam> for paired-end sequencing of DNA fragments, such as Illumina paired-end reads of fragment size <1000bp.
```

## Assembly evaluation
Visualize it in IGV, load Java, IGV, run IGV-node
To evaluate the assembly we are going to use both [QUAST](http://quast.sourceforge.net/) and [MUMmerplot](https://jmonlong.github.io/Hippocamplus/2017/09/19/mummerplots-with-ggplot2/) package in R.

## Structural and functional annotation
For structural and functional analysis we will use [Prokka](http://www.vicbioinformatics.com/software.prokka.shtml), this data will be needed later on when we are going to perform differential expression analysis. 

```shell
$ prokka --outdir mydir --prefix mygenome contigs.fa

# Visualize it in Artemis
$ art mydir/mygenome.gff
```

## Synteny comparison with a closely related genome
A Maximum Likelyhood Phylogenetic tree will be created using [ParSNP](https://harvest.readthedocs.io/en/latest/content/parsnp.html), using core genome of _E. faecium_ and 72 _E. Faecium_ strains. _Note: use -c  and -x_

## Reads preprocessing: Trimming + quality check (before and after)
We need to preprocess Illumina reads. As the title suggests, quality checking will be performed before and after the trimming process to observe posible events. 

   - We use [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) in order to observe if there are any major issues with the data. (_e.g zcat *fastq.gz | fastqc stdin:my_results --outdir=/some/special/dir_)

   - Run [Trimmomatic](http://www.usadellab.org/cms/index.php?page=trimmomatic) to crop and trim the fastq files for higher quality reads (_e.g java -jar <"path to trimmomatic.jar"> PE [-threads <"threads] [-phred33 | -phred64] [-trimlog <"logFile">] ">] [-basein <"inputBase"> | <"input 1"> <"input 2">] [-baseout <"outputBase"> | <"unpaired output 1"> <"paired output 2"> <"unpaired output 2"> <"step 1">_)

## RNA-Seq reads alignment against assembled genome
To identify the genes expresed in the _E. faecium_, RNA-seq reads will be alligned using [BWA](http://bio-bwa.sourceforge.net/). The process will be the same for these reads, since they are in cDNA format after Illumina processing, and as before quality and trimming is required before processing. 

## Differential expression analysis between rich medium and heat-inactivated serum conditions
Post BWA alignment differential expression is going to be calculated. This requires annotated data in combination with an analytical counting method. For this we will be using [Prokka](http://www.vicbioinformatics.com/software.prokka.shtml) data gathered above. Htseq is then used to count the expression data and from there we can start to draw conclusions in further analytical tools, such as R. 

# Time frame

#Data management plan

