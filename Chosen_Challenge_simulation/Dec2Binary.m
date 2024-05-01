function [BinaryValue] = Dec2Binary(DataSet)
%DEC@BINARY Summary of this function goes here
%   Detailed explanation goes here
nTrain=size(DataSet,1);
DecNo=size(DataSet,2);
BinaryValue=zeros(nTrain,DecNo*8);


for i=1:nTrain
    data1=DataSet(i,:);
    for j=1:DecNo
        DecValue=data1(:,j);
        x=fix(rem(DecValue*pow2(-7:0),2));
        BinaryValue(i,(8*(j-1))+1:8*j)= x;
        % BinaryValue(i,(8*(j-1))+1)= x(8);
        % BinaryValue(i,(8*(j-1))+2)= x(7);
        % BinaryValue(i,(8*(j-1))+3)= x(6);
        % BinaryValue(i,(8*(j-1))+4)= x(5);
        % BinaryValue(i,(8*(j-1))+5)= x(4);
        % BinaryValue(i,(8*(j-1))+6)= x(3);
        % BinaryValue(i,(8*(j-1))+7)= x(2);
        % BinaryValue(i,(8*(j-1))+8)= x(1);
        
    end
end 

end

