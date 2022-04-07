leveltoroot<-function(tree){
  tree$node.label<-paste("CROTU",1:length(tree$node.label))
  tiplist<-listTips(tree)
  tier<-list(length(tree$tip.label)+1)
  tier<-c(tier,list(tree$edge[tree$edge[,1]==length(tree$tip.label)+1,2]))
  for(i in 3:length(tree$node.label)){
    tier<-c(tier,list(tree$edge[tree$edge[,1] %in% tier[[i-1]],2]))
  }
  tier<-tier[lapply(tier,sum)>0]
  crotulevel<-rep(0,length(tree$node.label))
  otulevel<-rep(0,length(tree$tip.label))
  names(crotulevel)<-tree$node.label
  names(otulevel)<-tree$tip.label
  for(i in 1:length(tier)){
    tempnames<-tree$tip.label[tier[[i]][tier[[i]]<=length(tree$tip.label)]]
    otulevel[tempnames[tempnames%in%tree$tip.label]]<-i
    tempnames<-paste("CROTU",tier[[i]][tier[[i]]>length(tree$tip.label)]-length(tree$tip.label))
    crotulevel[tempnames[tempnames%in%tree$node.label]]<-i
  }
  list(crotulevel=crotulevel,otulevel=otulevel)
}
