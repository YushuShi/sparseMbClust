function MFMDTM(w)
alpha=1; %parameter for Dirichlet of tree nodes
lambda=1; %parameter for Poisson distribution in MFM
pargamma=1; % parameter for Dirichlet distribution in MFM
tableall=zeros(173,2976,30);
global tree;
load phylotreestructure.mat
tree=treestructure; %load the tree structure

for i = 1:30 %load a dataset
load(['scenario_5/children'  num2str(i) '.mat']);
tableall(:,:,i)=tablesub;
end
global table;
table=tableall; % load the matrix (with phylogenetic information) for each observation.
global c;
c=repelem(1,size(table,3)); % the cluster assignment vector
global gamma;
gamma=repelem(1,size(table,1)); % the feature selection vector

totaliter=2000;
table=table./50; % The scaling parameter is determined by the maximum sequencing depth divided by 300.
if w==0
    % you assume a hyperprior for w. Here we assume w~Beta(1,1)
    wa=1;
    wb=1;
    [crec,gammarec]=treefuncHier(wa, wb, totaliter,alpha,lambda,pargamma);
else
  [crec,gammarec]=treefunc(w, totaliter,alpha,lambda,pargamma);
end

save('crec.mat','crec')
save('gammarec.mat','gammarec')
end
