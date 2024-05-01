#from puf_simulation_framework.attack_framework import NF_probability #*
from abc import ABC, abstractmethod
import numpy as np


#NonFlippingProbability_attack_manager

class AbstractPUF(ABC):
    """
    abstract PUF class
    """
    puf_name = 'abstract_puf'

    @abstractmethod
    def compute_response(self, puf_input, enable_noise=False, **kwargs):
        pass

    def compute_reliability_response(self, puf_input, num_repetitions_to_evaluate, **kwargs):
        reliability_type = kwargs.get('reliability_type', 'simple_mean')
        raw_responses = np.zeros((num_repetitions_to_evaluate, puf_input.shape[0]))

        for current_repetition in range(num_repetitions_to_evaluate):
            raw_responses[current_repetition, :] = self.compute_response(puf_input, enable_noise=True, **kwargs)

        mean_output = raw_responses.mean(axis=0)
        if reliability_type == 'simple_mean':
            output = mean_output
        elif reliability_type == 'minus_abs':
            output = (abs(0.5-mean_output) + 0.5)
        else:
            raise ValueError()
        return output


    def compute_NonFlippingProbability_response(self, puf_input, nSamples, FlipNum, **kwargs):    
        nTrain=puf_input.shape[0]
        ChalSize=puf_input.shape[1]
        TrainSet=puf_input #challenges
        PhiTrainSet=np.zeros((nTrain,ChalSize+1))
        ExpandedResponses=np.zeros((1,nSamples+1))       
        ExpandedChallenges   = np.zeros((nSamples+1,ChalSize))
        ExpandedSampleSize   = nSamples + 1
        FlippingProbability  = np.zeros(nTrain)   
        nonFlippingProbability=np.zeros(nTrain)
        new_column = np.ones((nTrain, 1))
        PhiTrainSet = np.hstack((puf_input, new_column))
        for i in range(1, nTrain):
            PhiExpanded=AbstractPUF.PhiExpansionSampling(a_phi=PhiTrainSet, i=i, n_samples=nSamples, chal_size=ChalSize, flip_num=FlipNum)
            ExpandedChallenges=AbstractPUF.transform_phi_to_chal(PhiExpanded, nSamples+1, ChalSize)
            ExpandedResponses = self.compute_response(puf_input=PhiExpanded[:,:-1], enable_noise=True, **kwargs)
            for j in range(1, nSamples):  # Python indexing starts at 0, so we start from 1 to skip the first sample
                temp = (ExpandedResponses[0] + ExpandedResponses[j]) % 2
                FlippingProbability[i] += temp

            nonFlippingProbability[i] = (nSamples - FlippingProbability[i]) / nSamples

        output=nonFlippingProbability
        return output

##=============================================  
    @staticmethod
    def Transform(a_challenge, n_rows, chal_size):
        """Transform an array of challenges into an array of feature vectors."""
        #import numpy as np
        
        # Initialize the array of feature vectors with ones
        a_phi = np.ones((n_rows, chal_size + 1))
        
        # Iterate over each challenge
        for i in range(n_rows):
            for j in range(chal_size):
                # Start with the feature being 1
                a_phi[i, j] = 1
                # Perform the transformation for each bit in the challenge from j to chal_size
                for k in range(j, chal_size):
                    a_phi[i, j] *= (1 - 2 * a_challenge[i, k])
        
        return a_phi
    
    @staticmethod
    def transform_phi_to_chal(a_phi, n_rows, chal_size):
        """
        Transforms the APhi matrix to the challenge matrix Ch.
        
        Parameters:
        a_phi (np.ndarray): Input matrix APhi with dimensions (nRows, ChalSize+1).
        n_rows (int): Number of rows in APhi.
        chal_size (int): Challenge size, number of columns in the output matrix Ch.
        
        Returns:
        np.ndarray: Transformed matrix Ch with dimensions (nRows, ChalSize).
        """
        ch = np.zeros((n_rows, chal_size), dtype=int)
        for i in range(n_rows):
            phi = a_phi[i, :]
            for j in range(chal_size):
                if phi[chal_size - j] == phi[chal_size - j - 1]:
                    ch[i, chal_size - j - 1] = 0
                else:
                    ch[i, chal_size - j - 1] = 1
        return ch

    @staticmethod
    def PhiExpansionSampling(a_phi, i, n_samples, chal_size, flip_num):
        """Expands the specified row of the challenge matrix into multiple samples by flipping bits."""
        expanded_phi = np.ones((n_samples + 1, chal_size+1))
        expanded_phi[0, :] = a_phi[i, :]
        
        for j in range(n_samples):
            flip_positions = np.random.choice(chal_size, size=flip_num, replace=False)
            expanded_phi[j + 1, :] = AbstractPUF.flip_phi(a_phi[i, :], flip_positions)
        return expanded_phi

    @staticmethod
    def flip_phi(challenge, flip_positions):
        """Flip bits in the specified positions of the challenge."""
        flipped_challenge = challenge.copy()
        for pos in flip_positions:
            flipped_challenge[pos] = -1* flipped_challenge[pos]  # Flip the bit (0->1 or 1->0)
        return flipped_challenge
##=============================================

    def get_puf_name(self):
        return self.puf_name

    @abstractmethod
    def get_puf_type_name(self):
        """
        Return a string that describes the puf architecture, such as classic_xor_puf
        :return:
        """
        pass

    @abstractmethod
    def get_puf_parameter_identifier(self):
        """
        Return a string that identifies a PUF based on its parameters, such as XOR PUF-> 3_Xors__64_Stages
        :return:
        """
        pass

    # abstractmethod
    #
    # def create_random_challenges(self, num_challenges, create_feature_vectors=False,
    #                              random_state: np.random.RandomState = None):
    #     pass
