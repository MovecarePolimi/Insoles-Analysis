
%Normal distribution tests
[h,p, kstat,critval] = lillietest(SimoST.stanceTime)
[h,p, kstat,critval] = lillietest(SimoST.stepTime)
[h,p, kstat,critval] = lillietest(SimoST.GC)
[h,p, kstat,critval] = lillietest(SimoST.DS)
[h,p, kstat,critval] = lillietest(SimoST.nrSteps)


%Normal distribution test (with LOG function)
[h,p, kstat,critval] = lillietest(log(FraDT.stanceTime))
[h,p, kstat,critval] = lillietest(log(FraDT.stepTime))
[h,p, kstat,critval] = lillietest(log(FraDT.GC))
[h,p, kstat,critval] = lillietest(log(FraDT.DS))
[h,p, kstat,critval] = lillietest(log(FraDT.nrSteps))

clear all;

%Non-Parametric Test: Mann-Whitney U-test
[p,h,stats] = ranksum(FraDT.stanceTime, FraDT.stanceTime);
[p,h,stats] = ranksum(FraDT.stepTime, FraDT.stepTime);
[p,h,stats] = ranksum(FraDT.GC, FraDT.GC);
[p,h,stats] = ranksum(FraDT.DS, FraDT.DS);
[p,h,stats] = ranksum(FraDT.nrSteps, FraDT.nrSteps);

% Median and IQ
stanceMedian = median(SimoST.stanceTime);
stepMedian = median(SimoST.stepTime);
GCMedian = median(SimoST.GC);
DSMedian = median(SimoST.DS);
NrStepsMedian = median(SimoST.nrSteps);

clear all;

y = SimoST.nrSteps;
% compute 25th percentile (first quartile)
P(1) = prctile(y,25);

% compute 75th percentile (third quartile)
P(2) = prctile(y,75);

% compute Interquartile Range (IQR)
r = iqr(y)
