
Force_resized_R=(R_Force-200)./200;

figure(2);
plot(Time_r,Force_resized_R+6,'k'); hold on;
plot(Time_r,R_Acc(:,2),'b','LineWidth',1.5); %yacc
plot(Time_r,R_Acc(:,3),'g','LineWidth',1.5); %zacc
legend('Force','AccY','AccZ');
title('Right Values');