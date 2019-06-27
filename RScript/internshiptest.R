library(FactoMineR)
library(missMDA)
library(BBmisc)
library(UpSetR)

####MISSMDA
#Couverture
coverage <- read.csv("test_multi_data_coverage2.csv",header=TRUE,sep="\t")
row.names(coverage) <- coverage$POS
coverage <- coverage[,-1]
hist(na.omit(coverage$bwasam),xlim=c(0,10),breaks=500)
summary(coverage)
#Gestion des NA
comp <- imputePCA(coverage,ncp=2,scale=TRUE)
res.pca <- PCA(comp$completeObs)
#Sans gestion
res.pca <- PCA(coverage,scale.unit = TRUE,ncp=2,graph=T)

#AllFreq
allfreq <- read.csv("test_multi_data_allfreq.csv",header=TRUE,sep="\t")
summary(allfreq)
row.names(allfreq) <- allfreq$POS
allfreq <- allfreq[,-1]
normalize(allfreq, method = "standardize", range = c(0, 1), margin = 1L, on.constant = "quiet")
#Gestion des NA
comp2 <- imputePCA(allfreq,ncp=2,scale=FALSE)
res.pca2 <- PCA(comp2$completeObs)
#Sans gestion
res.pca2 <- PCA(allfreq,scale.unit = TRUE,ncp=2,graph=T)


####UPSETR
PA <- read.csv("test_multi_data_PA.csv",header=TRUE,sep="\t")
row.names(PA) <- as.numeric(PA$POS)
PA <- PA[,-1]
summary(PA)
upset(PA,nsets=10,order.by="freq")
