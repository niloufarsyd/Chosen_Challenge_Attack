function [Flipped_Phi] = FlipPhi(Phi, nFlips, FlipPosition)
%FLIPPHI Summary of this function goes here
%   Detailed explanation goes here
Flipped_Phi = Phi;

for i = 1:nFlips
    Flipped_Phi(FlipPosition(i)) = Flipped_Phi(FlipPosition(i))*-1;
end
end

