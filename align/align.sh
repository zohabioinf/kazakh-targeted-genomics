#!/bin/bash
#SBATCH --job-name=bwa_align
#SBATCH --cpus-per-task=16
#SBATCH --time=02:00:00
#SBATCH --output=bwa_%j.out
#SBATCH --error=bwa_%j.err

module purge
module load bear-apps/2020a/live
module load BWA/0.7.17-foss-2020a

cd /rds/projects/e/elhamsak-acrg-tcga510/colo/

mkdir -p align

for R1 in ./trim/trim/*_1P
do
    SAMPLE=$(basename "$R1" _1P)
    R2="./trim/trim/${SAMPLE}_2P"

    echo "Aligning ${SAMPLE}..."

    bwa mem -t 16 \
        ./genome/grch38.fa \
        "$R1" \
        "$R2" \
        > "./align/sam/${SAMPLE}.sam"

    echo "${SAMPLE} completed."
done