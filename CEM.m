clc
clear all
close all

%%%%%%%%%%%%%%%%%%%%
% Tuning Params
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbr_RBS=80;        % Radial basis functions
%RL_q_ref=4;       % Reference Joint Number
nbr_iter=50;       % Algorithm iterations count
Ke=10;             % Elitness parameter
K=20;              % Smaples count
alpha=1e-6 ;       % RBF coefficient 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%filename='Convergence.gif';

%% Reference Traj BiPed
Tref=Trefs();
s=size(Tref);
nbr_param=nbr_RBS+s(2);
for RL_q_ref=1:1
%% Initial Trajectories Sampling  Params
qu=num2str(RL_q_ref);
filename=strcat('Convergence_q_',qu,'.gif');  
mu= zeros(nbr_param,1);
V= rand (1,nbr_param);  
Sigma=diag(V);

%% CEM Iterations

for iter=1:nbr_iter
    if iter~=1
        mu=mu_new;
        Sigma=sigma_new;
    end
    teta=zeros(K,nbr_param);
    T=zeros(K,s(2));
     
for k=1:K 
   
    teta(k,:)=mvnrnd(mu,Sigma);
    T(k,:)=exepolicy_RBF(teta(k,1:nbr_RBS),Tref(RL_q_ref,:,:),s(2),alpha);
end
%% Plotting sampled tajectories

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

%% Iterations 
cost=zeros(K,1);
for k=1:K
    cost(k)=log(J(Tref(RL_q_ref,:,:),T(k,:),teta(k,nbr_RBS+1:nbr_param),1));
end

%% sorting and weighing 
p=zeros(K,1);
thresh_hold=1/Ke;
[B,I] = sort(cost);
for i=1:Ke
    p(I(i,1))=thresh_hold;
end

%% Updating mu
mu_new=zeros(nbr_param,1);
for i=1:K
    for m=1:nbr_param
        mu_new(m)=mu_new(m)+p(i)*teta(i,m);
    end
end

%% Updating Sigma
sigma_new=zeros(nbr_param);
for k=1:K
    sigma_new=sigma_new + (p(k).*(teta(k,:)'-mu(:)))*... %TOASK
           (teta(k,:)'-mu(:))';
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

%% Learned distribution
figure
qu=num2str(RL_q_ref);
teta_RL = mvnrnd(mu_new,sigma_new); 
T_RL=exepolicy_RBF(teta_RL(1:nbr_RBS),Tref(RL_q_ref,:,:),s(2),alpha);
plot(T_RL,'+')
hold on
plot(1:s(2),Tref(RL_q_ref,:,1),'-') %% TOCHECK 
hold on
plot(1:s(2),Tref(RL_q_ref,:,2),'-')
legend('Learned','Reference')
title (strcat('Reference vs Learned',qu))
end
%% testing
figure
qu=num2str(RL_q_ref);
teta_RL = mvnrnd(mu_new,sigma_new); 
T_RL=decode_RBF(teta_RL(1:nbr_RBS),s(2),alpha);
plot(T_RL,'+')
hold on
plot(1:s(2),Tref(RL_q_ref,:,1),'-') %% TOCHECK 
hold on
plot(1:s(2),Tref(RL_q_ref,:,2),'-')
legend('Learned','Reference')
title (strcat('Test Reference vs Learned',qu))
figure;
plot(T_RL,'+')

