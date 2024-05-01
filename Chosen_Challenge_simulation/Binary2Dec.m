function [DecVector] = Binary2Dec(ArrayBin,vecLng)
%BINARY2DEC Summary of this function goes here
%   Detailed explanation goes here

ArrayLength=size(ArrayBin,2);%to give 64 as bit length
DecNo=ArrayLength/vecLng;% 64/8= number of decimal values in DecVector

DecVector= zeros(1,DecNo,'uint8');
temp=0;
for i = 1:DecNo
        x=ArrayBin(1,(i-1)*vecLng+1:i*vecLng);
        for j=1:8
           temp =temp+x(j)* (2.^(8-j));
            
        end
    DecVector(i)=temp;
    temp=0; 
end
end

