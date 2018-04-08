%% Create a data structure with ST or DT paths

name = 'Fra';   % 'Simo' o 'Fra'
task = 'DT';    % 'ST' o 'DT'
size = 15;      % number of paths

DS_tot =[]; GC_tot =[]; StanceTime_tot =[]; StanceTimePerc_tot =[]; 
StepTime_tot =[]; SwingTime_tot =[]; SwingTimePerc_tot =[]; 
Nr_steps_tot = [];

for index=1:size
    filename = strcat('source/mat_data/Lissone/6MWT/path_parameters/', strcat(name, strcat('_',strcat(task, strcat('/Path_', strcat(num2str(index), '.mat'))))));
    load(filename);
    
    DS_tot = [DS_tot DS_L DS_R];
    GC_tot = [GC_tot GC_L GC_R];
    StanceTime_tot = [StanceTime_tot StanceTime_L StanceTime_R];
    StanceTimePerc_tot = [StanceTimePerc_tot StanceTimePerc_L StanceTimePerc_R];
    StepTime_tot = [StepTime_tot StepTime_L StepTime_R];
    SwingTime_tot = [SwingTime_tot SwingTime_L SwingTime_R];
    SwingTimePerc_tot = [SwingTimePerc_tot SwingTimePerc_L SwingTimePerc_R];
    Nr_steps_tot = [Nr_steps_tot nr_steps_tot];
    
    %{
    DS_L_tot{index} = DS_L;
    DS_R_tot{index} = DS_R; 
    
    GC_L_tot{index} = GC_L;
    GC_R_tot{index} = GC_R;
    GC_size_L_tot{index} = GC_size_L;
    GC_size_R_tot{index} = GC_size_R;
    
    nr_steps_L_tot{index} = nr_steps_L;
    nr_steps_R_tot{index} = nr_steps_R;
    nr_steps_tot_tot{index} = nr_steps_tot;
    
    StanceTime_L_tot{index} = StanceTime_L;
    StanceTime_R_tot{index} = StanceTime_R;
    StanceTimePerc_L_tot{index} = StanceTimePerc_L;
    StanceTimePerc_R_tot{index} = StanceTimePerc_R;
    
    StepTime_L_tot{index} = StepTime_L;
    StepTime_R_tot{index} = StepTime_R;
    
    SwingTime_L_tot{index} = SwingTime_L;
    SwingTime_R_tot{index} = SwingTime_R;
    SwingTimePerc_L_tot{index} = SwingTimePerc_L;
    SwingTimePerc_R_tot{index} = SwingTimePerc_R;
    %}
end

Struct.DS = DS_tot;
Struct.GC = GC_tot;
Struct.stanceTime = StanceTime_tot;
Struct.stanceTimePerc = StanceTimePerc_tot;
Struct.stepTime = StepTime_tot;
Struct.swingTime = SwingTime_tot;
Struct.swingTimePerc = SwingTimePerc_tot;
Struct.nrSteps = Nr_steps_tot;

%{
Struct.DS_L = DS_L_tot;
Struct.DS_R = DS_R_tot;
    
Struct.GC_L = GC_L_tot;
Struct.GC_R = GC_R_tot;
Struct.GC_size_L = GC_size_L_tot;
Struct.GC_size_R = GC_size_R_tot;
    
Struct.nr_steps_L = nr_steps_L_tot;
Struct.nr_steps_R = nr_steps_R_tot;
Struct.nr_steps_tot = nr_steps_tot_tot;
    
Struct.stanceTime_L = StanceTime_L_tot;
Struct.stanceTime_R = StanceTime_R_tot;
Struct.stanceTimePerc_L = StanceTimePerc_L_tot;
Struct.stanceTimePerc_R = StanceTimePerc_R_tot;
    
Struct.stepTime_L = StepTime_L_tot;
Struct.stepTime_R = StepTime_R_tot;
    
Struct.swingTime_L = SwingTime_L_tot;
Struct.swingTime_R = SwingTime_R_tot;
Struct.swingTimePerc_L = SwingTimePerc_L_tot;
Struct.swingTimePerc_R = SwingTimePerc_R_tot;
%}
