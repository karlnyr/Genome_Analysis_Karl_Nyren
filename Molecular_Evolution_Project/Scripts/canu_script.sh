#!/usr/bin/bash

SBATCH
#SBATCH
#SBATCH
#SBATCH
#SBATCH
#SBATCH
#SBATCH
#-A g2019003
#-p core
#-n 1
#-t 05:30:00
#-J Genome_Assembly_Karl_Nyren
#--mail-type=ALL
#--mail-user karl.nyren.6523@student.uu.se

module load bioinfo-tools
module load canu

canu -p Genome_Assembly_E745_3.1M -d /home/karlnyr/Molecular_Evolution/Genome_Assembly genomeSize=3.1m -pacbio-corrected /home/karlnyr/Molecular_Evolution/raw_data/genomics_data/PacBio/*gz
