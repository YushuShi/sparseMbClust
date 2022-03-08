function lprob=ll2vs1(sumslice1,sumslice2,tree,alpha)
lprob=0.0;
    for iter1=1:size(tree,1)
       temp1=0.0;
       temp2=0.0;
       temp3=0.0;
       temp4=0.0;
       temp5=0.0;
       temp6=0.0;

       for iter2=1:size(tree,2)
           if tree(iter1,iter2)>0
            temp1=temp1+sumslice1(iter1,iter2)+alpha;
            temp2=temp2+gammaln(sumslice1(iter1,iter2)+alpha);
            temp3=temp3+sumslice2(iter1,iter2)+alpha;
            temp4=temp4+gammaln(sumslice2(iter1,iter2)+alpha);
            temp5=temp5+sumslice1(iter1,iter2)+sumslice2(iter1,iter2)+alpha;
            temp6=temp6+gammaln(sumslice1(iter1,iter2)+sumslice2(iter1,iter2)+alpha);

           end
       end
    lprob=lprob+gammaln(alpha*sum(tree(iter1,:)))-sum(tree(iter1,:))*gammaln(alpha)+...
    temp2-gammaln(temp1)+temp4-gammaln(temp3)-temp6+gammaln(temp5);
    end
end