function result=logPoissonK(k, lambda)
	result=(k-1)*log(lambda)-lambda-gammaln(k);
end