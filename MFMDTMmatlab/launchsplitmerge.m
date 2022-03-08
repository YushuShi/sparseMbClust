function launchsplitmerge(table, tree, i,l, combinedpool, alpha,lambda,pargamma)
global c;
t=5;
lprob=0.0;
netpool=combinedpool((combinedpool~=i)&(combinedpool~=l));
launch=c(netpool);
launch=c(i)* binornd(1,repmat(0.5,1,length(launch)));
    if c(i)==c(l)
        launch(launch==0)=max(c)+1;
        for iter0=1:t              
            for iter1=1:length(launch)
            n1=sum(launch==c(i))+1;
            n2=sum(launch==max(c)+1)+1;
            fullsumslice1=sum(table(:,:,netpool(launch==c(i))),3)+squeeze(table(:,:,i));
            fullsumslice2=sum(table(:,:,netpool(launch==max(c)+1)),3)+squeeze(table(:,:,l));
            tempmat=squeeze(table(:,:,netpool(iter1)));
                if launch(iter1)==c(i)
                   sumslice1=fullsumslice1-tempmat;
				   sumslice2=fullsumslice2;
				   n1=n1-1;
                else
                   sumslice2=fullsumslice2-tempmat;
                   n2=n2-1;
                   sumslice1=fullsumslice1;
                end
                	temp1=0.0;
					temp2=0.0;
					temp3=0.0;
					temp4=0.0;
					sectemp1=0.0;
					sectemp2=0.0;
					sectemp3=0.0;
					sectemp4=0.0;
                    for iter2=1:size(tree,1)
                        temp5=0.0;
						temp6=0.0;
						sectemp5=0.0;
						sectemp6=0.0;
                        for iter3=1:size(tree,2)
                            if(tree(iter2,iter3)>0)
							temp5=temp5+alpha+sumslice1(iter2,iter3);
							temp2=temp2-gammaln(alpha+sumslice1(iter2,iter3));
							temp6=temp6+alpha+sumslice1(iter2,iter3)+table(iter2,iter3,netpool(iter1));
							temp4=temp4+gammaln(alpha+sumslice1(iter2,iter3)...
							+table(iter2,iter3,netpool(iter1)));
							sectemp5=sectemp5+alpha+sumslice2(iter2,iter3);
							sectemp2=sectemp2-gammaln(alpha+sumslice2(iter2,iter3));
							sectemp6=sectemp6+alpha+sumslice2(iter2,iter3)...
                                +table(iter2,iter3,netpool(iter1));
							sectemp4=sectemp4+gammaln(alpha+sumslice2(iter2,iter3)+...
							table(iter2,iter3,netpool(iter1)));	
                            end
                        end
                        temp1=temp1+gammaln(temp5);
						temp3=temp3-gammaln(temp6);
						sectemp1=sectemp1+gammaln(sectemp5);
						sectemp3=sectemp3-gammaln(sectemp6);
                    end
                    lognominator=temp1+temp2+temp3+temp4;
                    lognominator2=sectemp1+sectemp2+sectemp3+sectemp4;
                    assignprob=n1/(n1+n2*exp(lognominator2-lognominator));
                    if binornd(1,assignprob)
                       launch(iter1)=c(i);
						if iter0==t
							 lprob=lprob-log(n1)+log(n1+n2*exp(lognominator2-lognominator));
                        end
                    else
                       launch(iter1)=max(c)+1;
						if iter0==t
							lprob=lprob-log(n2)+log(n2+n1*exp(lognominator-lognominator2));
                        end
                    end
            end
        end
      sumslice1=sum(table(:,:,netpool(launch==c(i))),3)+squeeze(table(:,:,i));
      sumslice2=sum(table(:,:,netpool(launch==(max(c)+1))),3)+squeeze(table(:,:,l));
      lprob=lprob+ll2vs1(sumslice1,sumslice2,tree,alpha);  
      
      paddingvalue=-gammaln(pargamma+length(launch)+2)-gammaln(pargamma)...
          +gammaln(pargamma+sum(launch==c(i))+1)+gammaln(pargamma+sum(launch==(max(c)+1))+1)...
          -logV(pargamma,length(c),length(unique(c)),lambda)+logV(pargamma,length(c),length(unique(c))+1,lambda);
      
      lprob=lprob+paddingvalue;
    else
    launch(launch==0)=c(l);
    initlaunch=c(netpool);
        for iter0=1:t
            for iter1=1:length(launch)
            n1=sum(launch==c(i))+1;
            n2=sum(launch==c(l))+1;
			fullsumslice1=sum(table(:,:,netpool(launch==c(i))),3)+squeeze(table(:,:,i));
            fullsumslice2=sum(table(:,:,netpool(launch==c(l))),3)+squeeze(table(:,:,l));  
                if launch(iter1)==c(i)
                    sumslice1=fullsumslice1-squeeze(table(:,:,netpool(iter1)));
                    n1=n1-1;
                    sumslice2=fullsumslice2;
                else
                    sumslice2=fullsumslice2-squeeze(table(:,:,netpool(iter1)));
                    n2=n2-1;
                    sumslice1=fullsumslice1;
                end
                temp1=0.0;
                temp2=0.0;
                temp3=0.0;
                temp4=0.0;
                sectemp1=0.0;
                sectemp2=0.0;
                sectemp3=0.0;
                sectemp4=0.0;
                for iter2=1:size(tree,1)
                    temp5=0.0;
                    temp6=0.0;
                    sectemp5=0.0;
                    sectemp6=0.0;
                    for iter3=1:size(tree,2)
                        if(tree(iter2,iter3)>0)
                        temp5=temp5+alpha+sumslice1(iter2,iter3);
                        temp2=temp2-gammaln(alpha+sumslice1(iter2,iter3));
                        temp6=temp6+alpha+sumslice1(iter2,iter3)+table(iter2,iter3,netpool(iter1));
                        temp4=temp4+gammaln(alpha+sumslice1(iter2,iter3)...
                            +table(iter2,iter3,netpool(iter1)));
                        sectemp5=sectemp5+alpha+sumslice2(iter2,iter3);
                        sectemp2=sectemp2-gammaln(alpha+sumslice2(iter2,iter3));
                        sectemp6=sectemp6+alpha+sumslice2(iter2,iter3)+table(iter2,iter3,netpool(iter1));
                        sectemp4=sectemp4+gammaln(alpha+sumslice2(iter2,iter3)+...
						table(iter2,iter3,netpool(iter1)));
                        end
                    end
                    temp1=temp1+gammaln(temp5);
                    temp3=temp3-gammaln(temp6);
                    sectemp1=sectemp1+gammaln(sectemp5);
                    sectemp3=sectemp3-gammaln(sectemp6);
                end
                lognominator=log(n1)+temp1+temp2+temp3+temp4;
                lognominator2=log(n2)+sectemp1+sectemp2+sectemp3+sectemp4;
                assignprob=1/(1+exp(lognominator2-lognominator));
                if binornd(1,assignprob)
                    launch(iter1)=c(i);
                else
                    launch(iter1)=c(l);
                end
            end
        end
        n1orig=sum(initlaunch==c(i))+1;
        n2orig=sum(initlaunch==c(l))+1;
        fullsumslice1=sum(table(:,:,netpool(initlaunch==c(i))),3)+squeeze(table(:,:,i));
        fullsumslice2=sum(table(:,:,netpool(initlaunch==c(l))),3)+squeeze(table(:,:,l));
        for iter1=1:length(launch)
            if initlaunch(iter1)==c(i)
                sumslice1=fullsumslice1-squeeze(table(:,:,netpool(iter1)));
                sumslice2=fullsumslice2;
                n1=n1orig-1;
                n2=n2orig;
            else
                sumslice2=fullsumslice2-squeeze(table(:,:,netpool(iter1)));
                sumslice1=fullsumslice1;
                n2=n2orig-1;
                n1=n1orig;
            end
            temp1=0.0;
            temp2=0.0;
            temp3=0.0;
            temp4=0.0;
            sectemp1=0.0;
            sectemp2=0.0;
            sectemp3=0.0;
            sectemp4=0.0;
            for iter2=1:size(tree,1)
                temp5=0.0;
                temp6=0.0;
                sectemp5=0.0;
                sectemp6=0.0;
                for iter3=1:size(tree,2)
                    if(tree(iter2,iter3)>0)
                    temp5=temp5+alpha+sumslice1(iter2,iter3);
                    temp2=temp2-gammaln(alpha+sumslice1(iter2,iter3));
                    temp6=temp6+alpha+sumslice1(iter2,iter3)...
                    +table(iter2,iter3,netpool(iter1));
                    temp4=temp4+gammaln(alpha+sumslice1(iter2,iter3)...
                    +table(iter2,iter3,netpool(iter1)));
                    sectemp5=sectemp5+alpha+sumslice2(iter2,iter3);
                    sectemp2=sectemp2-gammaln(alpha+sumslice2(iter2,iter3));
                    sectemp6=sectemp6+alpha+sumslice2(iter2,iter3)...
                    +table(iter2,iter3,netpool(iter1));
                    sectemp4=sectemp4+gammaln(alpha+sumslice2(iter2,iter3)+...
                    table(iter2,iter3,netpool(iter1)));
                    end
                end
                temp1=temp1+gammaln(temp5);
                temp3=temp3-gammaln(temp6);
                sectemp1=sectemp1+gammaln(sectemp5);
                sectemp3=sectemp3-gammaln(sectemp6);
            end
            lognominator=temp1+temp2+temp3+temp4;
            lognominator2=sectemp1+sectemp2+sectemp3+sectemp4;
        if launch(iter1)==c(i)
            lprob=lprob+log(n1)-log(n1+n2*exp(lognominator2-lognominator));
        else
            lprob=lprob+log(n2)-log(n2+n1*exp(lognominator-lognominator2));
        end
        end
        sumslice1=sum(table(:,:,netpool(initlaunch==c(i))),3)+squeeze(table(:,:,i));
		sumslice2=sum(table(:,:,netpool(initlaunch==c(l))),3)+squeeze(table(:,:,l));
		lprob=lprob-ll2vs1(sumslice1,sumslice2,tree,alpha);
        paddingvalue=-gammaln(pargamma+size(initlaunch)+2)-gammaln(pargamma)...
          +gammaln(pargamma+sum(initlaunch==c(i))+1)+gammaln(pargamma+sum(initlaunch==c(l))+1)...
          -logV(pargamma,length(c),length(unique(c)),lambda)+logV(pargamma,length(c),length(unique(c))+1,lambda);
      lprob=lprob-paddingvalue;
    end
    if c(i)==c(l)
        prob=min(1.0,exp(lprob));
        if binornd(1,prob)
            rec=max(c)+1;
            c(l)=rec;
            index=netpool(launch==rec);
            c(index)=rec;
        end
    else
        prob=min(1.0,exp(lprob));
        if binornd(1,prob)
            c(i)=c(l);
            c(netpool)=c(l);
        end
    end
end