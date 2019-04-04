#De novo RNA assembly
Transcriptomics are in general used for the expression information it contains. People tend to sample expression data in different tissues, even in singular cells, in order to find possible markers related or causal for a disease. 

What kind of question can we ask when performing RNA-seq experiments?
    * What parts of the genome are expressed?
    * Does transcript sequences look the same in the genome, and in that gene fusion detection or RNA editing possibilities. 
    * Most popular is probably at what levels and in what form are genes expressed, and then their function and such.

However, today we will be focusing on the de novo sequencing instead of the analysis. So why would we like to sequence RNA instead of DNA? The transcriptome is generally __smaller__ than the genome, and since a lot of genome is not transcribed the "not to functional" data could be avoided. It is less repetitive, we can combine to get a reference for functional studies, some features can only be observed at the RNA level (_e.g alternative isoforms, fusion transcripts, RNA editing_).
## Genes, transcripts and contigs
Once mRNA is expressed, we need to convert it into cDNA, because we cant sequence mRNA. We then break up the cDNA, and the gene in the end will be different than the genome, but will match with the mRNA. In eukaryotes we have alternative splicing, which can result in multiple isoforms. Complicating things in the algorithm since the graphs created will be overlapping a lot. 

What do we need to do before RNA seq?

1. What RNA molecules do we want to analyse? There are multiple types of RNA present in a cell, can be subdivided by mass, and a large part present in a cell is rRNA. rRNA is quite lacking in variation, so these molecules present are quite "uninteresting". 
2. So how do we select and determine quality? We take host, isolate RNA, and do analysis on quality. RNA degrades faster, so if we are not careful we will gain tons of degraded RNA. Ofter quality is determined by gel analysis, can estimate intactness of the RNA (_e.g grimm-score_).
3. Reduce trash RNA molecules, by either filtering methods etc, in order to gain a higher amount of coverage for the molecules you are interested in.

So in summary it is important to know how the data was gathered.

## RNA assembly
Problems particular are either through biology, tech or a combination of the two. And we counter these with either methods or algorithms.

###Some errors
- Transcript with different coverage
There can be very high variation in coverage of genes. In e sample, they found that 5 % of the RNA is mRNA, which is low af. If we do DNA sequencing across genome we will get equal expressed genes, but RNA seq we get very different coverage. This makes it very hard if we get a gene from a part of a genome, but very low expressed, is it really expressed or not? 

How much do we need to sequence, depends on biological question, organism, pre-seq, sequence type we want to produce, and post-sequence data analysis. What people tend to do is to use previous data on how much to sequence, or we need to perform pilot experiments.

- Read coverage will be uneven across the transcripts length


* Reads with sequencing errors derived from a highly expressed transcript may be more abundant than correct reads from a transctipt that is not highly expressed
* Transcripts encoded by adjacent loci can overlap

