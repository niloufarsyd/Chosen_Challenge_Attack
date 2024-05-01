%
clear all;
clc;
%**************************************************************************
% Create a Chosen Challenge Attack on a real n-XOR APUF, using real CRPs
% loaded from FPGA
%**************************************************************************
ChalSize = 64;    % Bit length of challenge
nXOR = 3;         % number of APUFs in n-XOR APUF
nCMAESRun=3;      % number of CMA-ES running
nSamples = 16;    % number of chosen challenges sampled around centroid challenge
nTest=50000;
%**************************************************************************
% Loading Challenges and responses
%**************************************************************************
% Loading Challenge File that had been applied to real XOR APUF on FPGA
% the data transfered to FPGA's interface are decimal
% Convert decimal challenge set to binary Challenge set.

%load('chosen_challenges1.mat');%%Chenglu's extracted challenge
load('chosen_challenges50K.mat');%nTrain=50K
%BinaryChalSet=Dec2Binary(Chal);
%or:
BinaryChalSet=Dec2Binary(DecChalSet2);


%Loading implemented PUF response file that had been stored from FPGA:

%load("virtual_5XOR_responses.mat");%Chenglu's extracted responses
load('respAvg_50Ktrain_3XOR.mat')
%**************************************************************************
% Extract the centroid CRPs of data set:
%**************************************************************************
nTrain = size(BinaryChalSet,1)/(nSamples+1);

CentroidChallengeSet=ones(nTrain,ChalSize);
CentroidResponseSet=ones(nTrain,nXOR+1);
for i=1:nTrain
    CentroidChallengeSet(i,:)=BinaryChalSet(((i-1)*(nSamples+1))+1,:);
    CentroidResponseSet(i,:)=Avg(((i-1)*(nSamples+1))+1,:);
end
%**************************************************************************
%Test data set:
%**************************************************************************
TestSet= CentroidChallengeSet((nTrain-nTest+1):nTrain,:);
PhiTest = Transform(TestSet, nTest, ChalSize);
%Compute the responses for the Test sets Phi_TeS
PhiSize = ChalSize + 1;
%---------------------
%Collect a test set of responses in "AResponseALLAPUFs" for checking the
%APUFs with generated wModel by CMAES algorithm. 
AResponseALLAPUFs1 = zeros(nTest,nXOR);
AResponseALLAPUFs  = zeros(nXOR,nTest);
for i=1:nXOR
    AResponseALLAPUFs1(:,i)=CentroidResponseSet((nTrain-nTest+1):nTrain,i);
end
AResponseALLAPUFs=AResponseALLAPUFs1';
%**************************************************************************
% Flipping Probability measurement:
%**************************************************************************
ExpandedSampleSize = nSamples + 1;
%the responses of XOR are stored on "ResponseTrainSample"
%Av/Avg is the name of the matrix that contain the values of loaded response file. 
ResponseTrainSample    = Avg(1:nTrain*(nSamples+1),nXOR+1);

FlippingProbability    = zeros(nTrain,1);
nonFlippingProbability = zeros(nTrain,1);

    for i = 1:nTrain                    
            for j = 2:ExpandedSampleSize
                temp = mod(ResponseTrainSample(((i-1)*(nSamples+1))+1,1)+ ResponseTrainSample(((i-1)*(nSamples+1))+j,1),2);
                FlippingProbability(i) = FlippingProbability(i) + temp;
            end
            nonFlippingProbability(i) = (nSamples-FlippingProbability(i))/(nSamples);
                       
    end
%**************************************************************************   
% Run CMA-ES algorithm multiple times and predict the model of APUFs:
%**************************************************************************
matchingRateMultipleTimes = zeros(nCMAESRun,nXOR);
for k=1:nCMAESRun
    disp("cmaes")
    PhiTrSet = Transform(CentroidChallengeSet, nTrain, ChalSize);
    [lam,wModel] = CMAES(PhiTrSet,nonFlippingProbability,PhiSize);
    
    for i=1:nXOR
        matchingRateMultipleTimes(k,i)= ModelAccuracy(wModel,PhiTest,AResponseALLAPUFs(i,:),PhiSize,nTest);
    end
    
end
%-----------------The final result of the attack:--------------------------
% The "matchingRateMultipleTimes" matrix includes the converge values of the
% wModel to real APUFs during multiple CMAES runs.  

% when the MatchingRate values are close to '0' or '1', the converge to the
% corresponding APUF has been happened with the prediction accuracy of
% "(1-matching rate)*100"percent or "(matching)*100"perscent, respectively.

%**************************************************************************