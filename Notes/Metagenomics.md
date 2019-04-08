# Metagenomics

Driven by tech development in NGS. It is applicable to whole communities and collectivly sequence all of their sequence into one big lump then into separate lumps. The work flow would look something like gather sample, extract DNA, purify it, sequence it all together, do some analyses and then try to gather some knowkledge from this. In this data there is also a high variablility in what you are able to gather from the sample. Often the metagenomic data is used to who is in the environemnt, what they do, how they do it and then who is actually doing what.

## Targeted metagenomic 
Is mainly to look at taxonimic diversity, that is who is present in the sample. Often we amplify a marker gene, often 16s for microbial samples. After amplification comes identification of the taxa. Binning, is another word for clustering, used for approximation of speciation and such. We dont do asseemblys in the targeted metagenomic, instead we cluster. Either cluster or taxonimic grouping first. The determination of the cluster assignments is usually based on identity, where the cutoff is an general arbitrary number at 97.5 %. When doing taxonomic first we run into the chance that we miss rare taxa that could be present in the sample.

### Choice of marker gene
Think about what we want, often we use 16s, but if we want to specify our research make the marker more process or species specific. 

### Extraction and amplification
Iw we want to see everything present in the environment we want to make sure that we don't remove this before we get to the sequencing machine. Important to use protocols that are as including as possible. Also again, primers are so important in targeted metagenomics, don't disclude because of a unwise choice of promers.

### Sequence technology
Can be specific errors to metagenomics, we can have very low coverage, maybe just 1 or two times coverage and ten we use this to bin. An exception is for PacBio seuqencing because then we resample the cirkular cut DNA molecules. We have tradeoff on low resolution and false OTUs, since the underlying data contains errors we may find similarities that does not actually exist. The read length also impact the output.

### Chimeric reads
impacts OTUs, hard to avoid but creates false data in the end. Due to missleading and faulty PCR products. The frequency of these chimeric reads can be minimized, but it all depends on how early you get then, earlier on can imply more probable faults. 

### Have I sequenced enough?
Plot a collectors or rarefaction curve, once reaching a plateu you're done.

### Comparing diversity between samples
making estimation of the diversity in samples could be done with Shannon or Simpson index, whom both are doing within sample diversity, and then Bray-Curtis dissimilarity for betweem sample beta diversity.

## Shoutgun metagenomics
More of what the organisms does, and what is actually doing what. Different approaches to take, either assemble or not to assemble. If we don't assemble we can analyse the reads individually, and check similarity searches and thus gather informationa bout the underlying information about the environment. You can also take these not assembled reads and bin them, before by similarity, but here we would use other information except similarity of the reads, maybe more intrinsic content info. We could also take the binned reads and assemble the binned reads, thus creating an assembly of where we believe they would come from. Also, if we don create and assembly we could do read recruitment to a reference genome, thus finding close relatives in the reference genome. On big issue is that when using a reference we cannot find novel things. If we want to do an assembly we can use all the reads and analyse all the different contigs, similar to an regular assembly, and then by looking at genes present in the contigs we can find the function of the community in the sample analysed. We can also then bin the contigs that has come out of the assembly, into something that then perhaps came from the same genome. This could then be using information on intrinsic or extrinsic information, and then by analysing this we could try to determine the complete contigs of an organism, and thus a better picture of who is actually doing what. 

Recruitment could be good for relatives in genomes, but if you want to look at variation reference based analysis is more useful.

### Challenges of assembly of metagenomic data
always hard to do assembly, and thus harder to do reference analyses. There is also errors in reads, variation between individuals. Repears are still troublesome, and similar seuqneces can exists between unrelated individuals in metagenomics. Similar problem as in RNA assembly, we have uneven coverage which will skew the assembly graph. 

Once the assemly are done, we want to do the binning. We want to decide who is doing what. Often you would see MAGs - Methagenome-assembled genomes. We can use different kinds of methods for binning, either reads or contigs. Can be binned by extrinsic - similarities to other known things - or by intrinsic characters - _e.g tetramer frequency or ǴC content_ - and the third thing we can use is sequence depth thus assign reads back to contig and assign information to each contig. 

