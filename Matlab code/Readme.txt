%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
This text gives the introduction for codes of signal lasso method used in the paper,writting in Matlab code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
We have written two programs based on two algorithms.
(1) One is written using the coordinate descent method we introduced in the paper, and lasso method employed for comparison uses 
default function "lasso" in Matlab software. 
(2) The second algorithm is written based on CVX package, which is a mature optimazition program,
and has been widely used in scientific computation and engineering applications. It is noted if this program is used, 
the cvx package has to be loaded in advance. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(1) The first kind of code include following programs:
Signal_Lasso_1.m                the function for computation of signal lasso using the coordinate descent method,
                                the output is the adjacency matrix of the network.
CV1                             the function of cross-validation programe for selecting the tuning parameters.
Realexample_C1.m                example of the program for cross-validation method for evolutionary game data
Realexample_1_game.m            example of computation for evolutionary game data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

(2) The second kind of code include following programs:
Signal_Lasso_2.m                the function for computation of signal lasso using cvx package,
                                the outpot is the adjacency matrix of network.
LASSO                           program of lasso method using cvx package
CV2                             the function of Cross-validation program for selecting the tuning parameters.
Realexample_C2.m                example for cross-validation method for evolutionary game data
Realexample_2_game.m            example of computation for evolutionary game data
Realexample_2_1_game.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Data generation program
GameUG.m                         Generate the evolutionary UG game data
Payoff_ug.m                      Payoff matrix of UG game
get_data.ug.m                    Get the data of linear equations
karate.txt                       karate network data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
