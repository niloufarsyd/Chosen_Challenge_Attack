import numpy as np

class NF_probability:

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


    def PhiExpansionSampling(self, a_phi, i, n_samples, chal_size, flip_num):
        """Expands the specified row of the challenge matrix into multiple samples by flipping bits."""
        expanded_phi = np.ones((n_samples + 1, chal_size+1))
        #print(expanded_phi.shape)
        #print(a_phi.shape)
        expanded_phi[0, :] = a_phi[i, :]
        
        for j in range(n_samples):
            flip_positions = np.random.choice(chal_size, size=flip_num, replace=False)
            expanded_phi[j + 1, :] = self.flip_phi(a_phi[i, :], flip_positions)
        
        return expanded_phi

    def flip_phi(challenge, flip_positions):
        """Flip bits in the specified positions of the challenge."""
        flipped_challenge = challenge.copy()
        for pos in flip_positions:
            flipped_challenge[pos] = -1* flipped_challenge[pos]  # Flip the bit (0->1 or 1->0)
        return flipped_challenge


    def ComputeNoisyResponsesXOR(self, xor_w, n_xor, a_phi, n_rows, size, chal_size, sigma, sigma_noise, evaluations):
        """
        Compute noisy responses for XOR PUF.
        
        Parameters:
        xor_w (np.ndarray): Weight vectors for XOR PUFs.
        n_xor (int): Number of XOR PUFs.
        a_phi (np.ndarray): Array of feature vectors.
        n_rows (int): Number of rows in the feature vector array.
        size (int): Number of columns in the feature vector array.
        chal_size (int): Size of the challenge.
        sigma (float): Standard deviation of the original PUF weights.
        sigma_noise (float): Standard deviation of the noise.
        evaluations (int): Number of evaluations for computing reliability.
        
        Returns:
        Tuple[np.ndarray, np.ndarray]: A tuple containing the reliability array and array of responses.
        """
        a_response = np.ones((n_rows, evaluations))
        for e in range(evaluations):
            # Create a noise vector and noisy weight matrix
            sig_noise = sigma_noise * sigma
            xor_w_noise = self.XORPUfGeneration(n_xor, chal_size, 0, sig_noise)
            new_xor_w = xor_w + xor_w_noise
            
            # Evaluate responses
            for i in range(n_rows):
                sum = np.zeros(n_xor)
                for j in range(size):
                    sum += new_xor_w[:, j] * a_phi[i, j]
                prod = np.prod(sum)
                a_response[i, e] = 0 if prod > 0 else 1
        
        # Compute reliability
        reliability = np.zeros(n_rows)
        for m in range(n_rows):
            responses = a_response[m, :]
            reliability[m] = max(np.sum(responses == 1), np.sum(responses == 0))
            
        return reliability, a_response
    

    def XORPUfGeneration(nXOR, chalSize, mu, sigma):
        """
        Generate weight matrix for XOR PUF.
        
        Parameters:
        n_xor (int): Number of XOR PUFs.
        chal_size (int): Size of the challenge.
        mu (float): Mean of the normal distribution.
        sigma (float): Standard deviation of the normal distribution.
        
        Returns:
        np.ndarray: Weight matrix for XOR PUFs.
        """
        xor_w = np.random.normal(mu, Sigma, (nXOR, chalSize + 1))
        return xor_w


