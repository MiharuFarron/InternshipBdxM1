# Internship M1
# Subject : Development of an interface of comparison of variants detections results

## The goal here is to find a method which permit to find which tools (mapper or variant caller) is better to suits to a biological question. The Pipeline used here will be MutAid. 

### **Softwares** : 
**R 3.3**
#### Packages needed : 
```R
# Web Application Framework for R
install.packages(shiny)
# Create Dashboards with 'Shiny'
install.packages(shinydashboard)
# Custom Inputs Widgets for Shiny
install.packages(shinyWidgets)
# A Wrapper of the JavaScript Library 'DataTables'
install.packages(DT)
# A More Scalable Alternative to Venn and Euler Diagrams for Visualizing Intersecting Sets
install.packages(UpSetR)
# Data Structures, Summaries, and Visualisations for Missing Data
install.packages(naniar)
# A Robust, High Performance JSON Parser and Generator for R
install.packages(jsonlite)
# Interpreted String Literals
install.packages(glue)
```
**Python 2.7**
#### Module needed : 
```python
# A VCFv4.0 and 4.1 parser for Python.
pip install PyVcf
```

### **Tools required** : 
Installation of the Pipeline MutAid v1.0 : https://sourceforge.net/projects/mutaid/

MutAid was developed by Ram Vinay Pandey, last updated in 2016.

Installation of reference files (Human Genome Hg19) thanks to prepref program of MutAid.  
_Warning_ : Need to check if each file is still existing ! 
(For exemple Cosmic.txt file doesn't exist now need to modify directly MutAid Program or need to change URL of UCSC Ftp server)

Space of storage needed for the pipeline : 60 Go


### **Files description** : 
1. **interface.py** : A python script which permit to launch MutAid Pipeline for files of NGS Sequencing and create a csv file which will be use for comparison of variant detections results. 

    _Input_ : A Target File (Use by MutAid) create by the user.   
    _Output_ : Two csv file 
    - test_multi_data_coverage.csv
    - test_multi_data_PACov.csv

    _Process_ : The script will stock all the vcf files and one txt file create by MutAid Pipeline. Then the files will be parse with certain conditions (Ex : Value of Coverage > 10 or SNP Only) to create a csv file.

    Csv file format :   
    test_multi_data_coverage int value 0>n>100  
    test_multi_data_PACov int value 0 or 1  

    M1 : BWA        
    M2 : BOWTIE2    
    M3 : TMAP   
    V1 : SAMTOOLS   
    V2 : FREEBAYES    
    V3 : VARSCAN

    |ID|CHROM|POS|REF|ALT|M1V1|M1V2|M1V3|M2V1|M2V2|M2V3|M3V1|M3V2|M3V3|
    |---|---|---|---|---|---|---|---|---|---|---|---|---|---|
    |str(individuals)|str(chromosome)|int(position)|string(nucleotide)|string(nucleotide)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|int(value)|

2. **ui.R / server.R** : A Shiny app where we can load a csv file and analyse the results. 

    _Input_ : A csv file    
    _Output_ : A json file which the user can create with his own data and download it.
    - UpsetInput.json
    
    _Process_ : The application will read a csv file and then the user can look through the data table and look at the summary of the variables. The application will create a specific plot Upset or Gg_miss_Upset that the user can look at. If the user want to have more information about the result of the plot he can create a json file to explore the data in Upset Website. 

    _Warning_ : The application read only csv files. 

### **Utilisation of the Shiny App** :
#### Creation of JSON file : 
In the Data Analyses TabBox you have a tab called Upset JSON file. In this tab the user can create his own JSON file. The basic structure of the file is create by the application following Upset Website Wiki to correspond to the format needed. The user can modify the values of the argument, thanks to that the user can have a JSON file corresponding to his own dataset. In this tab you have also access to the Upset Website and Wiki thanks to their link. 

_Warning_ : You need to have a Github account to use Upset Website (if you don't want to use it locally). Because to load your own dataset Upset Website need to access to the data and description on a publicy accessible web server.



### **Evolution during the Internship** :
- R Piano package exploration
- Utilisation of Fastq Human (Hg19) Single End file (TD Galaxy M1 NGS 2018/2019)
- Creation of PCA on csv files. (With or without handling of missing data (missMDA packages))

### **Amelioration** : 
- Utilisation of an other pipeline for variant detections than MutAid for exemple SeQProcess.
- Here the vcf parser and the creation of the csv file is done by a python script, it can be done by an R script. It's a possible amelioration of the Shiny app. 
- Missing many error handling in the Shiny app, need to add it. 