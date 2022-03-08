function treeassign(alpha,lambda,pargamma)
global table tree c gamma;
cho2=randsample(length(c),2,false);
i=cho2(1);
l=cho2(2);
combinedpool=find((c==c(i))|(c==c(l)));
treesub=tree(gamma>0,:);
tablesub=table(gamma>0,:,:);
    if length(combinedpool)==2
        simplesplitmerge(tablesub,treesub,i,l,alpha,lambda,pargamma);
    else
        launchsplitmerge(tablesub,treesub,i,l,combinedpool,alpha,lambda,pargamma);	
    end
end
