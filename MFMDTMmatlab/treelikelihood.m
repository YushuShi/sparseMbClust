function likelihood=treelikelihood(alpha, choice,int1, int2)
global table tree c;
uniquec=unique(c);
xtemp1=squeeze(table(int1,:,:));
xtemp=xtemp1;
    if choice==3
        xtemp2=squeeze(table(int2,:,:));
        temp1=0.0;
		temp2=0.0;
		sectemp1=0.0;
		sectemp2=0.0;

        for i=1:length(uniquec)
            tempmat1=xtemp1(:,c==uniquec(i));
            tempmat2=xtemp2(:,c==uniquec(i));
            tempvec1=sum(tempmat1,2);
            tempvec2=sum(tempmat2,2);

            temp3=0.0;
			sectemp3=0.0;
            for j=1:size(tree,2)
                if tree(int1,j)>0
				 temp1=temp1+gammaln(alpha+tempvec1(j));
				 temp3=temp3+alpha+tempvec1(j);

                end
                 if tree(int2,j)>0
				 sectemp1=sectemp1-gammaln(alpha+tempvec2(j));
				 sectemp3=sectemp3+alpha+tempvec2(j);  

                 end
            end
            temp2=temp2-gammaln(temp3);
			sectemp2=sectemp2+gammaln(sectemp3);
        end
        	temp5=0.0;
			temp6=0.0;
			sectemp5=0.0;
			sectemp6=0.0;
            xvec1=sum(xtemp1,2);
            xvec2=sum(xtemp2,2);

            for j=1:size(tree,2)
                if tree(int1,j)>0
				 temp5=temp5-gammaln(alpha+xvec1(j));
				 temp6=temp6+alpha+xvec1(j);	

                end
                if tree(int2,j)>0
				 sectemp5=sectemp5+gammaln(alpha+xvec2(j));
				 sectemp6=sectemp6+alpha+xvec2(j);

                end
            end
            likelihood=(length(uniquec)-1.0)*(gammaln(sum(tree(int1,:))*alpha)...
                -sum(tree(int1,:))*gammaln(alpha)...
                -gammaln(sum(tree(int2,:))*alpha)...
			+sum(tree(int2,:))*gammaln(alpha))...
			+gammaln(temp6)-gammaln(sectemp6)+sectemp5+temp5...
			+temp1+temp2+sectemp1+sectemp2;

    elseif choice==2
        temp1=0.0;
		temp2=0.0;

		for i=1:length(uniquec)
		  tempmat=xtemp(:,c==uniquec(i));
          tempvec=sum(tempmat,2);

		  temp3=0.0;
		   for j=1:size(tree,2)
               if tree(int1,j)>0
				 temp1=temp1+gammaln(alpha+tempvec(j));
				 temp3=temp3+alpha+tempvec(j);

               end 
           end
		 temp2=temp2-gammaln(temp3);
        end
		temp4=0.0;
		temp5=0.0;
        xvec=sum(xtemp,2);

       for j=1:size(tree,2)
           if tree(int1,j)>0
             temp4=temp4-gammaln(alpha+xvec(j));
             temp5=temp5+alpha+xvec(j);

           end  
       end
		likelihood=(length(uniquec)-1.0)*(gammaln(sum(tree(int1,:))*alpha)-...
        sum(tree(int1,:))*gammaln(alpha))...
		+temp1+temp2+temp4+gammaln(temp5);

    else
        temp1=0.0;
		temp2=0.0;

          for i=1:length(uniquec)
              tempmat=xtemp(:,c==uniquec(i));
              tempvec=sum(tempmat,2);
              temp3=0.0;
              for j=1:size(tree,2)
               if tree(int1,j)>0
                    temp1=temp1-gammaln(alpha+tempvec(j));
                    temp3=temp3+alpha+tempvec(j);
               end
              end   
             temp2=temp2+gammaln(temp3);
          end
		
		temp4=0.0;
		temp5=0.0;
		xvec=sum(xtemp,2);
        for j=1:size(tree,2)
               if tree(int1,j)>0
				temp4=temp4+gammaln(alpha+xvec(j));
				temp5=temp5+alpha+xvec(j);
               end
        end 	  
		likelihood=(length(uniquec)-1.0)*(sum(tree(int1,:))*gammaln(alpha)-...
        gammaln(sum(tree(int1,:))*alpha))...
		+temp1+temp2+temp4-gammaln(temp5);
    end
end