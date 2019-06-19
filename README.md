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
- Try to run MutAid with test data (MutAid) and test data (TD Galaxy Mycobacterium)
    - FastQC OK
    - Map (BWA) FAIL
    - Variant (samtools) FAIL

### Day 3 : 
- Try to find solution to import files of hg19 (prepref program)
- Try to run MutAid with test data (TD Galaxy Mycobacterium)
    - FastQC OK
    - Map (BWA) OK
    - Variant (samtools) FAIL -> 0 SNP found
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
Map : BWA Detection variant : samtools
Map : BOWTIE Detection variant : samtools 

### Day 6 :
- write_output.py (Pipeline) Cosmic file process in comment
- Dl refLink.txt 
- Run on test data Human Map : BWA Variant caller : samtools //81 Indels SNP : 1272//

### Day 7 : 
- Run on test data Human // Map : Bowtie2 Variant caller : samtools //117 Indels SNP : 1751//
- Run on test data Human // Map : TMAP Variant caller : samtools //107 Indels SNP : 1611//
- Bowtie and GSNAP Error (Map)
- Need to find a solution about selection of the variant caller

### Day 8 :
- Files available samtools.vcf freebayes.vcf (VarScan ?)

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
|int(individuals)|int(value)|str(bwa/tmap/bowtie2)|str(samtools/varscan/freebayes)|

### Day 12 :
- Modification of the multivariate data table : 
    - Choose to work with Coverage and Allele Frequency and not Quality (avoid NA value for mapper and variant caller).
    
|POS|M1V1|M1V2|M1V3|M2V1|M2V2|M2V3|M3V1|M3V2|M3V3|
|---|---|---|---|---|---|---|---|---|---|
|int(individuals)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|

<<RDV avec P.Thébault et E.Darbo Revoir le tableau des données multivariées. Attention pour l'instant gestion des données manquantes NA remplacé par 0>>

### Day 13 : 
- Obtention of two multivariate data table : coverage.csv allfreq.csv
- PCA in Rstudio
- Need to find a solution for NA values (replace by 0)
