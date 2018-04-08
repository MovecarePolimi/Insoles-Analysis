
%% Code to analyze data within "test_call_fra" folder. 

%% Diff time
diffTime = diff(Time);
avgDiffTime = mean(diffTime);
avgHz = 1/(avgDiffTime/1000);
%plot(diffTime);

%% Diff time L
diffTime_l = diff(Time_l);
avgDiffTime_l = mean(diffTime_l);
avgHz_l = 1/(avgDiffTime_l/1000);
%plot(diffTime_l);

%% Diff time R
diffTime_r = diff(Time_r);
avgDiffTime_r = mean(diffTime_r);
avgHz_r = 1/(avgDiffTime_r/1000);
%plot(diffTime);


