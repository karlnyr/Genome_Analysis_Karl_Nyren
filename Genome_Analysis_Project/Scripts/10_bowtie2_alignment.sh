#!/usr/bin/bash -l

#SBATCH -A g2019003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 04:30:00
#SBATCH -J bowtie2-alignment
#SBATCH --mail-type=ALL
#SBATCH --mail-user karl.nyren.6523@student.uu.se

module load bioinfo-tools
module load bowtie2/2.3.4.3
module load samtools/1.9

BT2_INDEX='/home/karlnyr/Genome_Analysis/Genome_Assembly/spades_combined_assembly/combined_assembly_220519/spades_assembly_index/e_faecium'
RNA_SERUM='RNA-Seq_Serum'
RNA_BH='RNA-Seq_BH'
READS_DIR='/home/karlnyr/Genome_Analysis/raw_data/transcriptomics_data'
OUTPUT_DIR='/home/karlnyr/Genome_Analysis/Mapping/spades_assembly_alignments'

FILE_PRE='trim_paired_'
FILE_EXT_1='_pass_1.fastq.gz'
FILE_EXT_2='_pass_2.fastq.gz'

for FILE in $INPUTDIR/$RNA_SERUM/trim_paired_*pass_1*;
    do
        READ_PAIR_NAME=`basename $FILE | cut -d "_" -f 3`
        READ_1=$INPUTDIR/$RNA_SERUM/$FILE_PRE$READ_PAIR_NAME$FILE_EXT_1
        READ_2=$INPUTDIR/$RNA_SERUM/$FILE_PRE$READ_PAIR_NAME$FILE_EXT_2
        command bowtie2 \
        -x $BT2_INDEX \
        -1 $READ_1 \
        -2 $READ_2 \
        | \
        samtools view -bS \
        | \
        command samtools sort \
        -o $OUTPUT_DIR/$RNA_SERUM/$READ_PAIR_NAME
done

for FILE in $INPUTDIR/$RNA_BH/trim*pass_1*;
    do
        READ_PAIR_NAME=`basename $FILE | cut -d "_" -f 3`
        READ_1=$INPUTDIR/$RNA_BH/$FILE_PRE$READ_PAIR_NAME$FILE_EXT_1
        READ_2=$INPUTDIR/$RNA_BH/$FILE_PRE$READ_PAIR_NAME$FILE_EXT_2
        command bowtie2 \
        -x $BT2_INDEX \
        -1 $READ_1 \
        -2 $READ_2 \
        | \
        samtools view -bS \
        | \
        command samtools sort \
        -o $OUTPUT_DIR/$RNA_BH/$READ_PAIR_NAME
done
