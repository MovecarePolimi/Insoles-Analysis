%function [ind_inv_l,ind_inv_r] = find_path_index(L_Acc,Time_l,Time_r);

figure;
plot(L_Acc(:,3)); title('select 2-point baseline, where acc null (start)')
[x,y]=ginput(2);
x=round(x);
AccZ_det=L_Acc(:,3)-mean(L_Acc(x(1):x(2),3));
AccY_det=L_Acc(:,2)-mean(L_Acc(x(1):x(2),2));
AccX_det=L_Acc(:,1)-mean(L_Acc(x(1):x(2),1));

sign=sqrt(AccZ_det.^2+AccY_det.^2);

figure; 
plot(sign);

fs=50;
Wn=0.3;
[b,a]=butter(5,Wn/(fs/2),'low');
Acc_filt=filtfilt(b,a,abs(sign));

figure; 
plot(Acc_filt,'k');
title('select vertical line such that all negative peaks are below it');
[x1,y1]=ginput(1);
x1=round(x1); y1=round(y1);
sign_det=Acc_filt-y1;
for k=2:length(sign_det)
    sign2(k-1)=sign_det(k).*sign_det(k-1);
end
indici=find(sign2<0);
ind_inv_l=[];
for k=2:2:length(indici)-1
    [m,pos]=min(Acc_filt(indici(k):indici(k+1)));
    ind_inv_l(k/2+1)=pos+indici(k)-1;
end
[m,ind_inv_l(1)]=min(Acc_filt(1:indici(1)));
[m,pos]=min(Acc_filt(indici(end):end));
ind_inv_l(length(ind_inv_l)+1)=pos+indici(end)-1;

time_indici_L=Time_l(ind_inv_l);
for k=1:length(time_indici_L)
    differenza=Time_r-time_indici_L(k);
    [m,ind_inv_r(k)]=min(abs(differenza));
end

close all;