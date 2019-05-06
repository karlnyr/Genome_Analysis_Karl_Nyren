# RNA-seq - Intro to workflow with mapping

The applications for RNA-seq could either be for expression, novel exon discovery, allele expressions or posttranslational RNA edits. 

## RNA-seq workflow
We go from hypothesis, RNA extraction, library generation, sequencing. Challanges could be related to many partf of the workflow. In __study design__ we see weakness in that transcription is context dependant. Sample prep is fragile to purity, quantity, quality and that RNA are very much varying in size. When __mapping__ mRNAs dont have introns, so the transcript is not equal to the ref genome, and then there are possible pseudo reads. 

### Design
Are we interested in highly or low level expression of genes. What tissue is of interest, if we don't know then we might try to find the one that is the most interesting one. If the signal is tissue specific this can be tricky because the signal can be diluted by a non-specific sample. Paired vs single end read might be important as well, for instance novel genes/splicing or isoforms we need paired-end reads. There are also'different kinds of mRNA so specific library prep is important, so in some cases we want higher sequencing depth, or even size selection for smaller RNAs. 

paired-ends are more expensive, so if we are only interested in differential and you have a well annotated genome then single end can be good enough. 

### Replication
Now we know that there is high variance, even in the same sample, when sequencing RNA. Now there is a recommendation for 6 samples for a single organism, but in some cases you get away with 3. Technical replications may be useful to reduce noise in the data, but this is not as common as doing biological replicates as mentioned above. 

### Sequencing depth
Number of reads sequenced in a given sample. Can depend to tech, transcriptome size, how many samples are sequences in the same lane. The number of replicates can really impact this, it may be better to increase samples (replicates) instead of the number of reads to spare some money. Some suggest that we can do pilot tests, especially when doing alternate splicing studying, to chop up data into coverage bins. 

## Mapping 
Specific things that can be an issue with RNA is that they dont have introns, and different transcripts can be expressed. When we align to the genome is then that the splice sites, so the reads that aligns to exons the aligner is able to do it properly, then there are the reads that cover an intronic section in a gene, messing everything up. Thats where paired-ends can really help. One can also say that wether you choose to align to a genome or transcriptome depend on the information present (e.g annotations, quality of reference genome/transcriptome). 

There are multiple tools for alignment, and they can be ruoghly categorized into either spliced or unspliced aligners, where the first mentioned takes exon-exon junctions in conseideration whilst the second don't. 

These are all based on 3 types:
- Hash tables
- suffix trees or
- merge sorting (less popular)

- __TopHat2__ - splice-aware aligner, runs bowtie to align reads. Bins align reads that maps perfectly to exons, then moves on to the un-aligned reads. Chops these up into fragments and works out where these fragments may land, and if these align to exons we can try to assertain their position. 
- __HiSat/HiSat2__ - different to TopHat, where TopHat does global indexing whereas HiSat does local searches in windows, not the whole genome thus faster. 

When mapping and we get multiple hits, or even worse, we get hits to another sequence than the actual one due to SNPs. What to do here is to either pick the best one, or keep all alignment (thus risking bias due to expression bias).

- __Quality assesment__ - Use of phred score to assess reads, 30 in score is commonly used, Nucleotide contet (deviations from exprected 25% of each nucleotide). Removal of duplicate reads? If DNA we can have dupes due to tech issues, RNA is different since we can have repetative ways to build function from a gene. Thus we often don't remove dupes from RNA data. There are some tradeoffs with preprocessing data, such as removing or chopping up lowd quality reads, especially if they are unique. We can get 3' or 5' biases, especially when doing poly A selection for mRNA. To check if a transcriptome is good or not, when should check where the reads align, and do they align to exons, how many genes do we have, do we find the species.

## Quantifying differential expression

What we get out from above is going to be a text file with a gene or transcript as an identyfier and the samples we have collected and they all have a count of the reads. 

However, what we would want is that the conditions of the hypothesis is the only thing that controls the expression of a gene but as with everything in life its not that easy. There may be GC bias or technical variability that affects the underlying biological signal. 

Since we are testing so many hypothesis when trying to see differences in all the genes extracted from an experiment, we thus most correct for this using Benjamini-Hochberg correction to control False Discovery Rate(FDR), or Bonferroni, but this is very rarely used due to the fact that it is too conservative. 
