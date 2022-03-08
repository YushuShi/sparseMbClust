%t is R in the paper
%lambda is the lambda in Poisson distribution
%k is m in the paper
%parlambda is par eta in the paper

function result= logV(pargamma,n,t,lambda)
	tolerance=10^(-12);
	temp1=0;
	temp2=0;
	p=0;
	upperlimit=100;
    
    for k=t:upperlimit
        if(abs(temp1-temp2) > tolerance) || (p < (1.0-tolerance))
			temp1=temp2;
			temp2=temp2+exp(gammaln(k+1)-gammaln(k-t+1)-gammaln(k*pargamma+n)+gammaln(k*pargamma)...
                + logPoissonK(k,lambda));
			p=p+exp(logPoissonK(k,lambda));
        end
    end
	result= log(temp2);
 end
