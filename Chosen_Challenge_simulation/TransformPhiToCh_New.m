function [Ch] = TransformPhiToCh_New(APhi,nRows, ChalSize)
%TRANSFORMPHITOCHAL Summary of this function goes here
%   Detailed explanation goes here
Ch=zeros(nRows,ChalSize);
Phi=ones(1,ChalSize+1);
temp1=1;
for i=1:nRows
    Phi=APhi(i,:);    
    for j=1:ChalSize
        if Phi(ChalSize+1-j) == Phi(ChalSize+2-j)
            Ch(i,ChalSize+1-j) = 0;
        else
            Ch(i,ChalSize+1-j) = 1;
        end
    end
end
end

