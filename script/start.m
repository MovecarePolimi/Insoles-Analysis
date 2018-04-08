
clear all;

% Choose and customize one of the following path 
%% Path 10 steps - change name ('Fra', 'Simo') and index (1:10)
%path = "source/raw_data/Lissone/10_steps/Fra/Fra_GR_1";
%path = "source/raw_data/Lissone/10_steps/Simo/Simo_GR_1";
%% Path 6MWT - change name('Fra', 'Simo') and type ('ST', 'DT')
%path = "source/raw_data/Lissone/6MWT/Fra/Fra_6MWT_ST";
%path = "source/raw_data/Lissone/6MWT/Simo/Simo_6MWT_ST";
%% Path TestCallFra
%path = 'source/raw_data/test_call_fra/ST_1';
%path = 'source/raw_data/test_call_fra/ST_2';
%path = 'source/raw_data/test_call_fra/DT_OUT_ALL';
%path = 'source/raw_data/test_call_fra/DT_OUT_1MIN';
%path = 'source/raw_data/test_call_fra/DT_INC_ALL';
%path = 'source/raw_data/test_call_fra/DT_INC_1MIN';

path = "source/raw_data/test_0404/Insoles - Simona - ST";
storePath = "source/mat_data/test_0404/SimonaST";
Matrix = importDataAsMatrix(path);

[Time, Time_l, Time_r, L_Acc, R_Acc, L_Press, R_Press, L_Cop, R_Cop, L_Force, R_Force] = preProcessing(Matrix);
save(storePath);