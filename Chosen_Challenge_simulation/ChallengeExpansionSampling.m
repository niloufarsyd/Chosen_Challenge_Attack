function [ExpandedCh] = ChallengeExpansionSampling(AChallenge, nRows, ChalSize, FlipRange, nSamples, d )
% Expand each challenge to (nSamples) challenges, such that each of the
% expanded challenge has one phi flip (two consecutive bit flips in each
% challenge) from the AChallenge, the sampled range is defined by FlipRange
% The size of FlipRange is nSamples 
% d is the distance between flipped Challenge bits, d=1 means two
% consecutive bit flips in each challenges that causes one bit flip in Phi,
% and d=2 means two challenge bits with one bit among are flipped that
% causes two bit flips in corresonding Phi
ExpandedCh = zeros(nRows*(nSamples+1), ChalSize);

for i=0:nRows-1
    ExpandedCh(i*(nSamples+1)+1,:) = AChallenge(i+1,:);
    for j=1:nSamples
        FlipPosition = [FlipRange(j), FlipRange(j)+d];
        ExpandedCh(i*(nSamples+1)+j+1,:) = FlipChallenges( AChallenge(i+1,:), 2, FlipPosition);
    end
end
end


