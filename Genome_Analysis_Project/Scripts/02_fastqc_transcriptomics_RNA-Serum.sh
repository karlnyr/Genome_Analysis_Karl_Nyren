#!/usr/bin/bash -l

#SBATCH -A g2019003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 01:30:00
#SBATCH -J FastQC_RNA-serum_Karl_Nyren
#SBATCH --mail-type=ALL
#SBATCH --mail-user karl.nyren.6523@student.uu.se

module load bioinfo-tools
module load FastQC/0.11.5

fastqc \
    /home/karlnyr/Genome_Analysis/raw_data/transcriptomics_data/RNA-Seq_Serum/untrimmed/* \
    --outdir /home/karlnyr/Genome_Analysis/Metadata/FastQC/transcriptomic_data/RNA_serum/untrimmed \
    && \
    fastqc \
    /home/karlnyr/Genome_Analysis/raw_data/transcriptomics_data/RNA-Seq_Serum/*fastq.gz \
    --outdir /home/karlnyr/Genome_Analysis/Metadata/FastQC/transcriptomic_data/RNA_serum/paper_trimmed \
    && \
    fastqc \
    /home/karlnyr/Genome_Analysis/Trimmed_data/RNA-Serum/collected_trimmed_data/*fastq.bz2 \
    --outdir /home/karlnyr/Genome_Analysis/Metadata/FastQC/transcriptomic_data/RNA_serum/self_trimmed

