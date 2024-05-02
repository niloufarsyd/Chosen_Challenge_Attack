# Chosen_Challenge_Attack

The ‘Chosen_Challenge_Simulation’ folder has been written based on the [DA_PUF_Library](https://github.com/scluconn/DA_PUF_Library) and contains the Matlab code for simulating the XOR APUF under the Chosen Challenge attack. 
The main script file in this folder is the"ChosenChallengeAttack_Simulation". 
The attacking method in this section is a CMAES attack based on the Challenge-nonFlippingProbability pairs.

The second part of this project has been simulated with "Combined_LR_Simulation" which is based on the [puf-simulation](https://github.com/jtobi/puf-simulation/) repository with some modifications. 
Attacking XOR-APUF and iPUF through a combined gradient-based attack is now possible using non-FlippingProbability information instead of reliability information, and hence, a combined attack on a reliable PUF(when the noise is zero) is fully possible now.

The results of this project and a full description of this methodology have been presented at https://arxiv.org/abs/2312.01256.

If you have any questions regarding the codes, please direct your questions to niloufar.sayadi@cwi.nl or chenglu.jin@cwi.nl
