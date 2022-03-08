function treeprune(alpha,w)
global gamma;
t=20;
ratio1=0.0;
int1=0;
int2=0;
choice=0;
    for i=1:t
        dice1=1;
        if(sum(gamma)<length(gamma))&&(sum(gamma)>0)
        dice1=binornd(1,0.5);
        end
            if dice1==1
                int1=randsample(length(gamma),1);
                int2=gamma(int1);
                if int2==1
                    choice=1;
                    % from clustering to nonclustering
                    ratio1=log(1.0-w)-log(w);
                else
                    choice=2;
                    ratio1=log(w)-log(1.0-w);
                end
            else
                gamma0=find(gamma==0);
                gamma1=find(gamma==1);
                if~(isempty(gamma0)||isempty(gamma1))
                choice=3;
                int1=gamma0(randsample(length(gamma0),1));
                int2=gamma1(randsample(length(gamma1),1));
                end
            end
        if choice>0
        lr=treelikelihood(alpha,choice,int1,int2);
        dice2=binornd(1,min(1.0,exp(lr+ratio1)));
        if dice2==1
            if dice1==1
                gamma(int1)=1-int2;
            else
            gamma(int1)=1;
            gamma(int2)=0;
            end
        end
        end
     end
end