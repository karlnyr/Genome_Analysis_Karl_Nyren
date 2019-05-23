#!/usr/bin/bash -l

#SBATCH -A g2019003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 05:30:00
#SBATCH -J spades_combined_assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user karl.nyren.6523@student.uu.se

module load bioinfo-tools
module load spades/3.9.0

ILLUMINA_READS_DIR='/home/karlnyr/Genome_Analysis/raw_data/genomics_data/Illumina/'
NANOPORE_READS_DIR='/home/karlnyr/Genome_Analysis/raw_data/genomics_data/Nanopore/E745_all.fasta.gz'
OLD_ASSEMBLY_DIR='/home/karlnyr/Genome_Analysis/Genome_Assembly/canu_assembly/pilon/Corrected_Assembly_Pilon_v1.contigs.fasta'
OUTPUT_DIR='/home/karlnyr/Genome_Analysis/Genome_Assembly/spades_combined_assembly/combined_assembly_220519'
READ_1_EXT='*1_clean.fq.gz'
READ_2_EXT='*2_clean.fq.gz'

spades.py -1 $ILLUMINA_READS_DIR$READ_1_EXT -2 $ILLUMINA_READS_DIR$READ_2_EXT --nanopore $NANOPORE_READS_DIR --untrusted-contigs $OLD_ASSEMBLY_DIR -o $OUTPUT_DIR
