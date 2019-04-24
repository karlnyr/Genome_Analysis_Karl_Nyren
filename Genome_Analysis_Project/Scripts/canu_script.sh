#!/usr/bin/bash -l

#SBATCH -A g2019003
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:30:00
#SBATCH -J Genome_Assembly_Karl_Nyren
#SBATCH --mail-type=ALL
#SBATCH --mail-user karl.nyren.6523@student.uu.se

module load bioinfo-tools
module load canu

canu -p Genome_Assembly_V.2 -d /home/karlnyr/Molecular_Evolution/Genome_Assembly genomeSize=3.1m -pacbio-raw /home/karlnyr/Molecular_Evolution/raw_data/genomics_data/PacBio/*fastq.gz
