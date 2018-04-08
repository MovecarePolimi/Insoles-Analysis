
name='Simo';  % "Simo" or "Fra"
nrprove=10;

Stance_time_L_tot=[]; Stance_time_R_tot=[]; %gait rite
StanceTime_L_tot=[]; StanceTime_R_tot=[];  %insoles
Step_time_L_tot=[]; Step_time_R_tot=[]; %gait rite
StepTime_L_tot=[]; StepTime_R_tot=[];  %insoles
Stride_time_L_tot=[]; Stride_time_R_tot=[]; %gait rite
GC_L_tot=[]; GC_R_tot=[]; %insoles
Supp_time_Double_L_tot=[]; Supp_time_Double_R_tot=[]; %gait rite
DS_L_tot=[]; DS_R_tot=[]; %insoles
Swing_time_L_tot=[]; Swing_time_R_tot=[]; %gait rite
SwingTime_L_tot=[]; SwingTime_R_tot=[]; %insoles

for k=1:nrprove
    if (k==4 && strcmp(name,'Fra')==1)
    else
    filename_mat=strcat(name,'Prova',num2str(k),'_clear.mat');
    filename_gr=strcat('GR_',name,num2str(k),'.mat');
    load(filename_mat);
    load(filename_gr);
    Stance_time_L_tot=[Stance_time_L_tot;Stance_time_L];  Stance_time_R_tot=[Stance_time_R_tot;Stance_time_R];
    Step_time_L_tot=[Step_time_L_tot;Step_time_L];  Step_time_R_tot=[Step_time_R_tot;Step_time_R];
    Stride_time_L_tot=[Stride_time_L_tot;Stride_time_L];  Stride_time_R_tot=[Stride_time_R_tot;Stride_time_R];
    Supp_time_Double_L_tot=[Supp_time_Double_L_tot;Supp_time_Double_L];  Supp_time_Double_R_tot=[Supp_time_Double_R_tot;Supp_time_Double_R];
    Swing_time_L_tot=[Swing_time_L_tot;Swing_time_L];  Swing_time_R_tot=[Swing_time_R_tot;Swing_time_R];
    
    StanceTime_L_tot=[StanceTime_L_tot,StanceTime_L];  StanceTime_R_tot=[StanceTime_R_tot,StanceTime_R];
    StepTime_L_tot=[StepTime_L_tot,StepTime_L];  StepTime_R_tot=[StepTime_R_tot,StepTime_R];
    GC_L_tot=[GC_L_tot,GC_L];  GC_R_tot=[GC_R_tot,GC_R];
    DS_L_tot=[DS_L_tot,DS_L];  DS_R_tot=[DS_R_tot,DS_R];
    SwingTime_L_tot=[SwingTime_L_tot,SwingTime_L];  SwingTime_R_tot=[SwingTime_R_tot,SwingTime_R];
    end
end


% 1.Stance Time
BlandAltman(Stance_time_L_tot,StanceTime_L_tot',{'GRStanceTime_L','INSStanceTime_L'});
BlandAltman(Stance_time_R_tot,StanceTime_R_tot',{'GRStanceTime_R','INSStanceTime_R'});
BlandAltman([Stance_time_L_tot;Stance_time_R_tot],[StanceTime_L_tot,StanceTime_R_tot]',{'GRStanceTime','INSStanceTime'});
% 2.Step Time
BlandAltman(Step_time_L_tot,StepTime_L_tot',{'GRStepTime_L','INSStepTime_L'});
BlandAltman(Step_time_R_tot,StepTime_R_tot',{'GRStepTime_R','INSStepTime_R'});
BlandAltman([Step_time_L_tot;Step_time_R_tot],[StepTime_L_tot,StepTime_R_tot]',{'GRStepTime','INSStepTime'});
% 3.Stride Time
BlandAltman(Stride_time_L_tot,GC_L_tot',{'GRStrideTime_L','INSStrideTime_L'});
BlandAltman(Stride_time_R_tot,GC_R_tot',{'GRStrideTime_R','INSStrideTime_R'});
BlandAltman([Stride_time_L_tot;Stride_time_R_tot],[GC_L_tot,GC_R_tot]',{'GRStrideTime','INSStrideTime'});
% 4.Double Support Time
BlandAltman(Supp_time_Double_L_tot,DS_L_tot',{'GRDoublSupport_L','INSDoublSupport_L'});
BlandAltman(Supp_time_Double_R_tot,DS_R_tot',{'GRDoublSupport_R','INSDoublSupport_R'});
BlandAltman([Supp_time_Double_L_tot;Supp_time_Double_R_tot],[DS_L_tot,DS_R_tot]',{'GRDoublSupport','INSDoublSupport'});
% 5.Swing Time
BlandAltman(Swing_time_L_tot,SwingTime_L_tot',{'GRSwingTime_L','INSSwingTime_L'});
BlandAltman(Swing_time_R_tot,SwingTime_R_tot',{'GRSwingTime_R','INSSwingTime_R'});
BlandAltman([Swing_time_L_tot;Swing_time_R_tot],[SwingTime_L_tot,SwingTime_R_tot]',{'GRSwingTime','INSSwingTime'});

% [length(Step_time_R),length(StepTime_R)]
% [length(Step_time_L),length(StepTime_L)]
% 
% [length(Stance_time_R),length(StanceTime_R)]
% [length(Stance_time_L),length(StanceTime_L)]
% 
% [length(Swing_time_R),length(SwingTime_R)]
% [length(Swing_time_L),length(SwingTime_L)]
% 
% [length(Stride_time_R),length(GC_R)]
% [length(Stride_time_L),length(GC_L)]
% 
% [length(Supp_time_Double_R),length(DS_R)]
% [length(Supp_time_Double_L),length(DS_L)]