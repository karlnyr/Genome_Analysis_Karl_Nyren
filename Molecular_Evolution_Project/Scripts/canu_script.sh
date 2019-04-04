#!/usr/bin/bash
module load bioinfo-tools
module load canu

canu -p Genome_Assembly_E745_3.1M -d /home/karlnyr/Molecular_Evolution/Genome_Assembly -pacbio-corrected /home/karlnyr/Molecular_Evolution/raw_data/genomics_data/PacBio/*gz
