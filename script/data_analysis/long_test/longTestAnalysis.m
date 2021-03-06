
%% (1) Select instructions (on force plot):
%%     - "start" and "stop": skip incomplete steps; usually, skip at least one step 
%% (2) Insert the number of steps (count ICs)


%% I strongly suggest to execute the following operations one by one (for each path)
%% outside the for loop, since errors on step selection may occur and break the loop.

numPath = size(Path_Acc_L,2);
index=5;
for index= 1:numPath 
%left
close all
side = 'left';
[Force_cut_L,Acc_cut_L,Time_cut_L,Press_cut_L] = ...
    SignalsCut(Path_Time_L{index},  ...
               Path_Force_L{index}, ...
               Path_Acc_L{index},   ...
               Path_Press_L{index}, ...
               side,                ...
               index);

[actHS_cut_L,Acc_cut_L,Time_cut_L,Force_cut_L,Press_cut_L,nr_stepsHS,nr_stepsTO] = ...
    ComputeActLong(Force_cut_L, ...
                   Time_cut_L,  ...
                   Acc_cut_L,   ...
                   Press_cut_L);

[nr_steps_L,IC_L,ind_initIC_L,ind_finIC_L,Acc_cut_L,Force_cut_L,Press_cut_L,Time_cut_L,PO_L] = ...
    StepSelctionSimoNew3Long(Time_cut_L,  ...
                             Force_cut_L, ...
                             Acc_cut_L,   ...
                             Press_cut_L, ...
                             nr_stepsHS,  ...
                             nr_stepsTO,  ...
                             actHS_cut_L);

% right
close all
side = 'right';
[Force_cut_R,Acc_cut_R,Time_cut_R,Press_cut_R] = ...
    SignalsCut(Path_Time_R{index},  ...
               Path_Force_R{index}, ...
               Path_Acc_R{index},   ...
               Path_Press_R{index}, ...
               side,                ...
               index);
           
[actHS_cut_R,Acc_cut_R,Time_cut_R,Force_cut_R,Press_cut_R,nr_stepsHS_R,nr_stepsTO_R] = ...
    ComputeActLong(Force_cut_R, ...
                   Time_cut_R,  ...
                   Acc_cut_R,   ...
                   Press_cut_R);
               
[nr_steps_R,IC_R,ind_initIC_R,ind_finIC_R,Acc_cut_R,Force_cut_R,Press_cut_R,Time_cut_R,PO_R] = ...
    StepSelctionSimoNew3Long(Time_cut_R,   ...
                             Force_cut_R,  ...
                             Acc_cut_R,    ...
                             Press_cut_R,  ...
                             nr_stepsHS,   ...
                             nr_stepsTO_R, ...
                             actHS_cut_R);

computeGaitParams;

%% Variables from each loop are saved in 'source/mat_data/Lissone/6MWT/path_parameters/'
%{
    dest = 'YOUR PATH FILE'; 
    save(dest),...
    'DS_L', 'DS_R', 'GC_L', 'GC_R', 'GC_size_L', 'GC_size_R', 'nr_steps_L', 'nr_steps_R', 'nr_steps_tot', ...
    'StanceTime_L', 'StanceTime_R', 'StanceTimePerc_L', 'StanceTimePerc_R', 'StepTime_L', 'StepTime_R', ...
    'SwingTime_L', 'SwingTime_R', 'SwingTimePerc_L', 'SwingTimePerc_R', 'name', 'task', 'index');

%}
% Now clear all, increase index and repeat the operation with the next path.    
end
