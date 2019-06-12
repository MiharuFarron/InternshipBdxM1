# Internship M1
## Subject : Development of an interface and pipeline of NGS analyses for variant detection.

### Day 1:
- Discover and Installation of the pipeline MutAid v1.1
    - https://sourceforge.net/projects/mutaid/
- Installation of the R package Piano
    - https://bioconductor.org/packages/3.9/bioc/html/piano.html
    - Installation for R 3.3 
    <RDV P.Thebault Présentation du sujet>

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
    <RDV P.Thebault E.Darbo Présentation avancement + sujet. Concentration sur le fastq human du TD Galaxy>
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
- Need to find a solution about selection of the variant caller/samtools by default 

