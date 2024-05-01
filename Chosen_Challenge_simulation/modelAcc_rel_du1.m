
function f = modelAcc_rel_du1(W_random,W_real,Phi0,Phi1,nXOR,nSamples,ChalSize,sigma,sigmaNoise)
m=size(Phi0,1);
w2=zeros(m*ChalSize+1,1);
w1=zeros(m*ChalSize+1,1);
temp=zeros(1,ChalSize+1);
for e=1:m
w1((e-1)*65+1:e*65,1)=W_real(m,:).';
end 
for e=1:m
   % w2(e,:)=WeightTransform(W_random,nXOR,Phi0(e,:),Phi1(e,:),nSamples,ChalSize,sigma,sigmaNoise);

    %%%%may not correct
    temp = WeightTransform((W_random).',nXOR,Phi0(e,:),Phi1(e,:),nSamples,ChalSize,sigma,sigmaNoise).';
    w2((e-1)*65+1:e*65,1)=temp.';
end

% for e=1:m
%     w2((e-1)*65+1:e*65,1)=W_random.';
% 
% end

       
    r = corrcoef(w1,w2,'rows','complete');
    f = r(1,2);
end