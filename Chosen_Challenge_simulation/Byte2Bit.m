function binaryVector = Byte2Bit(n, numBits)
    binaryVector = zeros(1, numBits);
    
    for i = numBits:-1:1
        binaryVector(i) = mod(n, 2);
        n = floor(n / 2);
        
        if n == 0
            break;
        end
    end
end
