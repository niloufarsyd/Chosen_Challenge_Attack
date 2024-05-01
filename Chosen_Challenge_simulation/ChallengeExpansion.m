function [ExpandedCh] = ChallengeExpansion(AChallenge, nRows, ChalSize )
% Expand each challenge to (ChalSize) challenges, such that each of the
% expanded challenge has one phi flip (two consecutive bit flips in each
% challenge) from the AChallenge

ExpandedCh = zeros(nRows*(ChalSize), ChalSize);

for i=0:nRows-1
    ExpandedCh(i*ChalSize+1,:) = AChallenge(i+1,:);
    for j=1:ChalSize-1
        FlipPosition = [j, j+1];
        ExpandedCh(i*ChalSize+j+1,:) = FlipChallenges( AChallenge(i+1,:), 2, FlipPosition);
    end
end
end


