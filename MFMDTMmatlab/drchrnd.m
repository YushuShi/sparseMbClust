function theta = drchrnd(alpha,n)

p = length(alpha);
r = zeros(p,n);

if size(alpha,2)>size(alpha,1)
   alpha = alpha';
end;   

if 0   
	for i = 1:n
		theta(:,i) = gamrnd(alpha,1);
		theta(:,i) = theta(:,i) / sum(theta(:,i));
	end;       
else
	% faster version
	theta = gamrnd(repmat(alpha,1,n),1,p,n);   
	theta = theta ./ repmat(sum(theta,1),p,1);
end;


return;