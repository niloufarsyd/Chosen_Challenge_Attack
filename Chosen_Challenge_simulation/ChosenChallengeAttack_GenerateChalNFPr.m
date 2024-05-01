
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
nXOR = 6;         % number of APUFs in n-XOR APUF
nTrain = 40000;   % number of CRPS in training set of ML algorithm
nTest = 2000;      % number of CRPS in test set of ML algorithm
Evaluations = 1;  % 1 means no repeated measurement
Evaluations_R =10;% multiple evaluations for measuring Reliability of PUF

SigmaNoise=0.5;% noise of simulated responses follows a normal distribution with standard deviation of SigmaNoise
                  % SigmaNoise = 0 means a reliable PUF
nCMAESRun=5;      % number of CMA-ES running
nSamples = 16;    % number of chosen challenges sampled around centroid challenge
FlipNum=1;        % number of flips we have in Phi vector

%weight vector w of XORPUFWeight=(w1,...,wnXOR)=[w[1,1],...,w[1,ChalSize+1];...;w[nXOR,1],...,w[nXOR,ChalSize]]
%by using the XORPUFgeneration.

XORPUFWeight= XORPUFGeneration(nXOR,ChalSize,Mu,Sigma);

%**************************************************************************

%**************************************************************************
%%--- initialize variables used in CMAES runs:----
matchingRateMultipleTimes = zeros(nCMAESRun,nXOR);
PhiSize = ChalSize + 1;
PhiTrainSet          = ones(nTrain,ChalSize+1);
ReliabilitySample    = zeros(nTrain,1);
ExpandedSampleSize   = nSamples + 1;
PhiExpanded          = ones(nSamples+1,ChalSize+1);
PhiExpandedSet       = ones(nTrain*(nSamples+1),ChalSize+1);
ExpandedChallenges   = zeros(nSamples+1,ChalSize);
ExpandedChallengesSet= zeros(nTrain*(nSamples+1),ChalSize);
%**************************************************************************
% Create the (PHI, nonFlippingProbability) set ,
% run CMA-ES,
% and Predict the accuracy of the model
%**************************************************************************
%We run CMAES many times ("nCMAESRun" times) and check whether all APUF can be modeled or not
    TrainSet= randi([0 1], nTrain, ChalSize);%generate training set of challenges
    FlippingProbability    = zeros(nTrain,1);
    nonFlippingProbability = zeros(nTrain,1);
    PhiTrainSet = Transform(TrainSet, nTrain, ChalSize);%convert challenges on TrainingSet to corresponding Phi
    ResponseTrain=zeros(nTrain,1);
    ResponseTrain = ComputeResponseXOR(XORPUFWeight,nXOR,PhiTrainSet,nTrain,PhiSize);
    for i = 1:nTrain
            %for each challenge of training set:
            %The PHI is expanded to (nSamples+1)*PHI
            %The responses of all expanded PHIs are computed as "ResponseTrainSample"
            PhiExpanded=PhiExpansionSampling(PhiTrainSet, i, nSamples, ChalSize, FlipNum);
            [ReliabilitySample,ResponseTrainSample] = ComputeNoisyResponsesXOR(XORPUFWeight,nXOR,PhiExpanded,ExpandedSampleSize,PhiSize,ChalSize,Sigma,SigmaNoise,Evaluations);
            PhiExpandedSet((i-1)*(nSamples+1)+1:i*(nSamples+1),:)=PhiExpanded;
            
            %save all expanded challenges in a matrix to be used for real
            %FPGA attack later:
            ExpandedChallenges = TransformPhiToCh_New(PhiExpanded,nSamples+1, ChalSize);
            ExpandedChallengesSet((i-1)*(nSamples+1)+1:i*(nSamples+1),:)=ExpandedChallenges;
            
            for j = 2:ExpandedSampleSize
                temp = mod(ResponseTrainSample(1,1)+ ResponseTrainSample(j,1),2);
                FlippingProbability(i) = FlippingProbability(i) + temp;
            end
            nonFlippingProbability(i) = (nSamples-FlippingProbability(i))/(nSamples);
                         
     end
%     tt=k
%     disp("cmaes")
%     [lam,wModel] = CMAES(PhiTrainSet,nonFlippingProbability,PhiSize);
%     tt= k
%     for i=1:nXOR
%         matchingRateMultipleTimes(k,i)= ModelAccuracy(wModel,PhiTest,AResponseALLAPUFs(i,:),PhiSize,nTest);
%     end
    
%%end
%-----------------The final result of the attack:--------------------------
% The "matchingRateMultipleTimes" matrix includes the converge values of the
% model to APUFs during multiple CMAES runs.  

% when the MatchingRate values are close to '0' or '1', the converge to the
% corresponding APUF has been happened with the prediction accuracy of
% "(1-matching rate)*100"percent or "(matching)*100"perscent, respectively.

