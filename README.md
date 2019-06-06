# Internship M1
## Subject : Development of an interface and pipeline of NGS analyses for variant detection.

### Day 1:
- Discover and Installation of the pipeline MutAid v1.1
    - https://sourceforge.net/projects/mutaid/
- Installation of the R package Piano
    - https://bioconductor.org/packages/3.9/bioc/html/piano.html
    - Installation for R 3.3 

### Day 2 :
- Try to run MutAid with test data (MutAid) and test data (TD Galaxy Mycobacterium)
    - FastQC OK
    - Map (BWA) FAIL
    - Variant (Varscan) FAIL

### Day 3 : 
- Try to find solution to import files of hg19 (prepref program)
- Try to run MutAid with test data (TD Galaxy Mycobacterium)
    - FastQC OK
    - Map (BWA) OK
    - Variant (Varscan) FAIL -> 0 SNP found
- Installation of the pipeline MutAid v1.0
    - Look at the differences between the two version
    - Test of the version v1.0
    <Same probleme that the other version>
    
### Day 4 :
- Run prepref program v1.0 at home
    - GATK Bundle files success
    - hg19 files (in progress)
