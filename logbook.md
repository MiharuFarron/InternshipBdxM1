# Internship M1
## Subject : Development of an interface for comparison of variants detections results

### Day 1:
- Discover and Installation of the pipeline MutAid v1.1
    - https://sourceforge.net/projects/mutaid/
- Installation of the R package Piano
    - https://bioconductor.org/packages/3.9/bioc/html/piano.html
    - Installation for R 3.3 
    
    <<RDV P.Thebault Présentation du sujet>>

### Day 2 :
- Try to run MutAid with test data (MutAid) and test data (TD Galaxy)
    - FastQC OK
    - Map (BWA) FAIL
    - Variant (varscan) FAIL

### Day 3 : 
- Try to find solution to import files of hg19 (prepref program)
- Try to run MutAid with test data (TD Galaxy)
    - FastQC OK
    - Map (BWA) OK
    - Variant (varscan) FAIL -> 0 SNP found
- Installation of the pipeline MutAid v1.0
    - Look at the differences between the two version
    - Test of the version v1.0
        - Same problem that the other version
        
    <<RDV P.Thebault E.Darbo Présentation avancement + sujet. Concentration sur le fastq human du TD Galaxy>>
### Day 4 :
- Run prepref program v1.0 ()
    - GATK Bundle files success
    - hg19 files 
    - error need to fix gene annotation files
- Piano : installation of packages with BiocLite
    - "affy"/"yeast2.db"/"rsbml"/"plotrix"/"limma"/"plier"/"affyPLM"/"gtools"/"biomaRt"/"snowfall"/"AnnotationDbi"
- Run test data (MutAid v1.0) CANCEL 
- Change of version MutAid v1.0

### Day 5 : 
- MutAid v1.0 two files refInput missing change of directory location in UCSC Browser(error of Day4)/cosmic.txt missing delete from UCSC
- Run test data (MutAid v1.0)
    - First run 2hr (bwa)(bwai)
    - FastQC OK/Mapping OK/Variant detection OK/Variant annotation ERROR (cosmic file missing)
- Run test data (Galaxy hg19)
    - Test Fastq Human 
        - Good result similar to the result obtained with Galaxy (need to look at the parameters)
        - FastQC OK/Mapping OK/Variant detection OK/Variant annotation ERROR
        - Same error : cosmic file missing 
Map : BWA Detection variant : varscan
Map : BOWTIE Detection variant : varscan 

### Day 6 :
- write_output.py (Pipeline) Cosmic file process in comment
- Dl refLink.txt 
- Run on test data Human Map : BWA Variant caller : varscan //81 Indels SNP : 1272//

### Day 7 : 
- Run on test data Human // Map : Bowtie2 Variant caller : varscan //117 Indels SNP : 1751//
- Run on test data Human // Map : TMAP Variant caller : varscan //107 Indels SNP : 1611//
- Bowtie and GSNAP Error (Map)
- Need to find a solution about selection of the variant caller

### Day 8 :
- Files available varscan.vcf freebayes.vcf (VarScan ?)

<<RDV P.Thebault création d'un script permettant de lancer le pipeline avec les différents types de mapper/detecteur de variant, ensuite depuis le fichier vcf création d'un tableau multivarié, PCA, Présentation des résultats (Rshiny)>>

### Day 9 :
- Begin new script > installation of vcf module python 
```bash
pip install PyVcf
```

### Day 10 :
- Test of PCA on test_multi_data.csv (Rstudio)
- Obtention of multiple graph (need to know if they are rigth)
- Try to obtain result with MutAid data

### Day 11 :
- Still working on the script : MuTAid Pipemine, obtention of vcf file, creation of a multivariate data table, try to obtain a PCA (Python).
- Multivariate table :

|POS|QUAL|MAP|VARCALL|
|---|---|---|---|
|int(individuals)|int(value)|str(bwa/tmap/bowtiesamtoolsreebayes)|

### Day 12 :
- Modification of the multivariate data table : samtools
    - Choose to work with Coverage and Allele Frequency and not Quality (avoid NA value for mapper and variant caller).
    
|POS|M1V1|M1V2|M1V3|M2V1|M2V2|M2V3|M3V1|M3V2|M3V3|
|---|---|---|---|---|---|---|---|---|---|
|int(individuals)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|

<<RDV avec P.Thébault et E.Darbo Revoir le tableau des données multivariées. Attention pour l'instant gestion des données manquantes NA remplacé par 0>>

### Day 13 : 
- Obtention of two multivariate data table : coverage.csv allfreq.csv
- PCA in Rstudio
- Need to find a solution for NA values (replace by 0)

### Day 14 : 
- NA values : package missMDA 

### Day 15 :
- Study of ddspls package

### Day 16 :
- Improvement of the python script

### Day 17 :
- **PCA/Singular Value Decomposition/matrix completion is implemented** in the package **missMDA** for numerical, categorical and mixed data. **softImpute** contains several methods for iterative matrix completion, as well as filling and **denoiseR** for numerical variables, or mimi that uses low rank assumption to impute mixed datasets. The package **pcaMethods** offers some Bayesian implementation of PCA with missing data. **NIPALS** (based on SVD computation) is implemented in the packages mixOmics (for PCA and PLS), **ade4**, **nipals** and **plsRglm** (for generalized model PLS). **ddsPLS** implements a multi-block imputation method based on PLS in a supervise framework.**ROptSpace** and **CMF** proposes a matrix completion method under low-rank assumption and collective matrix factorization for imputation using Bayesian matrix completion for groups of variables (binary, quantitative, poisson). Imputation for groups is also avalaible in the **missMDA** in the function imputeMFA. SOURCE : https://rviews.rstudio.com/2018/10/26/cran-s-new-missing-values-task-view/
- Creation of PA multivariate table 

<<RDV avec P.Thebault et E.Darbo Modification des valeurs POS POS+CHR Only SNP Scale Varscan value  Voir possibilté de Présence Absence>>

### Day 18 : 
- Creation of UPSET R plot from pos_text.txt
- Verification of vc_files output column values

### Day 19 : 
<<RDV E.Darbo 10h Determination of DP threshold 10 // Correction of NA rows>>
- Modification of coverage csv table
- Creation of new PA table 

### Day 20 :
- Discover of R shiny

### Day 21/22 :
- Creation of R Shiny App
- Gg Miss Upset Package Naniar  "An upset plot from the UpSetR package can be used to visualise the patterns of missingness, or rather the combinations of missingness across cases. To see combinations of missingness and intersections of missingness amongst variables, use the gg_miss_upset function" Source : https://cran.r-project.org/web/packages/naniar/vignettes/naniar-visualisation.html

### Day 23/30 :
- R Shiny app amelioration

### Day 31 :
- Creation of JSON file by user selection 

### Day 32/35 :
- Corrections, add comments to main script
- Writing documentation


