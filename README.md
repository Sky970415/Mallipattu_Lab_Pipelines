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


## 10X Cell Ranger
### Alignment
There are three different cellranger program: cellranger, cellranger-arc, and cellranger-atac. Cellranger can only align scRNA. Cellranger-atac can only align scATAC. Cellranger-arc is for multiome alignents.

All fastq files needs a naming convention, please click [here](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/fastq-input) for the official guide on it.

    [Sample Name]_S1_L00[Lane Number]_[Read Type]_001.fastq.gz

Sample Name is your custom name for your sample.
Lane number is normally one digit.
Read type could be R1/R2 for read 1/2, and I1/I2 for index 1/2.
### Custom Reference Genome

## Gene Expression Omnibus(GEO)
[Gene Expression Omnibus](https://www.ncbi.nlm.nih.gov/geo/) is a database that contains all the bioinformatics projects. Datasets can be acquired through the searching within the website. This website is used for analyzing outside datasets, whether for method crafting or validation.

![image](Caputres\GEO_Frontpage.PNG)
On the top right of the webpage, there is a search bar. Type in keywords for the datasets. (Potential keywords: Mouse, Single Cell, Kidney.) For this example, we will be looking for mouse single cell dataset.

![image](Caputres\Searching_Example.PNG)
Click on the upper number with hyperlink for searching in the GEO DataSets Database. 

![image](Caputres\SearchResults.PNG)
Now we have 263,758 datasets. In order to filter out the less relavent datasets, we need to set the customizations. 

![image](Caputres\SearchResults_add_Mus.PNG)
First click on the Customize on the left panel. Type _Mus musculus_ in the search bar to add mouse to the Organism. 

![image](Caputres\SearchResults_set_study_type.PNG)
Then, click on the customize on the study type. Uncheck all the study type and then check the _Expression profiling by high throughput sequencing_.

![image](Caputres\SearchResults_filter_applied.PNG)
Click on the new organism and study type we added in the previous steps. Now the number of dataset is reduced to 8601.
### Download Fasta Files to HPC via SRA tools


    prefetch [SRR project]
    fastq-dump [SRR project]


## R Analysis

### ArchR
### Seurat
### Pathway Analysis