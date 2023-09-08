# Mallipattu Lab Pipelines
This repository is used for storing the Pipelines of single cell analysis from the start to the end.  Records pipelines for Single Cell analysis
## HPC

### HPC Setup
In order to load necessary module during the startup of HPC cluster, it is better to edit the .bachrc file to change the startup sequence.

Type ```vim ~/.bashrc``` to edit your bashrc file. Add the following blocks at the end of the file(vim guide: press keyboard ```i``` to enter insert mode):
```
module load R/4.1.1
module load rstudio/2022.07
module load curl/7.52.1
module load geos/3.11.0
module load hdf5/1.10.4
module load gsl/gcc12/2.7.1
module load Bzip2/1.0.8
module load git/2.36.2
module load slurm
module load hts/1.0
```
Press ```Esc``` to quit insert mode and press ```:``` to enter command. Type ```wq``` to write(save the file) and quit vim.

The list above includes most of the analysis tools we need to do analysis. For any other program you want to use, please check it in the cluster command line ```module avial``` to check out whether it is avaliable in the cluster. Use similar fashion to add to your startup bashrc file like the example above. For one time use, just type the module load command in the prompt. It will be unload once you disconnected to HPC.

## RStudio
There are two methods for using RStudio on HPC. It is recommanded to use RStudio on HPC unless you have a powerful computer with around 60GB of RAM. Seurat consuming a lot of RAM and ArchR only runs on linux-based system, which are the two major analysis tools we are using for single cell analysis. 

### MobaXTerm
The first method would be using MobaXTerm to run RStudio. 

### Slurm
The second method is using slurm file to creat a cluster job to run a server at HPC.

## R Analysis

### ArchR
### Seurat
### Pathway Analysis

## 10X Cell Ranger
### Alignment
### Custom Reference Genome

## Gene Expression Omnibus(GEO)
### Download Fasta Files to HPC via SRA tools