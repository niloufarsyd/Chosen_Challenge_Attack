function weight = WeightTransform(weight_real,nXOR,Phi0,Phi1,nSamples,ChalSize,sigma,sigmaNoise)

PhiSize = ChalSize + 1;
ExpandedSampleSize   = nSamples + 1;
u=ones(1,ChalSize+1);

temp1=zeros(1,ChalSize+1);
temp2=zeros(1,ChalSize+1);


PhiExpanded1=PhiExpansionSampling(Phi0, 1, nSamples, ChalSize, 1);
PhiExpanded2=PhiExpansionSampling(Phi1, 1, nSamples, ChalSize, 1);

[~,responseSample1] = ComputeNoisyResponsesXOR(weight_real,nXOR,PhiExpanded1,ExpandedSampleSize,PhiSize,ChalSize,sigma,sigmaNoise,1);
[~,responseSample2] = ComputeNoisyResponsesXOR(weight_real,nXOR,PhiExpanded2,ExpandedSampleSize,PhiSize,ChalSize,sigma,sigmaNoise,1);

%measuring weight:
    for k=1:nSamples  
        
        r1=1-2*abs(responseSample1(k+1,1)-responseSample1(1,1));
        r2=1-2*abs(responseSample2(k+1,1)-responseSample2(1,1));

        a1=PhiExpanded1(k+1,:)-Phi0;
        a2=PhiExpanded2(k+1,:)-Phi1;

        ra1=r1*a1;
        ra2=r2*a2;

        temp1=temp1+ra1;
        temp2=temp2+ra2;
    end
weight1=temp1;
weight2=temp2;

sign_w1=dot(weight1,u);
sign_w2=dot(weight2,u);
% if sign_w1<0
%     weight1=-weight1;
% end
% if sign_w2<0
%     weight2=-weight2;
% end

%weight=(weight1+weight2)/2;
weight=weight1;
end

