#!/usr/bin/bash -l

#SBATCH -A g2019003
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:30:00
#SBATCH -J htseq_count_rna-seq
#SBATCH --mail-type=ALL
#SBATCH --mail-user karl.nyren.6523@student.uu.se

module load bioinfo-tools
module load htseq/0.9.1
module load samtools/1.9

RNA_SERUM='RNA-Seq_Serum'
RNA_BH='RNA-Seq_BH'
ANNOTATION_DIR='/home/karlnyr/Genome_Analysis/Annotation/DNA/Spades_Genome_Assembly/annotated_spades_220519.gtf'
ALIGNMENT_DIRS='/home/karlnyr/Genome_Analysis/Mapping/spades_assembly_alignments'
OUTDIR='/home/karlnyr/Genome_Analysis/gene_counts/gene_counts'
FILE_EXT='_count_140519.txt'

for FILE in $ALIGNMENT_DIRS/$RNA_SERUM/ERR*;
    do
        OUTPUT_N=`basename $FILE`
        samtools view $FILE | htseq-count --format bam --type CDS  $FILE $ANNOTATION_DIR > $OUTDIR/$RNA_SERUM$OUTPUT_N$FILE_EXT
done

for FILE in $ALIGNMENT_DIRS/$RNA_BH/ERR*;
    do
        OUTPUT_N=`basename $FILE`
        samtools view $FILE | htseq-count --format bam --type CDS  $FILE  $ANNOTATION_DIR > $OUTDIR/$RNA_BH$OUTPUT_N$FILE_EXT
done
