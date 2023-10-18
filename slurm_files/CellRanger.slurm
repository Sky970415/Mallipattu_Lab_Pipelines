#!/bin/sh
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH -p long-28core

export PATH=/gpfs/scratch/jiakwang/Klf15ATAC/:$PATH

module load cellranger-atac

cellranger-atac count --id=SC79_1A_Out --reference=/gpfs/scratch/jiakwang/Klf15ATAC/refdata-cellranger-arc-mm10-2020-A-2.0.0  --fastqs=/gpfs/scratch/jiakwang/Klf15ATAC/usftp21.novogene.com/01.Raw_data/SC79_1A/ --localmem=100 --localcores=28

cellranger-atac count --id=SC79_2A_Out --reference=/gpfs/scratch/jiakwang/Klf15ATAC/refdata-cellranger-arc-mm10-2020-A-2.0.0  --fastqs=/gpfs/scratch/jiakwang/Klf15ATAC/usftp21.novogene.com/01.Raw_data/SC79_2A/ --localmem=100 --localcores=28
