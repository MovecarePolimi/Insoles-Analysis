Force_resized_L=(L_Force-200)./200;

figure(2);
plot(Time_l,Force_resized_L+6,'k'); hold on;
plot(Time_l,L_Acc(:,2),'b','LineWidth',1.5); %yacc
plot(Time_l,L_Acc(:,3),'g','LineWidth',1.5); %zacc
legend('Force','AccY','AccZ');
title('Left Values');