# De novo RNA assembly
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

### Some errors
- Transcript with different coverage
There can be very high variation in coverage of genes. In e sample, they found that 5 % of the RNA is mRNA, which is low af. If we do DNA sequencing across genome we will get equal expressed genes, but RNA seq we get very different coverage. This makes it very hard if we get a gene from a part of a genome, but very low expressed, is it really expressed or not? 

How much do we need to sequence, depends on biological question, organism, pre-seq, sequence type we want to produce, and post-sequence data analysis. What people tend to do is to use previous data on how much to sequence, or we need to perform pilot experiments.

- Read coverage will be uneven across the transcripts length
Most due to technical infused bias, either in library prep. Due to RNA selection method, RNA-specific molecular biology, sequencing tech error(same as in DNA sequencing). So even though selection methods might be good for specific molecules, they are very much reducing the coverage of the sequencing.

Effects of sequence characteristics on coverage variability: 
Areas with less complexity has higher variability, probably due to variations in repeated sequences, due to library type prep, such as fragmentation steps or cDNA synthesis. GC-content is present in genes with higher variability when selection methods are present. Genes similar to rRNA, might get filtered out when we filter rRNA. 

- Reads with sequencing errors derived from a highly expressed transcript may be more abundant than correct reads from a transcript that is not highly expressed
Hard to differentiate between read variants/transcripts and errors by using cutoffs, decrease assembly graph complexity and computation time using normalisation and filtering of reads.

- Transcripts encoded by adjacent loci can overlap and thus can be erroneously fused to form a chimeric transcript
There are chimeric transcript type; cis or trans-self, how they are related to each other. Then there is also respective multi gene chimeras, involving as the name presumes multiple genes. We can have this due to contaminating DNA molecules. Resolving this is prior to sequencing is; Strand specific sequencing. Here we know which strand that was transcribed. Normally we don't know which strand that we have transcribed. We can achieve this strand specificity by multiple tricks, one of them is:
we do seq, fragment, and use random primers for second strand synthesis, and here we include dUTP so we can recognize which strand was transcribed and thus which strand that was used in the RNA. The output will be two reads, with one being the transcribed stand. Depends on the sequencing method a bit doe. 
Prokaryotes often have overlapping genes, they also have the ability to transcribe multiple genes into one long mRNA, so overlap is favored here. 

- Data structures need to accommodate multiple transcripts per locus, owing to alternative splicing
Example of the Trinity assembler:
The name comes from the fact it has three separate parts. They will normalize for you, reduces computation in graph structure, uses max coverage of 50. Recommend usage of min k-mer coverage
Inchworm - decompose reads into 25-mers, create hash-table of freq of k-mers. Next it identifies seed k-mer, which is the most abundant k-mer in the data set, and tries to extend this, in similar coverage, and after it cannot continue seed, it saves and removes the assembled contig. Continues with 2nd highest freq, and does this untill it cannot assemble any more. 
Chrysalis - tries to find different isoforms for a given read, by using overlap and previously mentioned contigs. Clusters contigs into probable genes related to them, then creates a de Bruijn graph for these clusters of contigs, one graph per gene. 
Butterfly - takes graphs above and simplifies it into areas without conflict, and read info to resolve the confilcts present. So in the end you will gain probable info for different transcripts. 

Trinity known for to many contigs, matter of then reducing the contigs. 

This is a k-mer based assembly, and what k-mer we should use depends on sequencing depth, high depth -> high k-mer, read error and complexity. Using longer k-mer for transcripts with high read depth.

## Assembly quality assessment
Examine RNA-seq read, so map the RNA-seq reads to the assembly and how much of the reads that are used in the contigs gained ~80% is good coverage. If not, could be low level DNA contamination, low expression. Examine representation of full-length reconstructed protein-coding genes, use like blast to a set of known protein sequenced before. Completeness of the assembly, see if the genes that should be there are actually there. Compute the E90N50, as well as computing quality scores.

The E90N50 is a weighted score. It first orders transcripts by normalising expression, then takes the N50 at 90 % of the total normalised expression data. 

