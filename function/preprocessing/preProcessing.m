function [Time, Time_l,Time_r, L_Acc, R_Acc, L_Press, R_Press, L_Cop, R_Cop, L_Force, R_Force] = preProcessing(Matrix)
%%
% Receives Data Matrix as input (Matrix) and returns different
% arrays for data processing. The goal is removing NaN.

% Data Matrix indexes order:
% 1)ts;	2)msg_def_left; 3)msg_def_right; 

% 4)l_acc_x; 5)l_acc_y; 6)l_acc_z;
% 7-19)l_pres_0-12; 20)l_tf; 21)l_cop_x; 22)l_cop_y; 

% 23)r_acc_x; 24)r_acc_y; 25)r_acc_z; 
% 26-38)r_pres_0-12; 39)r_tf; 40)r_cop_x; 41)r_cop_y 

Time=Matrix(:,1)-Matrix(1,1);

% Create L and R vectors with valid values index (msg_def ~= 0)
Ind_l=find(Matrix(:,2)~=0); 
Ind_r=find(Matrix(:,3)~=0); 

% Get only the valid ts, for left and right
Time_l=Time(Ind_l); 
Time_r=Time(Ind_r);

L_Acc=[Matrix(Ind_l,4),Matrix(Ind_l,5),Matrix(Ind_l,6)];
R_Acc=[Matrix(Ind_r,23),Matrix(Ind_r,24),Matrix(Ind_r,25)];

L_Press=[Matrix(Ind_l,7),Matrix(Ind_l,8),Matrix(Ind_l,9),Matrix(Ind_l,10),Matrix(Ind_l,11),Matrix(Ind_l,12),Matrix(Ind_l,13),Matrix(Ind_l,14),Matrix(Ind_l,15),Matrix(Ind_l,16),Matrix(Ind_l,17),Matrix(Ind_l,18),Matrix(Ind_l,19)];
R_Press=[Matrix(Ind_r,26),Matrix(Ind_r,27),Matrix(Ind_r,28),Matrix(Ind_r,29),Matrix(Ind_r,30),Matrix(Ind_r,31),Matrix(Ind_r,32),Matrix(Ind_r,33),Matrix(Ind_r,34),Matrix(Ind_r,35),Matrix(Ind_r,36),Matrix(Ind_r,37),Matrix(Ind_r,38)];

L_Cop=[Matrix(Ind_l,21),Matrix(Ind_l,22)];
R_Cop=[Matrix(Ind_r,40),Matrix(Ind_r,41)];

L_Force=Matrix(Ind_l,20);
R_Force=Matrix(Ind_r,39);

end

