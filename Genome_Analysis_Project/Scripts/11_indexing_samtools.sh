#!/usr/bin/bash -l

#SBATCH -A g2019003
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 03:30:00
#SBATCH -J INDEXING_SAMTOOLS
#SBATCH --mail-type=ALL
#SBATCH --mail-user karl.nyren.6523@student.uu.se

module load bioinfo-tools
module load samtools/1.9

RNA_Seq_BH='RNA-Seq_BH'
RNA_Seq_Serum='RNA-Seq_Serum'

input_dir='/home/karlnyr/Genome_Analysis/Mapping/canu_assembly_alignments/'
suffix_sorted='.sorted.bam'
suffix_index=$suffix_sorted'.bai'

for FILE in $input_dir/$RNA_Seq_Serum/*;
    do
        command samtools sort -O bam $FILE -o $FILE$suffix -T $FILE'tmp'
        command samtools index -b $FILE$suffix_sorted $FILE$suffix_index
    done

for FILE in $input_dir/$RNA_Seq_BH/*;
    do
        command samtools sort -O bam $FILE -o $FILE$suffix -T $FILE'tmp'
        command samtools index -b $FILE$suffix_sorted $FILE$suffix_index
    done
