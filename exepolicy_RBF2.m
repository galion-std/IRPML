function [ traj ] = exepolicy_RBF2( w,ref,traj_step,alpha )
%this function calculate the approximator
% the policy function with learning parameters

% M normalized basis function      
Den=zeros(traj_step,1);
traj=zeros(traj_step,1);
s=size(w);
x=ones(1,traj_step);
t_center=traj_step/s(2);
%keyboard
for t=1:traj_step
    Den(t)=0;
    for t_ind=1:t_center:traj_step
     Den(t)=Den(t)+exp(-alpha*(ref(t)-ref(round(t_ind)))^2);
    end
    w_ind=1;
    for t_ind=1:t_center:traj_step
        %keyboard
traj(t)= traj(t)+(w(w_ind))*exp(-alpha*(ref(t)-ref(round(t_ind)))^2)/Den(t);
w_ind=w_ind+1;
    end
end
% %% Centering
% for t=1:t_center:traj_step
% traj(ceil(t))=traj(ceil(t))+ref(ceil(t));
% end

