/**** CURRENT FOLDER ****/
This folder contains the data acquired with the Moticon Insoles and GaitApp (noAPI), divided in "raw_data" and "file_mat" folders.

"raw_data" folder contains the raw data, as they are created by the GaitApp.
"file_mat" folder contains the preprocessed data (.mat) to be easily opened by MATLAB.


/**** "raw_data" FOLDER ****/

The subfolder are the following ones:

1) "Lissone": it contains the data acquired in Lissone, divided in three subfolders:

1.a) "6MWT";
1.b) "10_steps";
1.c) "GaitRite": it contains gait data from GaitRite to be compared with data acquired from the Insoles, in order to validate the "10_steps" folder data.

2) "test_call_fra": it contains the 6 insoles acquisitions while the smartphone is involved in different call tasks to understand if a huge data leak occurs.
The different tests are 3 minutes walking test:
- ST_1, ST_2: simple single data task acquisition;
- DT_INC_ALL: dual task with an incoming call for all the test duration;
- DT_INC_1MIN: dual task with a 1 minute incoming call which starts after 1 minutes of acquisition;
- DT_OUT_ALL: dual task with an outcoming call for all the test duration;
- DT_OUT_1MIN: dual task with a 1 minute outcoming call which starts after 1 minutes of acquisition.



/**** "mat_data" FOLDER ****/

The subfolders are the same previously described:

1) "Lissone": 

1.a) "6MWT": it contains 2 subfolders:

1.a.1) "index_steps": includes the index vectors whose each value indicates the index at with separate the signal in order to obtain each single path (straight gait).

1.a.2) "path_parameters": includes several subfolders which contain the single paths and "Struct_final" with all the gait temporal parameter grouped in a unique data structure.

1.b) "10_steps": it contains 10 steps files for all the 10 steps tests in two different version: (i) a full version with temporal parameters and vectors from which those parameters are calculated and (ii) a "_clear" version with only temporal parameters (for analysis task).

1.c) "GaitRite": it contains preprocessed gait data from GaitRite in the pattern 	  	  GR_<name><index>, for both Simona and Francesca tests.

2) "test_call_fra": it simply contains the same raw data but in a .mat format, to be easily opened with MATLAB.

