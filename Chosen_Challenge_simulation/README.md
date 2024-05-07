
-The main script regarding the Chosen Challenge Attack simulation is the “ChosenChallengeAttack_Simulation.m” file.

-For evaluating the FPGA implementation results, the main script would be the “ChosenChallengeAttack_implementation.m” file.
Before that, the implementation of PUF on FPGA and getting the results has been done using the [DA_PUF_Library](https://github.com/scluconn/DA_PUF_Library/tree/master/FPGA_implementation/XORPUF)

-We can measure the correlation between the delay difference value of APUFs and the non-flipping probability of XOR-APUF through the training dataset using the "ChosenChallengeAttack_CorrSimulation.m" script file.

The result of this code and a full description of this methodology have been presented at https://arxiv.org/abs/2312.01256.


