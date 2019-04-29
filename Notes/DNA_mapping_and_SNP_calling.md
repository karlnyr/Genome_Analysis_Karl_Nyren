# DNA mapping and SNP calling
Why DNA mapping? Look at different types of variation, using short read input data. Multiple variations in the gneome that can be visualized with mapping to a ref genome. Indels can be visualized (in a perfect example) by lack of 
coverage in a section of the reference genome.

## Challanges of mapping 
__Fast and efficient mapping__: If we want to be too accurate we would take years to map a genome, and to make it faster we can index and allso allow for missmatches. 

__Accurate mapping__: We need reads longer than long repeats if we want to solve the mapping easily. And a lot of the genome is actually very repetative and hard to deal with. 

__Real variants vs. sequencing errors__: What are real variants or artifacts from sequencing. We want to find differences in the sample, and missmatches will occurs so we can of course be very conservative, but we would throw away a lot of data due to it. 

## Mapping algorithm
Look through the power point. They hash table it, take the last and first characters in the hashrows. Before sorting, we annotate occurance of the letter in a string, then we sort, and then we get the BWT(S). To find a word, start with its last character and build it up from backwards by finding the last character in the B-Ranking row. T-ranking = ranking of occurance in a string.

## Variant calling
before we go to calling we optimize the mapping, trying to reduce faulty mapping by realigning the mapping, trying to correct for indels and determine more probable snps.
