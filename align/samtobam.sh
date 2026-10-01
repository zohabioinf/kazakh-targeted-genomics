#!/bin/bash
#SBATCH --job-name=sam_to_bam
#SBATCH --cpus-per-task=4
#SBATCH --time=02:00:00
#SBATCH --output=sam_to_bam_%j.out
#SBATCH --error=sam_to_bam_%j.err

module purge
module load bear-apps/2020a/live
module load SAMtools

cd /rds/projects/e/elhamsak-acrg-tcga510/colo/

mkdir -p bam

for SAM in ./align/sam/*.sam
do
    SAMPLE=$(basename "$SAM" .sam)

    echo "Converting ${SAMPLE}..."

    samtools view -b "$SAM" > "./align/bam/${SAMPLE}.bam"

    echo "${SAMPLE} completed."
done
