function [index_PO]=FindPO(AccY)

[PKS,index]= findpeaks(-AccY,'SortStr','descend');
if length(PKS)==0;
    [a,b]=max(-AccY);
    index_PO=b;
else
index_PO=index(1);
end