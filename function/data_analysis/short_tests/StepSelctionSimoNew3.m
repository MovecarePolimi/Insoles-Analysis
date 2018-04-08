function [nr_steps,ICnew,ind_in,ind_fin,ind_initICnew,ind_finIC,Acc_cut,Force_cut,Press_cut,Time_cut,PO]=StepSelctionSimoNew3(Time,Force,Acc,Press)
%%% NB
%%% ind_initIC e ind_finIC posso eliminarli dalle uscite
%%% anche IC posso eliminarlo perchè ora è zero ma prima era l'IC di Fra
%%% per funzionare devo selezionare la fine dell'intervallo in basso
%%% 
%%%

%resize force
Force_resized=(Force-200)./200;

figure;
plot(Time,Force_resized+6,'k'); hold on;
plot(Time,Acc(:,2),'b','LineWidth',1.5); %yacc
plot(Time,Acc(:,3),'g','LineWidth',1.5); %zacc
legend('Force','AccY','AccZ');title('Select start and stop');
[x,~]=ginput(); %start and stop : valori alti da fermo all'ultimo passo
[~,ind_in]=min(abs(Time-x(1))); [~,ind_fin]=min(abs(Time-x(2)));
Force_resized_cut=Force_resized(ind_in:ind_fin);
Force_cut=Force(ind_in:ind_fin);
Acc_cut =Acc(ind_in:ind_fin,:);
Press_cut=Press(ind_in:ind_fin,:);
Press_toe=Press_cut(:,1)+Press_cut(:,2);
%Press_toe=Press_cut(:,1);
%Press_toe=Press_cut(:,2);
Time_cut=Time(ind_in:ind_fin);
figure;
plot(Force_resized_cut+4,'k'); hold on;
plot(Acc_cut(:,2),'b'); %yacc
plot(Acc_cut(:,3),'c'); %zacc
legend('Force','AccY','AccZ');
prompt = {'Number of steps:'}; answer = inputdlg(prompt);
nr_stepsman= str2num(answer{1})

IC=0;
%% compute nr_steps according to the signal act computed on Forcecut
DForce_cut=diff(Force_cut);
[PKS_F,LOCS_F,W_F,P_F] = findpeaks(Force_cut);
[PKS_DF,LOCS_DF,W_DF,P_DF] = findpeaks(DForce_cut);
ToComputeFPeaks=P_DF.*PKS_DF;

meanForce=(max(Force_cut)+min(Force_cut))/2;
act=Force_cut>meanForce;
Dact=diff(act);
nr_steps=sum(diff(act)==1);% numero fronti di salita

%% check nr_steps to make it more robust deleting outliers of act when needed
[a1,b1]=find((Dact==1));
[a2,b2]=find((Dact==-1));
a3=sort([a1;a2]);
da3=diff(a3);
media=mean(da3);
devstd=std(da3);
nr_stepsok=ceil((length(da3)-sum(da3<devstd))/2);
indoutliers=find(da3<devstd);%trova fasi della forza che scendono e subito salgono sopra al valore medio..
if not(isempty(find(da3<devstd)))
    %% qui rimuovo dal vettore a3 gli indici degli outliers --> da testare meglio forse
    a3(indoutliers)=[];
end
medianew=mean(da3);
devstdnew=std(da3);
if ((min(a1(1),a2(1)) > medianew) && (a2(1)>a1(1)))
    act(1)=1;
    Dact=diff(act);
    [a1,b1]=find((Dact==1));
    [a2,b2]=find((Dact==-1));
    a3=sort([a1;a2]);
    da3=diff(a3);
    media=mean(da3);
    devstd=std(da3);
    nr_stepsok=ceil((length(da3)-sum(da3<devstd))/2);
    indoutliers=find(da3<devstd);%trova fasi della forza che scendono e subito salgono sopra al valore medio..
    if not(isempty(find(da3<devstd)))
        %% qui rimuovo dal vettore a3 gli indici degli outliers --> da testare meglio forse
        a3(indoutliers)=[];
    end
    medianew=mean(da3);
    devstdnew=std(da3);
