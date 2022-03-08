function [crec,gammarec]=treefunc(w, totaliter,alpha,lambda,pargamma)
global c gamma;
crec=zeros(totaliter,length(c));
gammarec=zeros(totaliter,length(gamma));
for iter=1:totaliter
    treeprune(alpha,w);
	treeassign(alpha,lambda,pargamma);
    uc=unique(c);
    if mod(iter,100)==0
     disp(iter)
     fprintf('Number of features selected %d .\n',sum(gamma));
  	 fprintf('Observation Assignment .\n');
     disp(c)
     disp(datetime('now'))
     fprintf('Number of Unique Cluster %d .\n',length(uc));
    end

	crec(iter,:)=c;
	gammarec(iter,:)=gamma;

end
end