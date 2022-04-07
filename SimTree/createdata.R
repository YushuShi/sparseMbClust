library(MCMCpack)
library(ape)
load("datarow.RData")
load("crotu1.RData")
load("crotu2.RData")
nobs<-30
data1<-matrix(rep(0,nobs/2*length(datarow)),nrow=length(datarow))
data2<-matrix(rep(0,nobs/2*length(datarow)),nrow=length(datarow))  

routine<-function(x){
  set.seed(x)
  dir.create(paste("data/dataset_",x,sep=""))
  for(iter in 1:5){
    template1<-datarow
    template2<-datarow
    template1[crotu1]<-template1[crotu1]*(sum(datarow[crotu1])+0.0256*iter)/sum(datarow[crotu1])
    template1[crotu2]<-template1[crotu2]*(sum(datarow[crotu2])-0.0256*iter)/sum(datarow[crotu2])
    template2[crotu1]<-template2[crotu1]*(sum(datarow[crotu1])-0.0256*iter)/sum(datarow[crotu1])
    template2[crotu2]<-template2[crotu2]*(sum(datarow[crotu2])+0.0256*iter)/sum(datarow[crotu2])
    for(j in 1:(nobs/2)){
      data1[,j]<-rmultinom(1,15000,rdirichlet(1,template1*200))
      data2[,j]<-rmultinom(1,15000,rdirichlet(1,template2*200))
    }
    data<-cbind(data1,data2)
    rownames(data)<-names(datarow)
    dir.create(paste("data/dataset_",x,"/scenario_",iter,sep=""))
    save(data,file=paste("data/dataset_",x,"/scenario_",iter,"/data.RData",sep=""))
  }
}
args <- commandArgs(trailingOnly = TRUE)
SEED <- as.numeric(args[1])
routine(SEED)
#routine(1)