end
if nr_stepsok==nr_stepsman
    
    %% trovafre indice finale in cui cercare IC che è il flesso del fronte di salita della forza
    ToComputePeaksProv=ToComputeFPeaks;
    imax=zeros(nr_steps,1);%imax contiene gli indici di ToComputePeaks caratterizzati dai valori massimi
    N=round(medianew/3);
    j=1;
    for i=2:2:length(a3)
        for k=1:length(ToComputeFPeaks)
            if (LOCS_DF(k)<(a3(i)+N)) & (LOCS_DF(k)>(a3(i)-N))
                %disp('ok');disp(k);
                PeaksBuoni(j)=k;
                j=j+1;
            end
        end
        [indexOttimi,Ottimi]=max(ToComputeFPeaks(PeaksBuoni));
        PeaksOttimi(i/2)=PeaksBuoni(Ottimi);
        j=1;
        clear PeaksBuoni;
    end
    
    ind_finIC=LOCS_DF(PeaksOttimi);
    
    %% cerca picco massimo acc che è l'indice iniziale da dove cercare IC
    [PKS_Acc2,LOCS_Acc2,W_Acc2,P_Acc2] = findpeaks(Acc_cut(:,2)-min(Acc_cut(:,2)));
    figure
    plot(Acc_cut(:,2),'r');hold on
    plot(LOCS_Acc2,PKS_Acc2,'k*');
    ToComputeFPeaksAcc=P_Acc2.*PKS_Acc2;
    plot(LOCS_Acc2,ToComputeFPeaksAcc,'ko');
    clear ToComputePeaksProv;
    ToComputePeaksProv=ToComputeFPeaksAcc;
    for i=1:2:length(a3)-1
        indInitAccPeak(ceil(i/2))=(a3(i)+a3(i+1))/2;
    end
    for k=1:2:length(a3)-1
        [~,a]=max(Acc_cut(ceil((a3(k)+a3(k+1))/2):ind_finIC(ceil(k/2)),2));
        ind_initICnew(ceil(k/2))=a+ceil((a3(k)+a3(k+1))/2)-1;
    end
    %%
    %
    [PKS_notAcc2,LOCS_notAcc2,W_notAcc2,P_notAcc2] = findpeaks(-(Acc_cut(:,2)-min(Acc_cut(:,2))));
    clear val;
    ToSelectPeaksAcc=PKS_notAcc2;
    j=1;
    for i=1:nr_steps
        %[val(i),prova]=min(find(LOCS_notAcc2>ind_initICnew(i)));%prende qualsiasi picco anche segnale sporco.. ve inserito controllo su ppks
        [a,b]=find((LOCS_notAcc2>ind_initICnew(i)) & (LOCS_notAcc2<(ind_finIC(i)-1)));
        if length(a)>0
            [c,d]=max(ToSelectPeaksAcc(a));
            indicemaxok(i)=a(1)+d-1;
            ICnew(i)=LOCS_notAcc2(indicemaxok(i));
            %disp('step');disp(i);disp('picco');
            
        else
            [valoremin(i),indicemin(i)] = min(Acc_cut((ind_initICnew(i):ind_finIC(i)),2));
            indiceminok(i)=indicemin(i)+ind_initICnew(i)-1;
            ICnew(i)=indiceminok(i);
            disp('step');disp(i);disp('valmin');
            stepICerrato(j)=i;
            j=j+1;
        end
        
    end
    %% parte nuova per i casi con profilo acc non standard in cui guardo la forza
    if j>1
        ICvalid=ICnew;
        ICvalid(stepICerrato)=[];
        ForceIC=Force_cut(ICvalid);
        mediaFIC=mean(ForceIC);
        devstdFIC=std(ForceIC);
        sogliaForce=mediaFIC+devstdFIC;
        actSogliaForce=Force_cut>sogliaForce;
        DactSogliaForce=diff(actSogliaForce);
        [valPosSogliaForce,iPosSogliaForce]=find((DactSogliaForce==1));
        for i=1:length(stepICerrato)
            indIC=max(find(valPosSogliaForce<a3(stepICerrato(i)*2)));
            ICnew(stepICerrato(i))=valPosSogliaForce(indIC);
        end
    end
    
    %%
    figure
    ax1=subplot(311);
    plot(DForce_cut,'b');
    hold on;
    plot(LOCS_DF,PKS_DF,'ro');
    plot(LOCS_DF(PeaksOttimi),PKS_DF(PeaksOttimi),'k*');
    ax2=subplot(312);
    plot(Force_cut,'r');hold on;
    plot(LOCS_F,PKS_F,'bo');
    plot(LOCS_F,P_F,'b*');
    plot(ICnew,Force_cut(ICnew),'co');
    ax3=subplot(313);
    plot(Acc_cut(:,2),'b'); %yacc
    hold on
    plot(ind_initICnew,Acc_cut(ind_initICnew,2),'m*');
    plot(ind_finIC,Acc_cut(ind_finIC,2),'r*');
    plot(-(Acc_cut(:,2)-min(Acc_cut(:,2))));
    plot(ICnew,-(Acc_cut(ICnew,2)-min(Acc_cut(ICnew,2))),'co');
    linkaxes([ax1,ax2,ax3], 'x');
    
    figure;
    plot(Force_cut,'r');hold on;
    plot(ICnew,Force_cut(ICnew),'b*');
    plot(act*100);
    plot(Acc_cut);
    
