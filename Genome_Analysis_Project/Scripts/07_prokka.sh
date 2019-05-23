#!/usr/bin/bash -l

#SBATCH -A g2019003
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:30:00
#SBATCH -J Genome_Assembly_Karl_Nyren
#SBATCH --mail-type=ALL
#SBATCH --mail-user karl.nyren.6523@student.uu.se

OUTDIR='/home/karlnyr/Genome_Analysis/Annotation/DNA/Spades_Genome_Assembly'
PREFIX='annotated_spades_220519'
ASSEMBLY_PATH='/home/karlnyr/Genome_Analysis/Genome_Assembly/spades_combined_assembly/combined_assembly_220519/contigs.fasta'

prokka \
    --outdir $OUTDIR \
    --prefix $PREFIX \
    $ASSEMBLY_PATH
