library(ape)
library(R.matlab)
library(magic)
#setwd("C:/Users/YShi7/Box Sync/work/dpdm/FlorenciaData/data/")
setwd("C:/Users/ys8wp/Google Drive/BayesianClustering/FlorenciaData/data")
otutable<-read.csv("otutable.csv",header=TRUE,row.names = 1)
taxonomy<-read.csv("tax.levels.csv",header=TRUE,row.names = 1)
taxonomy$Silva.ref<-NULL
taxonomy<-taxonomy[rownames(otutable),]

tax<-taxonomy[,1:6]
colnames(tax)<-c("Kingdom","Phylum","Class","Order","Family","Genus")
tax$Phylum<-paste(tax$Kingdom,tax$Phylum,sep=".")
tax$Class<-paste(tax$Phylum,tax$Class,sep=".")
tax$Order<-paste(tax$Class,tax$Order,sep=".")
tax$Family<-paste(tax$Order,tax$Family,sep=".")
tax$Genus<-paste(tax$Family,tax$Genus,sep=".")

generarow<-array(0,dim=c(length(unique(tax[,6])),nrow(otutable),ncol(otutable)))
dimnames(generarow)[[1]] <-unique(tax[,6])
dimnames(generarow)[[2]] <-rownames(otutable)
generasum<-matrix(rep(0,length(unique(tax[,6]))*ncol(otutable)),
                  nrow=length(unique(tax[,6])),
                  ncol=ncol(otutable))
for(i in 1:ncol(otutable)){
  for(j in rownames(otutable)){
    generarow[tax[j,6],j,i]<-generarow[tax[j,6],j,i]+otutable[j,i]
  }
  generasum[,i]<-apply(generarow[,,i],1,sum)
}
rownames(generasum)<-unique(tax[,6])

familiesrow<-array(0,dim=c(length(unique(tax[,5])),nrow(generasum),ncol(otutable)))
dimnames(familiesrow)[[1]] <-unique(tax[,5])
dimnames(familiesrow)[[2]] <-rownames(generasum)
familiessum<-matrix(0,
                    nrow=length(unique(tax[,5])),
                    ncol=ncol(otutable))
for(i in 1:ncol(otutable)){
  for(j in rownames(generasum)){
    if(length(unique(tax[tax$Genus==j,5]))>1)
    {
      print(j)
      print(unique(tax[tax$Genus==j,5]))
    }
    familiesrow[unique(tax[tax$Genus==j,5]),j,i]<-familiesrow[unique(tax[tax$Genus==j,5]),j,i]+generasum[j,i]
  }
  familiessum[,i]<-apply(familiesrow[,,i],1,sum)
}
rownames(familiessum)<-unique(tax[,5])

ordersrow<-array(0,dim=c(length(unique(tax[,4])),nrow(familiessum),ncol(otutable)))
dimnames(ordersrow)[[1]] <-unique(tax[,4])
dimnames(ordersrow)[[2]] <-rownames(familiessum)
orderssum<-matrix(rep(0,length(unique(tax[,4]))*ncol(otutable)),
                  nrow=length(unique(tax[,4])),
                  ncol=ncol(otutable))
for(i in 1:ncol(otutable)){
  for(j in rownames(familiessum)){
    ordersrow[unique(tax[tax$Family==j,4]),j,i]<-ordersrow[unique(tax[tax$Family==j,4]),j,i]+familiessum[j,i]
  }
  orderssum[,i]<-apply(ordersrow[,,i],1,sum)
}
rownames(orderssum)<-unique(tax[,4])


classesrow<-array(0,dim=c(length(unique(tax[,3])),nrow(orderssum),ncol(otutable)))
dimnames(classesrow)[[1]] <-unique(tax[,3])
dimnames(classesrow)[[2]] <-rownames(orderssum)
classessum<-matrix(rep(0,length(unique(tax[,3]))*ncol(otutable)),
                   nrow=length(unique(tax[,3])),
                   ncol=ncol(otutable))
for(i in 1:ncol(otutable)){
  for(j in rownames(orderssum)){
    classesrow[unique(tax[tax$Order==j,3]),j,i]<-classesrow[unique(tax[tax$Order==j,3]),j,i]+orderssum[j,i]
  }
  classessum[,i]<-apply(classesrow[,,i],1,sum)
}
rownames(classessum)<-unique(tax[,3])

phylarow<-array(0,dim=c(length(unique(tax[,2])),nrow(classessum),ncol(otutable)))
dimnames(phylarow)[[1]] <-unique(tax[,2])
dimnames(phylarow)[[2]] <-rownames(classessum)
phylasum<-matrix(rep(0,length(unique(tax[,2]))*ncol(otutable)),
                 nrow=length(unique(tax[,2])),
                 ncol=ncol(otutable))
for(i in 1:ncol(otutable)){
  for(j in rownames(classessum)){
    phylarow[unique(tax[tax$Class==j,2]),j,i]<-phylarow[unique(tax[tax$Class==j,2]),j,i]+classessum[j,i]
  }
  phylasum[,i]<-apply(phylarow[,,i],1,sum)
}
rownames(phylasum)<-unique(tax[,2])

kingdomsrow<-array(0,dim=c(length(unique(tax[,1])),nrow(phylasum),ncol(otutable)))
dimnames(kingdomsrow)[[1]] <-unique(tax[,1])
dimnames(kingdomsrow)[[2]] <-rownames(phylasum)
kingdomssum<-matrix(rep(0,length(unique(tax[,1]))*ncol(otutable)),
                    nrow=length(unique(tax[,1])),
                    ncol=ncol(otutable))
for(i in 1:ncol(otutable)){
  for(j in rownames(phylasum)){
    kingdomsrow[unique(tax[tax$Phylum==j,1]),j,i]<-kingdomsrow[unique(tax[tax$Phylum==j,1]),j,i]+phylasum[j,i]
  }
  kingdomssum[,i]<-apply(kingdomsrow[,,i],1,sum)
}
rownames(kingdomssum)<-unique(tax[,1])

dim(generarow)
sum(generarow)
#generarow[1:10,1:10,1]
dim(familiesrow)
sum(familiesrow)
#familiesrow[1:10,1:10,1]
dim(ordersrow)
sum(ordersrow)
#ordersrow[1:10,1:10,1]
dim(classesrow)
sum(classesrow)
#classesrow[1:10,1:10,1]
dim(phylarow)
sum(phylarow)
#phylarow[1:10,1:10,1]
dim(kingdomsrow)
sum(kingdomsrow)
#kingdomsrow[1:10,1:10,1]

tablesub<-adiag(matrix(kingdomssum[,1],nrow=1),kingdomsrow[,,1],phylarow[,,1],classesrow[,,1],
                ordersrow[,,1],familiesrow[,,1],generarow[,,1])
treestructure<-matrix(0,nrow=nrow(tablesub),ncol=ncol(tablesub))

for(i in 1:ncol(otutable)){
  tablesub<-adiag(matrix(kingdomssum[,i],nrow=1),kingdomsrow[,,i],phylarow[,,i],classesrow[,,i],
                  ordersrow[,,i],familiesrow[,,i],generarow[,,i])
  treestructure<-treestructure+tablesub
  writeMat(paste("matlabdata/phylotable",i,".mat",sep=""),tablesub=tablesub)
}
treestructure<-1*(treestructure>0)
str(treestructure)
writeMat("phylotreestructure.mat",treestructure=treestructure)


