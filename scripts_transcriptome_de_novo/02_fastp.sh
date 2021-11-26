#!/usr/bin/env bash
#PBS -N fastp
#PBS -q mpi_1
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=28:mpiprocs=28:mem=40gb

#declare variables used in the script
DATADIRECTORY=$DATAWORK/creisser/gambusie/rnaseq
DATAOUTPUT=$SCRATCH/gambic/03_trimmed
SCRIPT=$DATADIRECTORY/00_scripts/02_fastp_scripts
HEADER=$DATADIRECTORY/00_scripts/header.txt
FASTP="path_to_fastp_bin"
ADAPTERFILE=$DATADIRECTORY/00_scripts/adapters.fasta
LOG_FOLDER=$DATADIRECTORY/98_log_files

mkdir -p $DATAOUTPUT
mkdir -p $SCRIPT


$FASTP

cd $DATADIRECTORY/02_data

#store this information into a new variable called NAME
NAME='cat base.txt'

for file in $($NAME)
do
         cp $HEADER $SCRIPT/fastp_${file##*/}.sh ;
         echo "cd $DATADIRECTORY" >> $SCRIPT/fastp_${file##*/}.sh ;
         echo "$FASTP"  >> $SCRIPT/fastp_${file##*/}.sh ;
         echo "fastp -i $DATADIRECTORY/02_data/"$file"_R1_001.fastq.gz -I $DATADIRECTORY/02_data/"$file"_R2_001.fastq.gz -o $DATAOUTPUT/"$file"_R1_paired.fastq.gz -O $DATAOUTPUT/"$file"_R2_paired.fastq.gz --adapter_fasta $ADAPTERFILE --trim_poly_g --average_qual 28 --length_required 50 --thread 28 &> $LOG_FOLDER/log."$file".txt" >> $SCRIPT/fastp_${file##*/}.sh ;
        qsub $SCRIPT/fastp_${file##*/}.sh ;

done ;

