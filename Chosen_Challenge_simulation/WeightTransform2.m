function weight = WeightTransform2(weight_real,nXOR,Phi0,Phi1,nSamples,ChalSize,sigma,sigmaNoise)

PhiSize = ChalSize + 1;
ExpandedSampleSize   = nSamples + 1;
u=ones(1,ChalSize+1);

temp1=zeros(1,ChalSize+1);
temp2=zeros(1,ChalSize+1);


PhiExpanded1=PhiExpansionSampling(Phi0, 1, nSamples, ChalSize, 1);
PhiExpanded2=PhiExpansionSampling(Phi1, 1, nSamples, ChalSize, 1);

[~,responseSample1] = ComputeNoisyResponsesXOR(weight_real,nXOR,PhiExpanded1,ExpandedSampleSize,PhiSize,ChalSize,sigma,sigmaNoise,1);
[~,responseSample2] = ComputeNoisyResponsesXOR(weight_real,nXOR,PhiExpanded2,ExpandedSampleSize,PhiSize,ChalSize,sigma,sigmaNoise,1);
%aa1t=ones(nSamples,ChalSize+1);
%at=ones(nSamples,ChalSize+1);
%measuring weight:
    %for k=1:nSamples  
        
        r1_1=1-2*abs(responseSample1(2,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(2,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(2,:)-Phi0;
        a2_1=PhiExpanded2(2,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
        r1_1=1-2*abs(responseSample1(3,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(3,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(3,:)-Phi0;
        a2_1=PhiExpanded2(3,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        
        r1_1=1-2*abs(responseSample1(4,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(4,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(4,:)-Phi0;
        a2_1=PhiExpanded2(4,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
                
        r1_1=1-2*abs(responseSample1(5,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(5,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(5,:)-Phi0;
        a2_1=PhiExpanded2(5,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(6,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(6,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(6,:)-Phi0;
        a2_1=PhiExpanded2(6,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(7,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(7,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(7,:)-Phi0;
        a2_1=PhiExpanded2(7,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(8,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(8,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(8,:)-Phi0;
        a2_1=PhiExpanded2(8,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(9,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(9,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(9,:)-Phi0;
        a2_1=PhiExpanded2(9,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(10,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(10,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(10,:)-Phi0;
        a2_1=PhiExpanded2(10,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(11,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(11,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(11,:)-Phi0;
        a2_1=PhiExpanded2(11,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(12,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(12,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(12,:)-Phi0;
        a2_1=PhiExpanded2(12,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
                
        r1_1=1-2*abs(responseSample1(13,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(13,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(13,:)-Phi0;
        a2_1=PhiExpanded2(13,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
                
        r1_1=1-2*abs(responseSample1(14,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(14,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(14,:)-Phi0;
        a2_1=PhiExpanded2(14,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
                
        r1_1=1-2*abs(responseSample1(15,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(15,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(15,:)-Phi0;
        a2_1=PhiExpanded2(15,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(16,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(16,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(16,:)-Phi0;
        a2_1=PhiExpanded2(16,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(17,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(17,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(17,:)-Phi0;
        a2_1=PhiExpanded2(17,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(18,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(18,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(18,:)-Phi0;
        a2_1=PhiExpanded2(18,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(19,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(19,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(19,:)-Phi0;
        a2_1=PhiExpanded2(19,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(20,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(20,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(20,:)-Phi0;
        a2_1=PhiExpanded2(20,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(21,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(21,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(21,:)-Phi0;
        a2_1=PhiExpanded2(21,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
        
        r1_1=1-2*abs(responseSample1(22,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(22,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(22,:)-Phi0;
        a2_1=PhiExpanded2(22,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
        r1_1=1-2*abs(responseSample1(23,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(23,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(23,:)-Phi0;
        a2_1=PhiExpanded2(23,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        
        r1_1=1-2*abs(responseSample1(24,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(24,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(24,:)-Phi0;
        a2_1=PhiExpanded2(24,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
                
        r1_1=1-2*abs(responseSample1(25,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(25,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(25,:)-Phi0;
        a2_1=PhiExpanded2(25,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(26,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(26,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(26,:)-Phi0;
        a2_1=PhiExpanded2(26,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(27,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(27,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(27,:)-Phi0;
        a2_1=PhiExpanded2(27,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(28,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(28,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(28,:)-Phi0;
        a2_1=PhiExpanded2(28,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(29,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(29,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(29,:)-Phi0;
        a2_1=PhiExpanded2(29,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(30,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(30,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(30,:)-Phi0;
        a2_1=PhiExpanded2(30,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(31,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(31,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(31,:)-Phi0;
        a2_1=PhiExpanded2(31,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(32,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(32,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(32,:)-Phi0;
        a2_1=PhiExpanded2(32,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
                
        r1_1=1-2*abs(responseSample1(33,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(33,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(33,:)-Phi0;
        a2_1=PhiExpanded2(33,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
                
        r1_1=1-2*abs(responseSample1(34,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(34,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(34,:)-Phi0;
        a2_1=PhiExpanded2(34,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
                
        r1_1=1-2*abs(responseSample1(35,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(35,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(35,:)-Phi0;
        a2_1=PhiExpanded2(35,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(36,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(36,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(36,:)-Phi0;
        a2_1=PhiExpanded2(36,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(37,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(37,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(37,:)-Phi0;
        a2_1=PhiExpanded2(37,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(38,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(38,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(38,:)-Phi0;
        a2_1=PhiExpanded2(38,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(39,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(39,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(39,:)-Phi0;
        a2_1=PhiExpanded2(39,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(40,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(40,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(40,:)-Phi0;
        a2_1=PhiExpanded2(40,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(41,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(41,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(41,:)-Phi0;
        a2_1=PhiExpanded2(41,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
        r1_1=1-2*abs(responseSample1(42,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(42,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(42,:)-Phi0;
        a2_1=PhiExpanded2(42,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
        r1_1=1-2*abs(responseSample1(43,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(43,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(43,:)-Phi0;
        a2_1=PhiExpanded2(43,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        
        r1_1=1-2*abs(responseSample1(44,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(44,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(44,:)-Phi0;
        a2_1=PhiExpanded2(44,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
                
        r1_1=1-2*abs(responseSample1(45,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(45,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(45,:)-Phi0;
        a2_1=PhiExpanded2(45,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(46,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(46,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(46,:)-Phi0;
        a2_1=PhiExpanded2(46,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(47,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(47,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(47,:)-Phi0;
        a2_1=PhiExpanded2(47,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(48,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(48,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(48,:)-Phi0;
        a2_1=PhiExpanded2(48,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(49,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(49,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(49,:)-Phi0;
        a2_1=PhiExpanded2(49,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(50,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(50,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(50,:)-Phi0;
        a2_1=PhiExpanded2(50,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
                %----------------        
        r1_1=1-2*abs(responseSample1(51,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(51,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(51,:)-Phi0;
        a2_1=PhiExpanded2(51,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------  
        
        r1_1=1-2*abs(responseSample1(52,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(52,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(52,:)-Phi0;
        a2_1=PhiExpanded2(52,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
        r1_1=1-2*abs(responseSample1(53,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(53,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(53,:)-Phi0;
        a2_1=PhiExpanded2(53,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        
        r1_1=1-2*abs(responseSample1(54,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(54,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(54,:)-Phi0;
        a2_1=PhiExpanded2(54,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------
                
        r1_1=1-2*abs(responseSample1(55,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(55,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(55,:)-Phi0;
        a2_1=PhiExpanded2(55,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(56,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(56,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(56,:)-Phi0;
        a2_1=PhiExpanded2(56,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(57,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(57,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(57,:)-Phi0;
        a2_1=PhiExpanded2(57,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(58,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(58,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(58,:)-Phi0;
        a2_1=PhiExpanded2(58,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(59,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(59,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(59,:)-Phi0;
        a2_1=PhiExpanded2(59,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------        
        r1_1=1-2*abs(responseSample1(60,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(60,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(60,:)-Phi0;
        a2_1=PhiExpanded2(60,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------  
           r1_1=1-2*abs(responseSample1(61,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(61,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(61,:)-Phi0;
        a2_1=PhiExpanded2(61,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------  
        r1_1=1-2*abs(responseSample1(62,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(62,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(62,:)-Phi0;
        a2_1=PhiExpanded2(62,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------  
        r1_1=1-2*abs(responseSample1(63,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(63,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(63,:)-Phi0;
        a2_1=PhiExpanded2(63,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------  
        r1_1=1-2*abs(responseSample1(64,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(64,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(64,:)-Phi0;
        a2_1=PhiExpanded2(64,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------  
        r1_1=1-2*abs(responseSample1(65,1)-responseSample1(1,1));
        r2_1=1-2*abs(responseSample2(65,1)-responseSample2(1,1));

        a1_1=PhiExpanded1(65,:)-Phi0;
        a2_1=PhiExpanded2(65,:)-Phi1;

        ra1_1=r1_1*a1_1;
        ra2_1=r2_1*a2_1; 

        temp1=temp1+ra1_1;
        temp2=temp2+ra2_1;
        %----------------  
   % end
weight1=temp1;
weight2=temp2;

sign_w1=dot(weight1,u);
sign_w2=dot(weight2,u);
if sign_w1<0
    weight1=-weight1;
end
if sign_w2<0
    weight2=-weight2;
end

weight=(weight1+weight2)/2;
end

