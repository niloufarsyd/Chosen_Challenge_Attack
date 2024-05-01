
% 
clear all;
clc;
%**************************************************************************
% Create a Chosen Challenge Attack on a simulated n-XOR APUF. 
% The PUF weight model is generated using normal distribution with Mu=0 and
% Sigma=1
% challenge set is generated randomly 

%**************************************************************************
% Create a Simulated model for Arbiter PUF
%** ***********************************************************************
ChalSize = 64;    % Bit length of challenge
Mu = 0;           % Mean of variation in delay parameters
Sigma = 1;        % Standard deviation of variation in delay parameters
nXOR = 5;         % number of APUFs in n-XOR APUF
nTrain = 300000;   % number of CRPS in training set of ML algorithm
nTest = 1000;      % number of CRPS in test set of ML algorithm
Evaluations = 1;  % 1 means no repeated measurement
Evaluations_R =10;% multiple evaluations for measuring Reliability of PUF

SigmaNoise=0;% noise of simulated responses follows a normal distribution with standard deviation of SigmaNoise
                  % SigmaNoise = 0 means a reliable PUF
nCMAESRun=1;      % number of CMA-ES running
nSamples = 16;    % number of chosen challenges sampled around centroid challenge
FlipNum=1;        % number of flips we have in Phi vector

%weight vector w of XORPUFWeight=(w1,...,wnXOR)=[w[1,1],...,w[1,ChalSize+1];...;w[nXOR,1],...,w[nXOR,ChalSize]]
%by using the XORPUFgeneration.

XORPUFWeight= XORPUFGeneration(nXOR,ChalSize,Mu,Sigma);

%**************************************************************************
% Create the Test Challenge-Response Set
%**************************************************************************
%Compute the responses for the Test sets Phi_TeS
%Test data we need only one time generation
TestSet = randi([0 1], nTest, ChalSize);
PhiTest = Transform(TestSet, nTest, ChalSize);
PhiSize = ChalSize + 1;
ResponseTest = ComputeResponseXOR(XORPUFWeight,nXOR,PhiTest,nTest,PhiSize);

%For checking the APUF with generated model
%Compute the arrays of responses for a given weight vector XORPUFWeight and
%arrays of challenges
AResponseALLAPUFs = zeros(nXOR,nTest);
for i=1:nXOR
    AResponseALLAPUFs(i,:)=ComputeResponseXOR(XORPUFWeight(i,:),1,PhiTest,nTest,PhiSize);
end
%**************************************************************************
%%--- initialize variables used in CMAES runs:----
matchingRateMultipleTimes = zeros(nCMAESRun,nXOR);
PhiTrainSet          = ones(nTrain,ChalSize+1);
ReliabilitySample    = zeros(nTrain,1);
ExpandedSampleSize   = nSamples + 1;
PhiExpanded          = ones(nSamples+1,ChalSize+1, nTrain);
PhiExpandedSet       = ones(nTrain*(nSamples+1),ChalSize+1);
ExpandedChallenges   = zeros(nSamples+1,ChalSize);
ExpandedChallengesSet= zeros(nTrain*(nSamples+1),ChalSize);
ResponseTrainSample_APUFS=zeros(nSamples+1,nXOR);
temp2=zeros(1,nXOR);
%**************************************************************************
% Create the (PHI, nonFlippingProbability) set ,
% run CMA-ES,
% and Predict the accuracy of the model
%**************************************************************************
%We run CMAES many times ("nCMAESRun" times) and check whether all APUF can be modeled or not
    TrainSet= randi([0 1], nTrain, ChalSize);%generate training set of challenges
    FlippingProbability    = zeros(nTrain,1);
    nonFlippingProbability = zeros(nTrain,1);
    FP    = zeros(nTrain,nXOR);
    NFP   = zeros(nTrain,nXOR);
    NFP_Corr = zeros(1,nXOR);
    Delta_Corr = zeros(1,nXOR);
    Delta_Corr_abs = zeros(1,nXOR);
    Delta=zeros(nTrain,nXOR);
    PhiTrainSet = Transform(TrainSet, nTrain, ChalSize);%convert challenges on TrainingSet to corresponding Phi
    for p = 1:nTrain
    PhiExpanded(:,:,p)=PhiExpansionSampling(PhiTrainSet, p, nSamples, ChalSize, FlipNum);
    end
for k=1:nCMAESRun
         FlippingProbability    = zeros(nTrain,1);
         FP    = zeros(nTrain,nXOR);
    for i = 1:nTrain
            %for each challenge of training set:
            %The PHI is expanded to (nSamples+1)*PHI
            %The responses of all expanded PHIs are computed as "ResponseTrainSample"
            %PhiExpanded=PhiExpansionSampling(PhiTrainSet, i, nSamples, ChalSize, FlipNum);
            [ReliabilitySample,ResponseTrainSample] = ComputeNoisyResponsesXOR(XORPUFWeight,nXOR,PhiExpanded(:,:,i),ExpandedSampleSize,PhiSize,ChalSize,Sigma,SigmaNoise,Evaluations);
            PhiExpandedSet((i-1)*(nSamples+1)+1:i*(nSamples+1),:)=PhiExpanded(:,:,i);

            for j = 2:ExpandedSampleSize
                temp = mod(ResponseTrainSample(1,1)+ ResponseTrainSample(j,1),2);              
                FlippingProbability(i) = FlippingProbability(i) + temp;
            end
            nonFlippingProbability(i) = (nSamples-FlippingProbability(i))/(nSamples);
            
            for g2=1:nXOR
            [~,ResponseTrainSample_APUFS(:,g2)] = ComputeNoisyResponsesXOR(XORPUFWeight(g2,:),1,PhiExpanded(:,:,i),ExpandedSampleSize,PhiSize,ChalSize,Sigma,SigmaNoise,Evaluations);              
             Delta(i,g2)=dot(PhiExpanded(1,:,i),XORPUFWeight(g2,:).');
                for j2 = 2:ExpandedSampleSize
                    temp2(1,g2) = mod(ResponseTrainSample_APUFS(1,g2)+ ResponseTrainSample_APUFS(j2,g2),2);  
                    FP(i,g2)=FP(i,g2)+temp2(1,g2);
                end
                NFP(i,g2)=(nSamples-FP(i,g2))/(nSamples);
            end                                                                   
    end    
    disp("cmaes")
    [lam,wModel] = CMAES(PhiTrainSet,nonFlippingProbability,PhiSize);
    tt= k
    for h=1:nXOR
        matchingRateMultipleTimes(k,h)= ModelAccuracy(wModel,PhiTest,AResponseALLAPUFs(h,:),PhiSize,nTest);
    end  
end
for g3=1:nXOR
         r = corrcoef(nonFlippingProbability,NFP(:,g3),'rows','complete');
         NFP_Corr(1,g3)=r(1,2);
         
         rr = corrcoef(nonFlippingProbability,Delta(:,g3),'rows','complete');
         rrr = corrcoef(nonFlippingProbability,abs(Delta(:,g3)),'rows','complete');
         Delta_Corr(1,g3)=rr(1,2);
         Delta_Corr_abs(1,g3)=rrr(1,2);

end

%**************************************************************************