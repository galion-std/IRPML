function [ traj ] = decode_RBF( w,traj_step,alpha )
%this function calculate the approximator
% the policy function with learning parameters

% M normalized basis function      
Den=zeros(traj_step,1);
traj=zeros(traj_step,1);
s=size(w);

%t_center=ceil(traj_step/s(2));
t_center=traj_step/s(2);
%keyboard
for t=1:traj_step
    Den(t)=0;% LOL
    for t_ind=1:t_center:traj_step
     Den(t)=Den(t)+exp(-alpha*(t-t_ind)^2);
    end
    w_ind=1;
    for t_ind=1:t_center:traj_step
        %keyboard
traj(t)= traj(t)+w(w_ind)*exp(-alpha*(t-t_ind)^2)/Den(t);
w_ind=w_ind+1;
    end
end


end

