function [Flipped_Ch] = FlipChallenges(Ch, nFlips, FlipPosition)
%generate flipped challenges as required by the number of flips, and
%position of flips
  
Flipped_Ch = Ch;

for i = 1:nFlips
    Flipped_Ch(FlipPosition(i)) = mod(Flipped_Ch(FlipPosition(i))+1,2);
end

end