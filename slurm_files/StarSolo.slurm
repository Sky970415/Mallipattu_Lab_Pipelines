#!/bin/sh
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH -p long-28core

export PATH=/gpfs/scratch/jiakwang/Human\ TG26/:$PATH

module load star/2.7.9a

STAR --genomeDir /path/to/genome/dir/ --readFilesIn ...  [...other parameters...] --soloType Droplet --soloCBwhitelist ...
