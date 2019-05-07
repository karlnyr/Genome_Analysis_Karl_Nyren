#!/usr/bin/bash -l

#SBATCH -A g2019003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 01:30:00
#SBATCH -J Genome_Assembly_Karl_Nyren
#SBATCH --mail-type=ALL
#SBATCH --mail-user karl.nyren.6523@student.uu.se

module load bioinfo-tools
module load bwa/0.7.8
module load samtools/1.9

RNA_SERUM='RNA-Seq_Serum'
RNA_BH='RNA-Seq_BH'
ASSEMBLY_DIR='/home/karlnyr/Genome_Analysis/Genome_Assembly/pilon/Corrected_Assembly_Pilon_v1.contigs.fasta'
INPUTDIR='/home/karlnyr/Genome_Analysis/raw_data/transcriptomics_data'
OUTDIR='/home/karlnyr/Genome_Analysis/Mapping'


FILE_PRE='trim_paired_'
FILE_EXT_1='pass_1.fastq.gz'
FILE_EXT_2='pass_2.fastq.gz'

for FILE in $INPUTDIR/$RNA_SERUM/trim*pass_1*;
    do
        READ_PAIR_NAME=`basename $FILE | cut -d "_" -f 3`
        READ_1=$INPUTDIR/$RNA_SERUM/$FILE_PRE$READ_PAIR_NAME$FILE_EXT_1
        READ_2=$INPUTDIR/$RNA_SERUM/$FILE_PRE$READ_PAIR_NAME$FILE_EXT_2
        command bwa mem \
        -M \
        $ASSEMBLY_DIR \
        $READ_1 $READ_2 \
        | \
        command samtools sort \
        -o $OUTDIR/$RNA_SERUM/$READ_PAIR_NAME
done;

for FILE in $INPUTDIR/$RNA_BH/trim*pass_1*;
    do
        READ_PAIR_NAME=`basename $FILE | cut -d "_" -f 3`
        READ_1=$INPUTDIR/$RNA_BH/$FILE_PRE$READ_PAIR_NAME$FILE_EXT_1
        READ_2=$INPUTDIR/$RNA_BH/$FILE_PRE$READ_PAIR_NAME$FILE_EXT_2
        command bwa mem \
        -M \
        $ASSEMBLY_DIR \
        $READ_1 $READ_2 \
        | \
        command samtools sort \
        -o $OUTDIR/$RNA_BH/$READ_PAIR_NAME
done;
