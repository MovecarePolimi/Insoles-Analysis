# Matlab Insoles Data Analysis

MATLAB GIT INSTRUCTIONS
/*****************************/
- https://it.mathworks.com/help/matlab/source-control.html : scroll to the GIT session
- https://blogs.mathworks.com/community/2014/10/20/matlab-and-git/

/*****************************/

ABOUT THIS PROJECT
/***** SHORT TESTS (i.e. 10_steps) *****/
GOAL: compute gait temporal parameters starting from one straight acquisition

1) Import new data with the script at 'script/start.m' or open an imported .mat file in 'source/mat_data/Lissone/10_steps/onlyImported/ '. 

2) run the script at 'script/data_analysis/short_test/shortTestAnalysis.m' and follow the step selection instuctions at the beginning of the file.

3) run the script to calculate gait parameters at 'script/data_analysis/gaitParameter/computeGaitParams.m';

4) create data structure ('script/data_analysis/gaitParameter/createDataStructure.m') to perform statistical tests ('script/data_analysis/gaitParameter/statisticalTests.m')


/***** LONG TESTS (i.e. 6MWT, TestCallFra) *****/
GOAL: compute gait temporal parameters starting from a long gait acquisition which contains several changes of direction. Here the needs to obtain the straight paths from the overall acquisition and then consider each path as a short test.

1) Import new data in one of the following ways:
1.a) open an imported .mat file in 'source/mat_data/Lissone/6MWT/index_steps/'. 
These .mat files contain the ind_inv_l and ind_inv_r vectors, which represent the timestamps at which the straight paths end (except the first value).
1.b) use the script at 'script/start.m' and import one raw data. Then it is needed to run the script at 'script/data_analysis/long_test/findPathIndex.m' to get the ind_inv_l and ind_inv_r. 

At this point, the two ways (1.a and 1.b) give the same result.

2) Run the script 'script/data_analysis/long_test/getPath.m' to obtain path variables.

3) Open the script 'script/data_analysis/long_test/longTestAnalysis.m' and follow the step selection instructions at the beginning of the file.
It is suggested to manually do cicle iterations since errors during step selection may occur.
Each iteration calculates gait parameters for the specific path and saves the variables.

4) Run the script 'script/data_analysis/gaitParameter/createDataStructure.m' to create the data structure related to that specific 6MWT session.

5) Run the script 'script/data_analysis/gaitParameter/statisticalTest.m'.
