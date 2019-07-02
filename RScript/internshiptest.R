library(FactoMineR)
library(missMDA)
library(BBmisc)
library(UpSetR)
library(naniar)

####MISSMDA
#Couverture
coverage <- read.csv("./OutputData/test_multi_data_coverage.csv",header=TRUE,sep="\t")
row.names(coverage) <- coverage$POS
coverage <- coverage[,-1]
summary(coverage)
#Gestion des NA
comp <- imputePCA(coverage,ncp=2,scale=TRUE)
res.pca <- PCA(comp$completeObs)
#Sans gestion
res.pca <- PCA(coverage,scale.unit = TRUE,ncp=2,graph=T)

# #AllFreq
# allfreq <- read.csv("test_multi_data_allfreq.csv",header=TRUE,sep="\t")
# summary(allfreq)
# row.names(allfreq) <- allfreq$POS
# allfreq <- allfreq[,-1]
# normalize(allfreq, method = "standardize", range = c(0, 1), margin = 1L, on.constant = "quiet")
# #Gestion des NA
# comp2 <- imputePCA(allfreq,ncp=2,scale=FALSE)
# res.pca2 <- PCA(comp2$completeObs)
# #Sans gestion
# res.pca2 <- PCA(allfreq,scale.unit = TRUE,ncp=2,graph=T)


####UPSETR
PA <- read.csv("./OutputData/test_multi_data_coverage.csv",header=TRUE,sep="\t")
row.names(PA) <- as.numeric(PA$POS)
PA <- PA[,-1]
summary(PA)
write.csv(PA,"./OutputData/RMultidatacov.csv")
upset(PA,nsets=10,order.by="freq",sets.x.label = "Combinaison of mapper/variantcaller",empty.intersections = "on")
gg_miss_upset(PA,nsets=10)
