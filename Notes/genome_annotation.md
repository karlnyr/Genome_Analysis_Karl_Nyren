# Genome Annotation
## Prokaryotic
Genome annotations specify what kind of information the scientists have been able to retrieve about a specific loci in the genome of an organism. 

To identify function in sectuence we can probably find some selective pressure. When we do structural annotation we always have to determine the selection and if it is caused by random drift or not. So if there is not drift we can with some certainty say that the sequence has a function. One way to observe sequence perserverence we could look at probabilities of nucleotide frequency. 

### Structural annotation
#### Non-coding sequences - rRNA and tRNA
Assosiation to ribosomal and translational functions and are very conserved and/or structured. tRNA has three different binding loops, can be used to determine tRNAs from sequence. tRNA software called tRNAscan, basically uses descision tree, and uses the most conserved features of the tRNA to find these molecules. It is easily predicted since they have determined length and structure. This process is normally not an issue, but start with this so that we know where to not do an deeper and more demanding sequence analysis. 

#### Protein coding genes
six possible reading frame depending on shift of -3 to +3, in eukaryotes we have introns and exons, whilst prokaryotes don't thus prokaryotes is ORF = gene. One can draw deductions with good certainty only if there is a longer ORF present. So an ORF with 3 bases is probably not a gene whilst a 1000 bp one is more likely to be one. 

There is also a relationship of genome comp and how it determines codons position. there is harder selection on the two first positions because they are often non-synonymous mutations. Not only does GC content affect codon position. Some amino acids are more AT enriched, and thus the GC content affects the usage of an amino acid in its proteins. If we divide aa into GC and GC poor codons. The usage of specific aa in coding regions are affected by GC contents. So by information on how likely a organism is to use a amino acid we can weigh it in for how likely a gene is to occur depending on the codons in the region. 

Gene prediction software uses these weights of used amino acids. Uses dicodon occurences, or hexamers, a good measurement since it contain codon usage, di-nucleotides(specific to genome), amino acid composition(location to one) and these together seem to work great together. They all have first some training set, on how a gene is supposed to look like in the organism and then builds a model on how a gene is supposed to look based on the long genes. 

Challanges for the prokarotic gene  prediction is false or true genes when it comes to small ORF, where false positives recks functinality and false negative creates missing data. 

Prodigal is a software that follows the principles as above. Create training set that we are sure that they are true genes. in high GC content genomes, we have less stop codons (they are AT rich) thus we have a longer ORF gain and thus the more probable finds of genes through a good training data set in prodigal.

Power of comparative genomics, comparison is useful for function and correction in the annotation. can not only be used to infer function but also to check an genome assembly, there may be gaps which consists of "missing data" inside you assembly and thus the alignment tot he reference will be of. 

## Eukaryotic
### Structural

Has splicing, additions of informations post translation. Different from prokaryotic, since we have multiple exon, thus we don't have start and stop for the gene. Instead we need to look at the exon and their splice sites, so indications of splices are key. Depending on how we define an exon, but if its an mRNA then they might not contain a lot of coding material. 

When we talk about ab initio prediction in prokaryotes we look at distributions of genes, longer is better power. In eukaryotes exons are shorter and thus harder to predict. Genes are not equal to a protein in eukaryotes, so even if we predict an exons we don't predict the protein. An difficulty with splicing to create prediction is that splice sites are not conserved. Eukaryotes don't have specified promoters, so to find start sites we look at either core promoters, so reasons that eukaryotic genomes are hard to annotate is because they have short coding exons, non-conserved splice sites, and variability in upstream regions. So to perform a proper annotation a combination is required. 

Larger genomes also have longer genes, requiring longer contigs from assembly in order to make a good estimation on how the contigs belong together. 

Depending on money and underlying information will determine the accuracy only if the resources are out down into them. ab initio is quick and cheap, but the prediction is often very inaccurate.This could be fine if you are not making a whole case study in a few genes. One could also make multiple prediction models to then choose the best one fitting the genome. 

for annotation in NCBI they recommend you to use RNA-seq data, nucleotide data (sequences from even other organisms since the sequences are going to be full length genes and thus they gather longer RNA fragments), they also use protein information (from other organism can be used too since amino acid constituents are conserved). use the possible gene and then search Swissprot database for predicted genes, and then they want to choose the best model for the genome. If the predictions that comes out from Swissprot hits (called Gnomon) we search for existent hits in RefSeq and if they don't match we will use RefSeq, and if they have evidence from Swissprot only we can include it. 

If we also only have one long alignment and fits with prediction we can use RNA-seq from a single BioSample to include it in a database. After we have decided on whats a good gene its added as a splice alternative if its not matching to the RefSeq database.

### Functional annotation 

BLAST for proteins, domain searches(more conserved than whole proteins), fold predictions (may give more deciphering when you want to correct in specific cases), cluster sequences into families to see importances of proteins in a genome etc.. 

- __Inferring functions using BLAST searches__ 

If you get no conflict at all you would simply accept the annotation found. Multiple good hits but with different annotations, hopefully they do not function too differently or they may be in the same protein family and you could make inference based on that. Some not so good hits would either only gain limited annotation of what the general thought of the hits above, so if they are all weak but concern serine proteases you could probably say this at least. You could also lack total annotation but get hit, then yous fucked. And if we get no hits then we stop. 

Errors can be due to experimental sources, just be aware of this. Divergent functions, so similarity does not always guarantee similar functions, then phylogeny and relationship could give us some further certainty. Multiple functions where a protein may have multiple function, and finally similarity errors where previous similarity based functions are incorrect. 

### Functional categories
The idea of these are that we take multiple organisms and cluster them into orthologs. In COGS they are divided into broader categories, so more general process specific terms. GO-terms are control vocabularies, where we assign terms to a protein with a hierarchal structure, starting with a high functional level

