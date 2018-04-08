function [act_HS_cut,Acc_cut,Time_cut,Force_cut,Press_cut,nr_stepsHS,nr_stepsTO]=ComputeActLong(Force,Time,Acc,Press)
%% Compute activation signal that is 1 when Force is greater than meanForce and 0 otherwise
% outliers are remove in order to identify macro-phases of stance and swing

Press12=Press(:,1)+Press(:,2);%toe off -- avanpiede
Press1213=Press(:,12)+Press(:,13);% heel strike %%tallone
thresPress12=(max(Press12)+min(Press12))/4;
thresPress1213=(max(Press1213)+min(Press1213))/4;
act12=Press12>thresPress12;
act1213=Press1213>thresPress1213;
Dact12=diff(act12);
Dact1213=diff(act1213);

% meanForce=(max(Force)+min(Force))/2;
% act=Force>meanForce;
nr_stepsTO=sum(diff(act12)==1);
nr_stepsHS=sum(diff(act1213)==1);

%% check nr_stepsHS to make it more robust deleting outliers when needed
[a1_1213,b1_1213]=find((Dact1213==1));
[a2_1213,b2_1213]=find((Dact1213==-1));
Da1_1213=diff(a1_1213);
Da2_1213=diff(a2_1213);
media_da1=mean(Da1_1213);
devstd_da1=std(Da1_1213);
media_da2=mean(Da2_1213);
devstd_da2=std(Da2_1213);
indOutliersSaliteHS=[];
indOutliersDisceseHS=[];
if sum(Da1_1213<devstd_da1) ~= 0
    nr_saliteHS=(length(a1_1213)-sum(Da1_1213<devstd_da1));
    indOutliersSaliteHS=find(Da1_1213<devstd_da1);
    disp('c''e'' un outlierHS in salita')
end
if sum(Da2_1213<devstd_da2) ~= 0
    nr_disceseHS=(length(a2_1213)-sum(Da2_1213<devstd_da2));
    indOutliersDisceseHS=find(Da2_1213<devstd_da2);
    disp('c''e'' un outlierHS in discesa')
end
count=0;
if not(isempty(indOutliersSaliteHS)) 
    if (a2_1213(indOutliersSaliteHS)-a1_1213(indOutliersSaliteHS))==1 
    %% qui rimuovo dal vettore a1 e a2 gli indici degli outliers --> da testare meglio forse 
    act1213(a2_1213(indOutliersSaliteHS)+1)=1; 
    a1_1213(indOutliersSaliteHS+1)=[];
    a2_1213(indOutliersSaliteHS)=[];
    count=count+1;
    end
end

if not(isempty(indOutliersDisceseHS)) 
    if (a1_1213(indOutliersDisceseHS+1)-a2_1213(indOutliersDisceseHS))==1 
    %% qui rimuovo dal vettore a1 e a2 gli indici degli outliers --> da testare meglio forse 
    act1213(a2_1213(indOutliersDisceseHS)+1)=1; 
    a1_1213(indOutliersDisceseHS+1)=[];
    a2_1213(indOutliersDisceseHS)=[];
    count=count+1;
    end
end
% %% 


nr_stepsHS=sum(diff(act1213)==1);

figure
plot(Press12)
title('Press 12 1213')
hold on
plot(linspace(1,length(Press12),length(Press12)),ones(length(Press12),1)*thresPress12,'b')
plot(Press1213)
plot(linspace(1,length(Press1213),length(Press1213)),ones(length(Press1213),1)*thresPress1213,'r')



    
init=min(find((act1213==1)));
fin=max(find((act12==0)));
Force_cut=Force(init:fin);
act_HS_cut=act1213(init:fin);%actHS
Acc_cut=Acc(init:fin,:);
Time_cut=Time(init:fin);
Press_cut=Press(init:fin,:);


end