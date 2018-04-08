
%% Be sure to have ind_inv_l and ind_inv_r imported.
%% If not, use Francesca's script to do it.

for k=1:length(ind_inv_l)-1
    Path_Acc_L{k} = [L_Acc(ind_inv_l(k):ind_inv_l(k+1),1), ...
                     L_Acc(ind_inv_l(k):ind_inv_l(k+1),2), ...
                     L_Acc(ind_inv_l(k):ind_inv_l(k+1),3)];
                       
    Path_Force_L{k} = L_Force(ind_inv_l(k):ind_inv_l(k+1));
    Path_Press_L{k} = L_Press(ind_inv_l(k):ind_inv_l(k+1),:);
    Path_Time_L{k} = Time_l(ind_inv_l(k):ind_inv_l(k+1));
end

for k=1:length(ind_inv_r)-1
    Path_Acc_R{k} = [R_Acc(ind_inv_r(k):ind_inv_r(k+1),1), ...
                     R_Acc(ind_inv_r(k):ind_inv_r(k+1),2), ...
                     R_Acc(ind_inv_r(k):ind_inv_r(k+1),3)];
                       
    Path_Force_R{k} = R_Force(ind_inv_r(k):ind_inv_r(k+1));
    Path_Press_R{k} = R_Press(ind_inv_r(k):ind_inv_r(k+1),:);
    Path_Time_R{k} = Time_r(ind_inv_r(k):ind_inv_r(k+1));
end