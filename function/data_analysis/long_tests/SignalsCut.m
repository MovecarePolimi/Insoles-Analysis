function [Force_cut,Acc_cut,Time_cut,Press_cut]=SignalsCut(Time,Force,Acc,Press,side,k)

%resize force
Force_resized=(Force-200)./200;

figure;
title(side);
plot(Time,Force_resized+6,'k'); hold on;
plot(Time,Acc(:,2),'b','LineWidth',1.5); %yacc
plot(Time,Acc(:,3),'g','LineWidth',1.5); %zacc
legend('Force','AccY','AccZ');title(['Select start and stop ' side num2str(k)]);
[x,~]=ginput(); %start and stop
[~,ind_in]=min(abs(Time-x(1))); [~,ind_fin]=min(abs(Time-x(2)));
Force_resized_cut=Force_resized(ind_in:ind_fin);
Force_cut=Force(ind_in:ind_fin);
Acc_cut =Acc(ind_in:ind_fin,:);
Time_cut=Time(ind_in:ind_fin);
Press_cut=Press(ind_in:ind_fin,:);
end