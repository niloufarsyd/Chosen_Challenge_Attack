function [DecChalSet] = DecChalGen(ChalMatrix,ChalSize,vecLng)
%DECCHALSET Summary of this function goes here
%   Detailed explanation goes here
k=ChalSize/vecLng;
n=size(ChalMatrix,1);
DecChalSet=zeros(n,k);
for i=1:n
   DecChalSet(i,:) =Binary2Dec(ChalMatrix(i,:),vecLng);
    
end
end

