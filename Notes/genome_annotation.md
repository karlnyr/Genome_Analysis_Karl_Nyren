# Genome Annotation
Genome annotations specify what kind of information the scientists have been able to retrieve about a specific loci in the genome of an organism. 

To identify function in sectuence we can probably find some selective pressure. When we do structural annotation we always have to determine the selection and if it is caused by random drift or not. So if there is not drift we can with some certainty say that the sequence has a function. One way to observe sequence perserverence we could look at probabilities of nucleotide frequency. 

## Structural annotation
### Non-coding sequences - rRNA and tRNA
Assosiation to ribosomal and translational functions and are very conserved and/or structured. tRNA has three different binding loops, can be used to determine tRNAs from sequence. tRNA software called tRNAscan, basically uses descision tree, and uses the most conserved features of the tRNA to find these molecules. It is easily predicted since they have determined length and structure. This process is normally not an issue, but start with this so that we know where to not do an deeper and more demanding sequence analysis. 

### Protein coding genes
six possible reading frame depending on shift of -3 to +3, in eukaryotes we have introns and exons, whilst prokaryotes don't thus prokaryotes is ORF = gene. One can draw deductions with good certainty only if there is a longer ORF present. So an ORF with 3 bases is probably not a gene whilst a 1000 bp one is more likely to be one. 

There is also a relationship of genome comp and how it determines codons position. there is harder selection on the two first positions because they are often non-synonymous mutations. Not only does GC contenta affect codon position. Some amino acids are more AT enriched, and thus the GC content affects the usage of an amino acid in its proteins. If we divide aa into GC and GC poor codons. The usage of specific aa in coding regions are affected by GC contents. So by information on how likely a organism is to use a amino acid we can weigh it in for how likely a gene is to occur depending on the codons in the region. 

Gene prediction software uses these weights of used amino acids. Uses dicodon occurences, or hexamers, a good meassurement since it contain codon usage, dinucleotides(specific to genome), amino acid composition(location to one) and these together seem to work great together. They all have first some training set, on how a gene is supposed to look like in the organism and then builds a model on how a gene is supposed to look based on the long genes. 
