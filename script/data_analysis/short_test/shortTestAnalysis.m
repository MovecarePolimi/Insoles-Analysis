clc; close all;

%% (1) Select instructions (on force plot):
%%     - "start" at the beginning of the first step (before the IC, 
%%       that is the first minimun peak on the force plot)
%%     - "stop" at the end of the last step (before the PO, 
%%       that is the last minimun peak on the force plot)
%% (2) Insert the number of steps (count ICs or POs or bells)
%Left
close all;
[nr_steps_L,IC_L,ind_in_L,ind_fin_L,ind_initIC_L,ind_finIC_L,Acc_cut_L,Force_cut_L,Press_cut_L,Time_cut_L,PO_L] ...
    = StepSelctionSimoNew3(Time_l,L_Force,L_Acc,L_Press);

%ICnew_L is IC indexes vector, PO_L is PO indexes vector

%Right
close all;
[nr_steps_R,IC_R,ind_in_R,ind_fin_R,ind_initIC_R,ind_finIC_R,Acc_cut_R,Force_cut_R,Press_cut_R,Time_cut_R,PO_R] ...
    = StepSelctionSimoNew3(Time_r,R_Force,R_Acc,R_Press);

%Compute gait parameters
M1_L = Time_cut_L(IC_L);
M2_L = Time_cut_L(PO_L);
M1_R = Time_cut_R(IC_R);
M2_R = Time_cut_R(PO_R);

Mat_L = [M1_L, M2_L]./1000;
Mat_R = [M1_R, M2_R]./1000;
COL_IC = 1;
COL_PO = 2;
MatSize_L = size(Mat_L,1);
MatSize_R = size(Mat_R,1);
nr_steps_tot = nr_steps_L + nr_steps_R;

%Gait Cycle: elapsed time between the 1st contact of 2 consecutive footfalls of the same foot.
for k=2:nr_steps_tot
    if(MatSize_L >= k)
        GC_L(k-1) = (Mat_L(k,COL_IC) - Mat_L(k-1, COL_IC));
    end
    if(MatSize_R >= k)
        GC_R(k-1) = (Mat_R(k,COL_IC) - Mat_R(k-1, COL_IC));
    end
end

GC_size_L = size(GC_L,2);
GC_size_R = size(GC_R,2);

%Step Time: time elapsed from the 1st contact of one foot to the first contact
%of the opposite foot.
% Left: (IC_L - IC_R)
% Right: (IC_R - IC_L)

ICtime_tot=[Time_cut_L(IC_L)',Time_cut_R(IC_R)']; 
ICtime_order=sort(ICtime_tot,'ascend');
StepT=diff(ICtime_order)./1000; %in secondi
StepTime_L = StepT(:,1:2:end); % righe dispari
StepTime_R = StepT(:,2:2:end); % righe dispari

%6) Single Support Time: the time elapsed between the Last Contact of the
%current footfall to the First Contact of the next footfall of the same foot. 
%This is equal to the Swing Time of the opposite foot.

% Double Support: the time elapsed between 1st Contact of the current footfall
% and the Last Contact of the previous footfall + the time elapsed between the Last
% Contact of the current footfall and the 1st Contact of the next footfall. 
for k=1:GC_size_R
    % (PO_R - IC_L) + (PO_L -IC_R del ciclo successivo)
    DS_R(k)=Mat_R(k,COL_PO)-Mat_L(k,COL_IC) + Mat_L(k,COL_PO)-Mat_R(k+1,COL_IC);
    
    if(GC_size_L >= k)
        % (PO_L - IC_R del ciclo successivo) + (PO_R del ciclo successivo -IC_L del ciclo successivo)
        DS_L(k)=Mat_L(k,COL_PO)-Mat_R(k+1,COL_IC) + Mat_R(k+1,COL_PO)-Mat_L(k+1,COL_IC);
    end
end

% Stance Time: the time elapsed between the 1st Contact and the Last Contact 
% of two consecutive footfalls on the same foot. (% Gait Cycle of the same foot) 
for k=1:GC_size_R
    % PO - IC (sia L che R)
    StanceTime_R(k) = Mat_R(k,COL_PO) - Mat_R(k,COL_IC); 
    StanceTimePerc_R(k) = StanceTime_R(k)/GC_R(k);
    
    if(GC_size_L >= k)
        StanceTime_L(k) = Mat_L(k,COL_PO) - Mat_L(k,COL_IC);
        StanceTimePerc_L(k) = StanceTime_L(k)/GC_L(k);
    end
end

% Swing Time: time elapsed between the Last Contact of the current footfall to 
% the First Contact of the next footfall on the same foot (% Gait Cycle of the 
% same foot). Swing Time is equal to the Single Support time of the opposite foot.
for k=1:GC_size_R
    % IC successivo - PO precedente (sia L che R)
    SwingTime_R(k) = Mat_R(k+1,COL_IC) - Mat_R(k,COL_PO); 
    SwingTimePerc_R(k) = SwingTime_R(k)/GC_R(k);
    
    if(GC_size_L >= k)
        SwingTime_L(k) = Mat_L(k+1,COL_IC) - Mat_L(k,COL_PO);
        SwingTimePerc_L(k) = SwingTime_L(k)/GC_L(k);
    end
end  