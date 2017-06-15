clc
clear all
close all
tic;
%% Initialisation
K=30;            %number of samples of the set of params
h=-1;            %Eliteness Parameter %hyperparameter
nbr_iter=5;      %Iteration count
nbr_RBS=10;      %RBS function count
alfa=1e-3;          %RBS Fitting param
learn=1;         %Choice biped/PUMA (1/2)

%% Reference Trajectories
if learn==1
    ref_traj=Trefs();
else 
    PumaTrajsGen;
    ref_traj=permute(q,[3 2 1]);
end
s=size(ref_traj);
RL_q_ref=1;

%% PDF For Gaussian Distro 
qu=num2str(RL_q_ref);
filename=strcat('PI_Convergence_q_',qu,'.gif');
mu= zeros(nbr_RBS,1);
V= rand (1,nbr_RBS);
Sigma=diag(V);

%% PI² Algorithm
% Generate K sample of the trajectory
% with different teta vectors
for z=2%s(3)
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
    T(k,:)=exepolicy_RBF2(teta(k,:),ref_traj(RL_q_ref,:,z),s(2),alfa);
end
%% Plotting trajs:
t=1:s(2);
figure(1);
hold off
for i=1:K
    plot(t,T(i,:)); 
    iteration=num2str(iter);
    title(strcat('Iteration N°',iteration));
    hold on;
end
idx=iter;
frame = getframe(gcf);
im{idx} = frame2im(frame);

%%  Iterations Core
teta_new=zeros(s(2),nbr_RBS);
P=zeros(s(2),K);
S=zeros(s(2),K);

for i=1:s(2)
    for k=1:K
%% calculating the cost to go
        % J needs be evaluated at each time step i
        som=0;
        for m=i:s(2)
            som=som+(J2(ref_traj(RL_q_ref,:,z),T(k,:),m));
        end
        S(i,k)=som;
        
%% calculating probability
        
        som=0;
        for ind=1:K  % for  k:K exp(0)=1 sum(K)norm pr P
            som=som+exp(h*(S(i,ind)-min(S(i,1:K)))/...
               (max(S(i,1:K))-min(S(i,1:K))));
        end
        P(i,k)=exp(h*(S(i,k)-min(S(i,1:K)))/...
           (max(S(i,1:K))-min(S(i,1:K))))/som;

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
            Nom=Nom+(s(2)-i+1)*teta_new(i,m); %% P(s(2)) only 1 !=0
            Den=Den+(s(2)-i+1);
        end
    mu_new(m)=Nom/Den;
end
      %%%% %%%% %%%
 
    Nom=0;
    Den=0;
        for i=1:s(2)
            Nom=Nom+(s(2)-i+1).*sigma_newi(i,:,:);
            Den=Den+(s(2)-i+1);
        end
    Sigma_new1=Nom/Den;
    Sigma_new=reshape(Sigma_new1,nbr_RBS,nbr_RBS);
end
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
teta_RL = mvnrnd(mu_new,Sigma_new); 
T_RL=exepolicy_RBF2(teta_RL,ref_traj(RL_q_ref,:,z),s(2),alfa);
plot(T_RL,'+')
hold on
plot(1:s(2),ref_traj(RL_q_ref,:,1),'-') %% TOCHECK 
hold on
plot(1:s(2),ref_traj(RL_q_ref,:,2),'-')
legend('Learned','Reference')
title (strcat('Reference vs Learned',qu))


%% Execution time
time_elapsed=toc
