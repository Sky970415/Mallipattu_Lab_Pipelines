#!/bin/sh
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH -p long-28core

module load cellranger-arc

export PATH=/gpfs/scratch/jiakwang/Human\ TG26/:$PATH


cellranger-arc count --id=SC90_1Aout --reference=/gpfs/scratch/jiakwang/Human\ TG26/refdata-cellranger-arc-mm10-2020-A-2.0.0  --libraries=/gpfs/scratch/jiakwang/Human\ TG26/library_SC90_1A.csv --localmem=100 --localcores=28
cellranger-arc count --id=SC90_2Aout --reference=/gpfs/scratch/jiakwang/Human\ TG26/refdata-cellranger-arc-mm10-2020-A-2.0.0  --libraries=/gpfs/scratch/jiakwang/Human\ TG26/library_SC90_2A.csv --localmem=100 --localcores=28
