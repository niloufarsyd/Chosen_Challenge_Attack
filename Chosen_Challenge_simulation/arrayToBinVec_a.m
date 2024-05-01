
%**************************************************************************
% Convert a array of decimal into a binary vector/matrix. Each decimal value id
% represented by a 8-bit binary value.
%
% Author: D P Sahoo
% Last update: 6/6/2015
%**************************************************************************

function [B] = arrayToBinVec_a(D, S)
    
    n = size(D,1);
    m = size(D,2);
    
    n, m
    
    nBits = sum(S);
    B = zeros(n,nBits);
    
    for i=1:m
        s = (i-1)*S(i) + 1;
        e = i*S(i);
        
        d_i = D(:,i);
        %b_i = de2bi(d_i,8);
        %b_i = int2bit(d_i,8);
        b_i = zeros(n,S(i));
        for j = 1:n
            b_i(j,:) = Byte2Bit(d_i(j),S(i));
        end
        %b_i = fliplr(b_i);
        B(:,s:e) = b_i;
    end
    
end