% %**************************************************************************
% %Convert binary Challenge set to decimal set and saving them as a file.
% %**************************************************************************
% %This challenge file will be used for real attack on FPGA.
n=size(ExpandedChallengesSet,1);
DecChalSet  = zeros(n,8);
DecChalSet2 = DecChalGen(ExpandedChallengesSet,ChalSize,8);

% chalFile='chosen_challenges2.mat';
% save(chalFile,'DecChalSet2');

ChalFile='Challenge_6XOR_40k.mat';
save(ChalFile,'TrainSet');
RespFile='Response_6XOR_40k.mat';
save(RespFile,'ResponseTrain');
NFPrFile='NonFlippingPr_6XOR_40k.mat';
save(NFPrFile,'nonFlippingProbability');
%%----------------------
% Create the Test Challenge-Response Set
%**************************************************************************
%Compute the responses for the Test sets Phi_TeS
%Test data we need only one time generation
TestSet = randi([0 1], nTest, ChalSize);
PhiTest = Transform(TestSet, nTest, ChalSize);

ResponseTest = ComputeResponseXOR(XORPUFWeight,nXOR,PhiTest,nTest,PhiSize);
ReliabilitySampleT    = zeros(nTest,1);
ExpandedSampleSizeT   = nSamples + 1;
PhiExpandedT          = ones(nSamples+1,ChalSize+1);
PhiExpandedSetT       = ones(nTest*(nSamples+1),ChalSize+1);
ExpandedChallengesT   = zeros(nSamples+1,ChalSize);
ExpandedChallengesSetT= zeros(nTest*(nSamples+1),ChalSize);
%For checking the APUF with generated model
%Compute the arrays of responses for a given weight vector XORPUFWeight and
%arrays of challenges
AResponseALLAPUFs = zeros(nXOR,nTest);
for i=1:nXOR
    AResponseALLAPUFs(i,:)=ComputeResponseXOR(XORPUFWeight(i,:),1,PhiTest,nTest,PhiSize);
end
    
    FlippingProbabilityT    = zeros(nTest,1);
    nonFlippingProbabilityT = zeros(nTest,1);
    PhiTestSet = Transform(TestSet, nTest, ChalSize);%convert challenges on TrainingSet to corresponding Phi
% for k=1:nCMAESRun
    
    for i = 1:nTest
            %for each challenge of training set:
            %The PHI is expanded to (nSamples+1)*PHI
            %The responses of all expanded PHIs are computed as "ResponseTrainSample"
            PhiExpandedT=PhiExpansionSampling(PhiTestSet, i, nSamples, ChalSize, FlipNum);
            [ReliabilitySampleT,ResponseTrainSampleT] = ComputeNoisyResponsesXOR(XORPUFWeight,nXOR,PhiExpandedT,ExpandedSampleSizeT,PhiSize,ChalSize,Sigma,SigmaNoise,Evaluations);
            PhiExpandedSet((i-1)*(nSamples+1)+1:i*(nSamples+1),:)=PhiExpandedT;
            
            %save all expanded challenges in a matrix to be used for real
            %FPGA attack later:
            ExpandedChallengesT = TransformPhiToCh_New(PhiExpandedT,nSamples+1, ChalSize);
            ExpandedChallengesSetT((i-1)*(nSamples+1)+1:i*(nSamples+1),:)=ExpandedChallengesT;
            
            for j = 2:ExpandedSampleSizeT
                temp = mod(ResponseTrainSampleT(1,1)+ ResponseTrainSampleT(j,1),2);
                FlippingProbabilityT(i) = FlippingProbabilityT(i) + temp;
            end
            nonFlippingProbabilityT(i) = (nSamples-FlippingProbabilityT(i))/(nSamples);
                         
     end
     
TestFile='ChalTest_6XOR_2k.mat';
save(TestFile,'TestSet');
TestResp='RespTest_6XOR_2k.mat';
save(TestResp,'ResponseTest');
TestNFPr='NFPrTest_6XOR_2k.mat';
save(TestNFPr,'nonFlippingProbabilityT');
% %**************************************************************************
% % measuring the Reliability of simulated XORPUF
% % It's not related to the attack, just for our information
% [Reliability,ResponseTrainSample2] = ComputeNoisyResponsesXOR(XORPUFWeight,nXOR,PhiTrainSet,nTrain,PhiSize,ChalSize,Sigma,SigmaNoise,Evaluations_R);
% temp=0;
% for i=1:nTrain
%     if Reliability(i,1)==10
%         temp=temp+1;
%     elseif Reliability(i,1)==0
%         temp=temp+1;
%     end
% end
% Reliability_PUF=temp/nTrain;
%**************************************************************************