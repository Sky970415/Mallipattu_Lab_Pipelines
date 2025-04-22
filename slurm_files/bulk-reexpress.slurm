Karam Re-expression Bulk RNA-seq analysis

module load slurm 
module load shared
module load hts/1.0

cd /gpfs/projects/MallipattuGroup/Karam/

#generating STAR human genome indeces for 150bp reads
STAR --runMode genomeGenerate --genomeDir /gpfs/projects/MallipattuGroup/ --genomeFastaFiles /gpfs/projects/MallipattuGroup/Karam/GRCh38.p14.genome.fa --sjdbGTFfile /gpfs/projects/MallipattuGroup/Karam/gencode.v47.chr_patch_hapl_scaff.annotation.gtf --sjdbOverhang 149

#checking quality of fastqc 
fastqc Reexpression-C_R1_001.fastq.gz
fastqc Reexpression-C_R2_001.fastq.gz

#Reexpression
cutadapt -a AGATCGGAAGAG -A AGATCGGAAGAG -o Reexpression-A_R1_001_trimmed.fastq.gz -p Reexpression-A_R2_001_trimmed.fastq.gz Reexpression-A_R1_001.fastq.gz Reexpression-A_R2_001.fastq.gz

clumpify.sh in1=Reexpression-A_R1_001_trimmed.fastq.gz in2=Reexpression-A_R2_001_trimmed.fastq.gz  out1=Reexpression-A_R1_001_trimmed_clumped.fastq.gz out2=Reexpression-A_R2_001_trimmed_clumped.fastq.gz dedupe