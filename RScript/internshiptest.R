library(FactoMineR)
library(missMDA)
#Couverture
coverage <- read.csv("test_multi_data_coverage.csv",header=TRUE,sep="\t")
#Gestion des NA
comp <- imputePCA(coverage,ncp=2,scale=TRUE)
res.pca <- PCA(comp$completeObs)
#Sans gestion
res.pca <- PCA(coverage,scale.unit = TRUE,quali.sup=1,ncp=2,graph=T)

#AllFreq
allfreq <- read.csv("test_multi_data_allfreq.csv",header=TRUE,sep="\t")
#Gestion des NA
comp2 <- imputePCA(allfreq,ncp=2,scale=FALSE)
res.pca2 <- PCA(comp2$completeObs)
#Sans gestion
res.pca2 <- PCA(allfreq,scale.unit = TRUE,quali.sup=1,ncp=2,graph=T)
