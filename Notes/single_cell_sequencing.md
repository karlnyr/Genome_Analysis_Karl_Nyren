# Single cell sequencing
What single cell sequencing(SSC) offers us is that most of the things going on in a cell occurs on a molecular level. We can resolve variation within cells, done for both RNA and DNA as well as for eukaryotes and prokaryotes, however RNA is a bit tricky in prokaryotes. We can do SSC de novo or re-sequencing. Same as metagenomic, its a culture independant method, used as an complement for metagenomics to get a better idea of function location ina population(combination of MAGs and SAGs). Requires amplification because there is not enough DNA and RNA in a single cell to sequence right of the bat. 

## Workflow
### Isolated cells
Keep cells intact. One could get single cells manually, laser microdissection machine. A much more common method is FACS that goes through a FACS machine, once we have a solution of cells we could have either marker genes that would pick for you. These three requires high volumes of sample, whilst microdroplets and microfluidics require way less sample. 
### Break apart cells, amplify material
after we got our extracted cell there are methods to amplify the material inside them. Some methods are pure PCR methods with general primers. An issue with PCR based methods is that we have a large false positivity rate, and some parts of the genome will be missing. This due to that there is no real primer that would create the same coverage for every organism. Coverage here is amount of the genome that is found or no. The pro of the PCR method is though that the coverage is uniform over the DNA. One common method is MDA, that uses polymerases, and random primers and strong strand displacement and also a branch structure in the DNA, an issue is overrepresentaiton in the output. Then there are hybrind methods, minimizing the errors in both methods above and thus help. 

#### MDA 
Phi29 DNA polymerase, has a high processive polymerase, can be attached to a molecule for a long time, able to build together >70kb fragments without falling of. It can strand displace, efficient isothermal amplification, has some proofreading activity and thus high accuracy in copying DNA. 

Som issues with MDA is that we end up having very variable coverage of the genome and chimera formation. Seems like the bias done in this amplification is due to not uniform amplification and it is not clear how much of the bias that is stochastic or not. What we do know is that depending on the amount of starting material will affect the variation in coverage, less material -> more variation.

We will also gain a lot of chimeric sequences, which is a specific strand displacement issue. They are however predictable in how they look. Happens in intervals as well. Not recommended to use long read tech because we get these edges into the informational data. 

### Effects of artifacts from amplification steps
When reconstructing as in de novo assemble, the droupout on coverage is a bad thing, will gain gaps. Uniform coverage is almost required here. Are we looking into CNVs, disease patterns and so on then variable coverage in amplification (and no due to biology) will be a bias in the analyses. when looking into SNVs we can have an issue if we get an drouput of an allele inside a chromosome. 

### Issues in de novo assembly and SSC
The uneven and very low coverage is going to be problematic when trying to assemble thee data. de Bruijn graphs are very error sensitive, errors make them more complex. We also get bad k-mer quality in low coverage regions, so some k-mers will be hard to determine if they are errors or not. In many algorithms we remove low coverage in graphs because the are assumed to be errors. For chimeric sequences, so all connections to a chimera are false because the amplified molecule looks different from what the genome did. 

Based on above issues, we could draw the conclusion that we need a new assembler for SSC data. 

#### Spades, for SSC assembly
Built for SSC genome data. Has a few tricks to specificly deal with uneven coverage issues. Uses error correction methods, normally they assume low freq k-mer are errors, not there though. The deal with low freq k-mer in hammer distances, and how k-mers are connected inside this graph created. They also use multiple k-mers lengths to create assembly graph. Another trick it uses is read pairs and a paired de Bruijn graph called rectangle graph and use this graph to confer the assembly de bruijn graph. Also has identifiers for features in the graph to see possible chimera formations. Finally it has integrated error correction method for constructed contigs, does this through BWA, align reads again to contigs to correct shit. 

### Evaluation of assembly, SAGs
One software called CheckM is able to evaluate assemblies. They do some preprocessing, but in the end they pretty much check if the genes that are believed to be there are actually in the assembled genome. Also estimates contamination, that is that we have assembled the same gene multiple times when it should not. 

## Pros and Cons SAGs and MAGs
Pros SSC- obtain info from individual cells, could obtain rare cell types with cell isolation with targeted approaches, reduced costs since you dont need that much sequencing, and low computational demands.
Cons SSC - Current throughput is low, high contamination risk, incomplete genomes, and other artefacts in amplification which may be hard to deal with in the end. 

## Single cell mRNA sequencing
Works similar to single cell genomics, but through reverse transcription then regular dna amplification. 

Basically there are two ways of reverse transcription, but all of them are currently based on polyA selection, thus targeted to Eukaryotes. It is a very specific method for that is using beads covered with primers, we mark one cell, with one bead, and then get the cells into droplets and then into RT-PCR, the primers have barcodes for identification and the transcriptase can switch from using RNA to DNA, pretty wierd but works, gains fragmented mRNA molecules, so we can't do de novo assembly from these. SmartSeq2 will fragment with a transposon instead, thus gaining the whole transcripts and thus we can get de novo assembly. Issues with SmartSeq2 is that we lose strand specificity and no information with barcodes. 

Also, amplification creates bias. Currently no de novo assembler for ssc transcriptomics, so most of the methods developed for ssc transcriptomics is based on mapping to reference. Today clustering analyses are often applied to the data.

A problem is that we want to discriminate between noice and actual biological data. Noice is very high in transcriptomics, and now they are trying to both reduce technological and biological noice. Various tricks for noice reduction, but some technical noice is dealt with by adding RNA in a known amount into a sample, this is used as control to know how much we should have gotten out of the amplification, can be used then for read count or molecular identifiers and then by an enrichment in identifier tells you have skewed multiplication. The final outcome is that we want to identify multiple cells at the same time, and then what are the differences in between the cells, which can of course be achieved in multiple ways. 
 
