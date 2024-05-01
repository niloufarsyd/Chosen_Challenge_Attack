function [Ch] = TransformPhiToCh(APhi,nRows, ChalSize)
%TRANSFORMPHITOCHAL Summary of this function goes here
%   Detailed explanation goes here
Ch=zeros(nRows,ChalSize);
Phi=ones(1,ChalSize+1);
temp1=1;
for i=1:nRows
    Phi=APhi(i,:);    
    for j=1:ChalSize
        temp2=Phi(ChalSize+1-j);
        Ch(i,ChalSize+1-j)=(1-temp2*temp1)/2;
        temp1=temp2;  
    end
end
end

