function [ traj ] = exepolicy_Gauss( w,traj_step )
%EXECUTEPOLICY2 RBF generating sampled trajectories with teta_i weights
%   T=F(teta_i=w_i) where T is trajectories of end effector or
%  joint angle coordinates tajectories 
%  Learning Parameters are the teta_i 

%% Parameters Definition
% Location\ Mean
c=1:4:1000;
% Scale\ standard deviation
sigma=5*ones(1000,1);

%% Trajectory approximation
%init 
traj=zeros(traj_step,1);
for t_step=1:traj_step
for gFcn=1:size(w)
   
    Normalisation=sqrt(2*pi)*sigma(gFcn);
    
traj(t_step)=traj(t_step)+(w(gFcn)/Normalisation)...
     *exp(-(t_step-c(gFcn))^2/2*sigma(gFcn)^2);
end
end

