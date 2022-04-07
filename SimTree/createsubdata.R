library(Rcpp)
library(ape)
library(adephylo)
library(RcppArmadillo)
library(R.matlab)

source("leveltoroot.R")

routine<-function(x){

  for(iter in 1:5){

    load(paste("data/dataset_",x,"/scenario_",iter,"/data.RData",sep=""))
    otutable<-data
    load("phylotree.RData")
    tree$node.label<-paste("CROTU",1:tree$Nnode)
    tree$root.edge<-0
    load("treestructure.RData")

    tier<-leveltoroot(tree)
    rownames(treestructure)<-tree$node.label
    colnames(treestructure)<-c(tree$tip.label,tree$node.label)

    
    table<- array(0, dim = c(nrow(treestructure),ncol(treestructure),ncol(otutable)))
    colnames(table)<-colnames(treestructure)
    rownames(table)<-rownames(treestructure)

    link<-as.vector(tree$edge)
    ref<-c(tree$tip.label,tree$node.label)
    ref<-matrix(ref[link],ncol=2)
    
    for(i in 1:ncol(otutable)){
      for(j in (max(tier$otulevel)-1):1){
        tempname1<-names(tier$crotulevel[tier$crotulevel==j])
        for(k in 1:length(tempname1)){
          tempname2<-ref[ref[,1]==tempname1[k],2]
          for(l in 1:length(tempname2)){
            table[tempname1[k],tempname2[l],i]<-ifelse(grepl("CROTU",tempname2[l]),
                                                       sum(table[tempname2[l],,i]),otutable[tempname2[l],i])
          }
        }
      }
    }
    for(j in 1:ncol(otutable)){
     writeMat(paste("data/dataset_",x,"/scenario_",iter,"/children",j,".mat",sep=""),tablesub=table[,,j])
    }
    childrensum<-table[,,1]
    for(j in 2:ncol(otutable)){
      childrensum=childrensum+table[,,j]
    }
    writeMat(paste("data/dataset_",x,"/scenario_",iter,"/childrensum.mat",sep=""),childrensum=childrensum)
  }
}

args <- commandArgs(trailingOnly = TRUE)
SEED <- as.numeric(args[1])
routine(SEED)
# routine(1)