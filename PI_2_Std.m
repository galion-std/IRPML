clc
clear all
close all
tic;
%% Initialisation
K=20; %number of samples of the set of params
N=20; % sampling time in traj 
h=10;%1e+1; %Elitness Parameter %hyperparameter
nbr_iter=5;
nbr_RBS=20;
alfa=1e-5;
%%%% working params 30=iter alfa=1e-7
%% Reference trajectory BiPed
ref_traj=Trefs();
s=size(ref_traj);
RL_q_ref=1;

%% PDF For Gaussian Distro 
%!! Multivariate distribution instead
%G = makedist('Normal','mu',mu,'sigma',sigma); 
% Sigma standard variation
% mu Mean value
% sigma_PI is the covariance matrix

qu=num2str(RL_q_ref);
filename=strcat('PI_Convergence_q_',qu,'.gif');  
mu= zeros(nbr_RBS,1);
V= rand (1,nbr_RBS);  
Sigma=diag(V);%ones(nbr_RBS);%TOTRY

%% PI² Algorithm
% Generate K sample of the trajectory
% with different teta vectors

for iter=1:nbr_iter
    iter
    if iter ~=1
        mu=mu_new;
        Sigma=Sigma_new;
    end
%% Sampling Trajectories
T=zeros(K,s(2));
teta=zeros(K,nbr_RBS);
for k=1:K 
    teta(k,:)=mvnrnd(mu,Sigma);
    T(k,:)=exepolicy_RBF(teta(k,:),ref_traj(RL_q_ref,:,:),s(2),alfa);
end
%% Plotting trajs:
t=1:s(2);
figure(1);
hold off
for i=1:K
    plot(t,T(i,:)); 
    hold on;
end
idx=iter;
frame = getframe(gcf);
im{idx} = frame2im(frame);

%%  Iterations Core
teta_new=zeros(s(2),nbr_RBS);
P=zeros(s(2),K);
S=zeros(s(2),K);
b=1;
for i=1:s(2)
    for k=1:K
%% calculating the cost to go
        % J needs be evaluated at each time step i
        som=0;
        for m=i:s(2)
            som=som+(J2(ref_traj(RL_q_ref,:,:),T(k,:),m));
        end
        %S(i,k)=sum(J(T(k,:),i:N));%%TODO Works it?
        S(i,k)=som;
        
%% calculating probability
        if k==1
              alpha=-h; % TODO -0.001 working
        else
        alpha = -h*(S(i,k)-min(S(i,1:k)))/...
               max(S(i,1:k));%-min(S(i,1:k));
         
       end
        som=0;
        for ind=1:K
            som=som+exp(alpha*S(i,ind));
        end
        P(i,k)=exp(alpha*S(i,k))/som;
        b=b+1;
    end
%% Updating Parameters
     for m=1:nbr_RBS
       som=0;
         for ind=1:K
         som=som+P(i,ind)*teta(ind,m);
         end
       teta_new(i,m)=som;
     end
     %%% Updating the Sigma
     sigma_newi=zeros(s(2),nbr_RBS,nbr_RBS);
     sigma_new=zeros(nbr_RBS);
for k=1:K
    sigma_new=sigma_new + ...
        (P(i,k).*((teta(k,:)'-mu(:)))*... %TOASK
           (teta(k,:)'-mu(:))');
end
sigma_newi(i,:,:)=sigma_new;
end
%% Temporal averaging 
mu_new=zeros(nbr_RBS,1);

for m=1:nbr_RBS
    Nom=0;
    Den=0;
        for i=1:s(2)
            Nom=Nom+(s(2)-i)*teta_new(i,m);
            Den=Den+(s(2)-i);
        end
    mu_new(m)=Nom/Den;
end
      %%%% %%%% %%%

    Nom=0;
    Den=0;
        for i=1:s(2)
            Nom=Nom+(s(2)-i).*sigma_newi(i,:,:);
            Den=Den+(s(2)-i);
        end
    Sigma_new1=Nom/Den;
    Sigma_new=reshape(Sigma_new1,nbr_RBS,nbr_RBS);


end
%% Generating the animated gif of the converging trajectories
for idx=1:nbr_iter
    [A,map] = rgb2ind(im{idx},256);
if idx == 1
    imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
else
    imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);
end
end
%% Plotting learned trajectory
figure
qu=num2str(RL_q_ref);
teta_RL = mvnrnd(mu_new,Sigma); 
T_RL=exepolicy_RBF(teta_RL,ref_traj(RL_q_ref,:,:),s(2),alfa);
plot(T_RL,'+')
hold on
plot(1:s(2),ref_traj(RL_q_ref,:,1),'-') %% TOCHECK 
hold on
plot(1:s(2),ref_traj(RL_q_ref,:,2),'-')
legend('Learned','Reference')
title (strcat('Reference vs Learned',qu))

%% Execution time
time_elapsed=toc
