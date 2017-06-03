function [ traj ] = exepolicy_RBF( w,ref,traj_step,alpha )
%this function calculate the approximator
% the policy function with learning parameters

% M normalized basis function      
Den=zeros(traj_step,1);
traj=zeros(traj_step,1);
s=size(w);

t_center=traj_step/s(2);
%keyboard
for t=1:traj_step
    Den(t)=0;
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
%% Centering
% keyboard
cen=zeros(1,traj_step);
z=size(ref);
if z(3)==2
 for t=1:traj_step
cen(t)=ref(1,t,1)+ref(1,t,2); 
cen(t)=cen(t)*0.5;
 end
for t=1:traj_step
    traj(t)=traj(t)+(cen(t));
end
else 
    for t=1:traj_step
    traj(t)=traj(t)+ref(t);
    end
end
%keyboard

end

