#!/usr/bin/bash -l

#SBATCH -A g2019003
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:30:00
#SBATCH -J Trimming_RNA-Serum_020519_Karl_Nyren
#SBATCH --mail-type=ALL
#SBATCH --mail-user karl.nyren.6523@student.uu.se

module load bioinfo-tools
module load trimmomatic/0.36

TRIMM_HOME='/sw/apps/bioinfo/trimmomatic/0.36/rackham/trimmomatic-0.36.jar'
OUT_DIR='/home/karlnyr/Genome_Analysis/Trimmed_data/RNA-Serum'
INPUT_DIR='/home/karlnyr/Genome_Analysis/raw_data/transcriptomics_data/RNA-Seq_Serum/untrimmed'
ADAPTER_DIR='/sw/apps/bioinfo/trimmomatic/0.36/rackham/adapters/TruSeq3-PE.fa'

FILE_EXT_1="_pass_1.fastq.gz"
FILE_EXT_2="_pass_2.fastq.gz"

for FILE in $INPUT_DIR/ERR1*pass_1.*;
do
    READ_PAIR_NAME=`basename $FILE | cut -d "_" -f 1`
    WORK_DIR=$OUT_DIR/$READ_PAIR_NAME
    tmp_WD=$OUT_DIR/$READ_PAIR_NAME/tmp
    mkdir -p $tmp_WD
    mkdir -p $WORK_DIR
    FWD_READ=$INPUT_DIR/$READ_PAIR_NAME$FILE_EXT_1
    REV_READ=$INPUT_DIR/$READ_PAIR_NAME$FILE_EXT_2
    command time -v java -jar $TRIMM_HOME PE \
        $FWD_READ $REV_READ \
        -baseout $tmp_WD/$READ_PAIR_NAME.report \
        ILLUMINACLIP:$ADAPTER_DIR:2:30:10 \
        LEADING:3 \
        TRAILING:3 \
        SLIDINGWINDOW:4:15 \
        MINLEN:36

    for TEMP_FILE in $tmp_WD/*;
        do
            OUT_FILE_NAME=`basename $TEMP_FILE`
            pbzip2 --keep -v -p4 -m2000 -c < $TEMP_FILE > $WORK_DIR/$OUT_FILE_NAME.fastq.bz2
            rm $TEMP_FILE
    done;
    rmdir $tmp_WD
done;