else
    disp('nr_steps is not valid');
end

%% da qui in poi SW di Fra per i Push OFF
% si può cambiare e sfruttare anche la Forza oltre che l'AccY
% calcola il primo PO sempre dopo il primo IC
Dpress=smooth(diff(Press_toe),20,'moving'); %derivata pressione smooth. cerco i  minimi come toe-off

for k=1:nr_stepsok-1 %vado a cercare PO tra due IC consecutivi
    inizio=ICnew(k); fine=ICnew(k+1);
    in_discesa=find(Dact(inizio:fine)==-1); in_discesa=in_discesa+inizio-1;
    indicibassi=find(act(in_discesa:fine)==0); in_basso(k)=indicibassi(1)+in_discesa-1;
    in_alto(k)=round((fine-in_basso(k))/3)+in_basso(k);
    %cerco il primo picco di forza nella parte bassa dell'onda quadra
    %a=find(LOCS_F>in_basso); ind_locs_ok=a(1);
    %cerco il primo picco di forza nella parte bassa dell'onda quadra
    %[~,pos]=min(Dpress(in_basso:fine));
    [index_PO]=FindPO(Acc_cut(in_basso(k):in_alto(k),2));
    PO(k)=index_PO+in_basso(k)-1;
end
inizio=ICnew(k+1);
in_discesa=find(Dact(inizio:end)==-1); in_discesa=in_discesa+inizio-1;
indicibassi=find(act(in_discesa:end)==0); in_basso(k+1)=indicibassi(1)+in_discesa-1;
in_alto(k+1)=length(Acc_cut(:,2));
[index_PO]=FindPO(Acc_cut(in_basso(k+1):in_alto(k+1),2));
PO(k+1)=index_PO+in_basso(k+1)-1;

%{
figure;
subplot(211);
plot(Force_cut,'r');hold on;
h1 = plot(ICnew,Force_cut(ICnew),'b*');
h2 = plot(PO,Force_cut(PO),'g*');
plot(act*100);
xlabel('Time (ms)') % x-axis label
ylabel('Force (N)') % y-axis label
legend([h1 h2],{'IC','PO'});

subplot(212);
plot(Acc_cut(:,2),'r');hold on;
h3 = plot(ICnew,Acc_cut(ICnew),'b*');
h4 = plot(PO,Acc_cut(PO,2),'g*');
xlabel('Time (ms)') % x-axis label
ylabel('Acceleration Y (g)') % y-axis label
legend([h3 h4],{'IC','PO'});
%}
PascalFactor = 10000;
Time_cut = Time_cut/1000;
figure;
subplot(211);
plot(Time_cut, Force_cut,'k');hold on;
h1 = plot(Time_cut(ICnew),Force_cut(ICnew),'r*');
h2 = plot(Time_cut(PO),Force_cut(PO),'g*');
xlabel('Time (s)') % x-axis label
ylabel('Total Force (N)') % y-axis label
yyaxis right;
ylabel('Heel Strike Pressure (Pa)') % y-axis label
plot(Time_cut,Press_cut(:,12)*PascalFactor + Press_cut(:,13)*PascalFactor);
legend([h1 h2],{'IC','PO'});

subplot(212);
plot(Time_cut, Acc_cut(:,2),'k');hold on;
h3 = plot(Time_cut(ICnew),Acc_cut(ICnew,2),'r*');
h4 = plot(Time_cut(PO),Acc_cut(PO,2),'g*');
xlabel('Time (s)') % x-axis label
ylabel('Acceleration Y (g)') % y-axis label
legend([h3 h4],{'IC','PO'});

% %divide in passi
% for k=1:nr_steps-1
%     Acc_Steps{k}=Acc_cut(ICnew(k):ICnew(k+1),:);
%     Force_Steps{k}=Force_cut(ICnew(k):ICnew(k+1),:);
% end
% %Trova push-off sulla base del segnale dell'accelerometro
% for k=1:nr_steps-1
%     [index_PO(k)]=FindPO(Acc_Steps{k}(:,2));
%     PO1(k)=index_PO(k)+ICnew(k)-1;
% end
% %Trova push-off sulla base del segnale della Forza
% clear index_PO;
% for k=1:nr_steps-1
%     [index_PO(k)]=FindPOForce(Force_Steps{k}(:,1));
%     PO2(k)=index_PO(k)+ICnew(k)-1;
% end
% figure;
% plot(Force_cut);hold on
% plot(act*100);
% for k=1:length(PO1)
%     plot(PO1(k),Force_resized_cut(PO1(k))+4,'*m');
%     hold on
% end
% for k=1:length(PO1)
%     plot(PO2(k),Force_resized_cut(PO2(k))+4,'*c');
%     hold on
% end
%
%
%
