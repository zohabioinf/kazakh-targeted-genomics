#!/bin/bash


for R1 in /rds/projects/e/elhamsak-acrg-tcga510/colo/data/*_1.fastq
do
    sample=${R1##*/}
    sample=${sample%_1.fastq}

    java -jar "$EBROOTTRIMMOMATIC/trimmomatic-0.39.jar" PE \
        -threads 8 \
        -phred33 \
        -basein "$R1" \
        -baseout "trim/$sample" \
        ILLUMINACLIP:NexteraPE-PE.fa:2:30:10:2:True \
        LEADING:3 \
        TRAILING:3 \
	    TAILCROP:5 \
        SLIDINGWINDOW:4:20 \
        MINLEN:36
done
