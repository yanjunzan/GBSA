  


```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


### 1. Intorduction

This is a tutorial for R package GBSA. This package is developed for Whole-genome QTL mapping in experimental pedigrees from outbred founders utilizing low coverage individual based sequencing.

### 2. Installation 
```{bash eval=FALSE}
# download the package from https://github.com/yanjunzan/GBSA/blob/master/GBSA_0.1.0.tar.gz
R CMD INSTALL ./GBSA_0.1.0.tar.gz
```
### 3.Prepare input data
```{r eval=FALSE}
input.vcf <- "/Users/yanjunzan/Documents/impute/git/data/180208.all.223+700.f2.P60.vcf.gz" # a vcf.gz file that has all the founders and offspring
input.vcf.fixed <- "/Users/yanjunzan/Documents/impute/git/data/171215_all.780.F0.output.recode.vcf.gz" # a vcf.gz file that has all the founders and genotyped with all fixed markers

NCBI.file <- read.table("/Users/yanjunzan/Documents/impute/git/F2_re_seq/data/chr_id.match.txt",sep="\t",header = T,stringsAsFactors = F) # A annotation file matching the chromsome/contig name in bam file to numerical chromsome names, and document the length of each chromsome/contig
pedigree <- read.table("/Users/yanjunzan/Documents/impute/git/F2_re_seq/data/Ped.f2.f2.f0.txt",sep="\t",header = T,stringsAsFactors = F)[1:5,]#A a data.frame with 7 columns with names as id.f2, id.f2.ma, id.f2.fa, fa.h, ma.h, ma.l, fa.l. Those are F2 id, corresponding mother id,father id and grand parent ids, fa.h,ma.h must come from one line and ma.l, fa.l. from another divergent line
pheFile <- read.table("/Users/yanjunzan/Documents/impute/results/GBSA.test/phentoype.fam.sex.txt",sep = "\t",header=T,stringsAsFactors = T)
pheFile <- pheFile[match(pedigree$ID,table = pheFile$ID),] # A datafram with 3 or more column as ID,sex,family id, phentpye1,...ID names have to match the ID names in genotype file

outpath <- "/Users/yanjunzan//Documents/impute/results/GBSA.test/" # directory for store the intermediate files
```
  
### 4.Format input vcf to intermediate files. 
  
#### 4.1. Selecting markers fixed within family.
  
```{r eval=FALSE}
require(GBSA)
format_grand.p(pedigreeTable =pedigree,vcf.file = input.vcf,pathout = outpath,Core = 5) # intermediate files will be write to outpath
```
  
#### 4.2. Selecting marker fixed between divergent cross.
```{r eval=FALSE}
format_fixed(pedigreeTable =pedigree,vcf.file = input.vcf.fixed,pathout = outpath,Core = 5) # intermediate files will be write to outpath

```
  
### 5. Averaging the genotype call
```{r eval=FALSE}
output <- createExact(cutoffLevel = 10,pedigreeTable = pedigree,matchingNames = NCBI.file,bin.size = 1e6,pathout = outpath)
```
  
### 6.Transfering avearaged score to genotype call
```{r eval=FALSE}
genoCut <- arbitrary.cut(geno = output$genotype, upper.cut = 0.8, lower.cut = 0.2)
```
  
### 7.Format all the output to  Rqtl input
  
```{r eval=FALSE}
export2rqtl(genoFile = output$genotype,phenoFile =pheFile,matchingNames =  matchingNames)
```
### 8. QC and QTL mapping in R qtl
```{r eval=FALSE}
require(qtl)
f2cross <- read.cross(format="csv",file = paste0(fileHap1,  ".csv"),na.strings = "NA",genotypes = c("A", "H", "B", "C", "D"), estimate.map = FALSE, map.function = "haldane", sep = ";")
```
