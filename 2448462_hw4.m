N=4145;      % size of the Monte Carlo simulation with alpha = 0.005 and error = 0.02
lambdaauto = 50;  
lambdatruck=10;
alphacar=190;
alphatruck=110;
pois1=0.15;
pois2=0.01;
TotalWeight=zeros(N,1); % a vector that keeps the total weight of the caught fish for each Monte Carlo run
for k=1:N
	U = rand;
	U1=rand;
	i = 0; 
	i1=0;
	F = exp(-lambdaauto);
	F1 = exp(-lambdatruck);
    while (U>=F)
		i=i+1;
		F = F+exp(-lambdaauto)*(lambdaauto^i)/gamma(i+1);
    end
    while (U1>=F1)
		i1=i1+1;
		F1 = F1+exp(-lambdatruck)*(lambdatruck^i1)/gamma(i1+1);
    end
	 
	weight = 0; 
	weight1 = 0;
	
	
    for f=1:i
		w1 = sum( -1/pois1 * log(rand(alphacar,1)) );
		weight = weight + w1;	
		
    end
    for f=1:i1
		w2 = sum( -1/pois2 * log(rand(alphatruck,1)) );
		weight1 = weight1 + w2;	
		
    end
	TotalWeight(k) = weight+weight1;
end



expectedWeight = mean(TotalWeight);
p_est = mean(TotalWeight>200000);

stdWeight = std(TotalWeight);
fprintf('Estimated probability = %f\n',p_est);
fprintf('Expected weight = %f\n',expectedWeight);
fprintf('Standard deviation = %f\n',stdWeight);