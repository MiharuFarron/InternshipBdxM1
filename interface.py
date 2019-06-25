#!/usr/bin/python
#coding: utf8
import os
import sys
import time 
import datetime
import vcf

"""
Domitille COQ--ETCHEGARAY
June 2019
"""


#Time
localtime = time.asctime( time.localtime(time.time()) )

#Initialization of MutAid
target_file = raw_input("Path of the Target File : \n")

#Modification of the file MutAidOptions_NGS
mapper = ["bowtie2","bwa","tmap"]
for arg in mapper : 
    OptionMutaid = open("/net/travail/dcetchegaray/MutAid_v1.0/MutAidOptions_NGS","r")
    text = "" 
    for line in OptionMutaid.readlines():
            if "Mapper_Name" in line and "###" not in line :
                map_name = "Mapper_Name = %s \n"%arg
                text = text + map_name
            elif "Target_File" in line and "#" not in line :
                tag_file = "Target_File = %s \n"%target_file
                text = text + tag_file
            else :
                text = text + line 
    OptionMutaid.close()

#Creation of a file of options for our different test
    File = open("/net/travail/dcetchegaray/MutAid_v1.0/MutAidOptions_Internship","w")
    File.write(text)
    File.close()

#Run MutAid Pipeline

    print "MutAid Pipeline begin at \t"+str(localtime)
    #Directory of the pipeline MutAid
    os.chdir("/net/travail/dcetchegaray/MutAid_v1.0/")
    os.system("./mutaid --option_file MutAidOptions_Internship")

#Copy the files of interest in our directory of work

    print "Copy files of interest begin at \t"+str(localtime)
    #Test if the directory exist if not create a new directory
    if not os.path.isdir("/net/cremi/dcetchegaray/StageBD/DCE/InternshipBdxM1/%s"%(arg)):
        os.mkdir("/net/cremi/dcetchegaray/StageBD/DCE/InternshipBdxM1/%s"%(arg))
    #Copy Freebayes vcf Samtools vcf Varscan txt files
    os.system("cp ./test_output/ngs_output_dir/mapping/%s/*.vcf ./test_output/ngs_output_dir/mapping/%s/*.txt /net/cremi/dcetchegaray/StageBD/DCE/InternshipBdxM1/%s/"%(arg,arg,arg))
    #Cope Varscan vcf file
    os.system("cp ./test_output/ngs_output_dir/variant_files/%s/ptest.vcf /net/cremi/dcetchegaray/StageBD/DCE/InternshipBdxM1/Hg19Galaxy/%s/"%(arg,arg))
    #Directory of our script
    os.chdir("/net/cremi/dcetchegaray/StageBD/DCE/InternshipBdxM1/")

#VCF parser, text parser

print "Parsing files begin at \t"+str(localtime)
varcall = ["","_samtools_variants","_freebayes_variants"]

multi_data= {}
for arg in mapper :
    text = []
    a=0
    file_pos = open("./Hg19Galaxy/%s/ptest_pos.txt"%arg,"r")
    for line in file_pos.readlines() :
        text = text + [line.split()]
        multi_data[text[a][2]] = {"Coverage" : {"tmap" : "NA", "tmap_samtools_variants" : "NA", "tmap_freebayes_variants": "NA","bwa" : "NA", "bwa_samtools_variants" : "NA", "bwa_freebayes_variants": "NA","bowtie2" : "NA", "bowtie2_samtools_variants" : "NA", "bowtie2_freebayes_variants": "NA"}, "VarFreq" : {"tmap" : "NA", "tmap_samtools_variants" : "NA", "tmap_freebayes_variants": "NA","bwa" : "NA", "bwa_samtools_variants" : "NA", "bwa_freebayes_variants": "NA","bowtie2" : "NA", "bowtie2_samtools_variants" : "NA", "bowtie2_freebayes_variants": "NA"}}
        a=a+1
    file_pos.close()
for arg in mapper : 
    for fi in varcall : 
        vcf_reader = vcf.Reader(open("./Hg19Galaxy/%s/ptest%s.vcf"%(arg,fi),"r"))
        for record in vcf_reader :
            if multi_data.has_key(str(record.POS)) == True:
                multi_data[str(record.POS)]["Coverage"]["%s%s"%(arg,fi)] = record.INFO['DP']
                if fi != "" and fi == "_samtools_variants" : 
                    multi_data[str(record.POS)]["VarFreq"]["%s%s"%(arg,fi)] = record.INFO['AF1']
                elif fi != "" and fi == "_freebayes_variants" : 
                    af = record.INFO['AF']
                    multi_data[str(record.POS)]["VarFreq"]["%s%s"%(arg,fi)] = af[0]
            if fi == "" : 
                text_var = open("./Hg19Galaxy/%s/ptest_varscan_variants.txt"%(arg),"r")
                res = []
                a=0
                for line in text_var.readlines() :
                    res = res+[line.split()]
                    if res[a][6] != "VarFreq" :
                        freq = res[a][6]
                        freq = freq.replace("%","")
                        freq = freq.replace(",",".")
                        freqall = float(freq)/100
                        multi_data[str(record.POS)]["VarFreq"]["%s%s"%(arg,fi)] = str(freqall)
                    a=a+1
                text_var.close()

# Creation of multivariate data table 

print "Creation of csv files begin at \t"+str(localtime)
multi_data_file = open("test_multi_data_coverage.csv","w")
multi_data_file2 = open("test_multi_data_allfreq.csv","w")
header = "POS"+"\t"+"bwafree"+"\t"+"bwavar"+"\t"+"tmapvar"+"\t"+"bwasam"+"\t"+"bowtie2free"+"\t"+"bowtie2sam"+"\t"+"tmapfree"+"\t"+"tmapsam"+"\t"+"bowtie2var"+"\n"
multi_data_file.write(header)
multi_data_file2.write(header)
for key,value in multi_data.items() :
    multi_data_file.write(str(key)+"\t")
    multi_data_file2.write(str(key)+"\t")
    for key2,value2 in value.items() :
        a=0
        for invalue in value2.values() :
            if key2 == "Coverage" : 
                if a == 8 :
                    multi_data_file.write(str(invalue)+"\n")
                else : 
                    multi_data_file.write(str(invalue)+"\t")
            elif key2 == "VarFreq" :
                if a == 8 :
                    multi_data_file2.write(str(invalue)+"\n")
                else : 
                    multi_data_file2.write(str(invalue)+"\t")
            a=a+1

multi_data_file.close()
multi_data_file2.close()
print "End of Script at\t"+str(localtime)