function simplesplitmerge(table, tree, i, l, alpha, lambda, pargamma)
global c;
 nxi=table(:,:,i);
 nxl=table(:,:,l);
 twovsone=0.0;
 for iter1=1:size(tree,1)
    temp1=0.0;
	temp2=0.0;
	temp3=0.0;
	temp4=0.0;
	temp5=0.0;
	temp6=0.0;
	twovsone=twovsone+gammaln(sum(tree(iter1,:))*alpha)-sum(tree(iter1,:))*gammaln(alpha);
		 for iter2=1:size(tree,2)
             if(tree(iter1,iter2)>0)
				temp1=temp1+gammaln(alpha+nxi(iter1,iter2));
				temp2=temp2+gammaln(alpha+nxl(iter1,iter2));
				temp3=temp3-gammaln(alpha+nxi(iter1,iter2)+nxl(iter1,iter2));
				temp4=temp4+alpha+nxi(iter1,iter2);
				temp5=temp5+alpha+nxl(iter1,iter2);
				temp6=temp6+alpha+nxi(iter1,iter2)+nxl(iter1,iter2); 
             end
         end
	twovsone=twovsone+temp1+temp2+temp3-gammaln(temp4)-gammaln(temp5)+gammaln(temp6);	
 end
 paddingvalue=-log(pargamma+1.0)+log(pargamma)-logV(pargamma,length(c),length(unique(c)),lambda)...
			+logV(pargamma,length(c),length(unique(c))+1,lambda);
 if c(i)==c(l)
     prob=min(1.0,exp(paddingvalue+twovsone));
     if binornd(1,prob)
        c(i)=max(c)+1;
     end
 else
     prob=min(1.0,exp(-paddingvalue-twovsone));
     if binornd(1,prob)
        c(i)=c(l);
     end
 end
end