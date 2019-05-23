#!/usr/bin/bash -l

#SBATCH -A g2019003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 00:30:00
#SBATCH -J quast_genome_assembly_eval
#SBATCH --mail-type=ALL
#SBATCH --mail-user karl.nyren.6523@student.uu.se

module load bioinfo-tools
module load quast/4.5.4

REF_ASSEMBLY_DIR='/home/karlnyr/Genome_Analysis/raw_data/paper_data/GCA_001750885.1_ASM175088v1_genomic.fna'
ASSEMBLY_DIR='/home/karlnyr/Genome_Analysis/Genome_Assembly/spades_combined_assembly/combined_assembly_220519/contigs.fasta'
OUTDIR='/home/karlnyr/Genome_Analysis/Genome_Assembly/spades_combined_assembly/evaluation'

quast.py -R $REF_ASSEMBLY_DIR $ASSEMBLY_DIR -o $OUTDIR
