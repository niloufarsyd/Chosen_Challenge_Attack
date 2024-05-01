function [ExpandedPhi] = PhiExpansionSampling(APhi,i, nSamples,ChalSize, FlipNum)
ExpandedPhi = ones((nSamples+1), ChalSize+1);

%for i=0:nRows-1
    %ExpandedPhi(i*(nSamples+1)+1,:) = APhi(i+1,:);
    ExpandedPhi(1,:) = APhi(i,:);
    p = randperm(ChalSize);
    FlipPositionSets=nchoosek(p,FlipNum);
    %size(FlipPositionSets,1)
    comb_select = randperm(size(FlipPositionSets,1));
    for j=1:nSamples
        
        FlipPosition = FlipPositionSets(comb_select(j),:);
        ExpandedPhi(j+1,:) = FlipPhi( APhi(i,:), FlipNum, FlipPosition);
    end
%end
end

