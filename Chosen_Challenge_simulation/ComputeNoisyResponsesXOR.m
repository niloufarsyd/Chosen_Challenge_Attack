function [Reliability,AResponse] = ComputeNoisyResponsesXOR(XORw,nXOR,APhi,nRows,Size,ChalSize,sigma,sigmaNoise,Evaluations)


%We are given the APUF which has: XORw weight vectors, nXOR APUFs, APhi
%vectors computed from array of challenges and the array has nRows, Size
%columns. The APUF is created by a given sigma, mu and has ChalSize-bit
%challenge

%We need to create a noisy CRPs with sigmaNoise and for each Challenge, we
%evaluate it Evaluation times. It means that we have an array of responses
%AResponse having nRows and Evaluations column. Typically, AResponse[i,j]
%is the response of challange[i] of Evaluation[j]. 



% The function computes the array of responses for a given array of feature
% vectors APhi and weight vector w
% The response = 0 if  w*APhi >0, otherwise = 1;
%   Detailed explanation goes here
  
%Creating an array of noisy Responses AResponse with nRows rows and
%Evaluations columns. 

  AResponse = ones(nRows,Evaluations);

%
  for e=1:Evaluations
      
      %Create a noise vector 
      sigNoise = sigmaNoise*sigma;
      XORwNoise= XORPUFGeneration(nXOR,ChalSize,0,sigNoise);
      %Create a XOR affected by the noise newXORw
      newXORw = ones(nXOR,Size);
      for j=1:Size
          for k=1:nXOR
              newXORw(k,j) = XORw(k,j) + XORwNoise(k,j);
          end
      end
      %Evaluate the responses
      
      for i=1:nRows
           %Outputs of each APUF instances 
            Sum = zeros(1,nXOR);
      
           %Compute the outputs of nXOR APUFs
            for j=1:Size
               for k = 1:nXOR
                  Sum(k) = Sum(k) + newXORw(k,j)*APhi(i,j);  
               end
            end     
      
           %Compute the output of XORPUF 
            Prod = 1;
      
            for k=1:nXOR
               Prod = Prod*Sum(k);
            end

            if(Prod>0)
               AResponse(i,e)=0;
            else 
               AResponse(i,e)=1;
            end
       end
      
  end
  
  Reliability=zeros(nRows,1);
  for m=1:nRows
      temp0=0;
      temp1=0;
      for n=1:Evaluations
          if (AResponse(m,n)==1)
              temp1=temp1+1;
          elseif (AResponse(m,n)==0)
              temp0=temp0+1;
          end   
      end
      if (temp1>temp0)
          Reliability(m,1)=temp1;
      elseif (temp1<temp0)
          Reliability(m,1)=temp0;
      end             
  end
   


end

