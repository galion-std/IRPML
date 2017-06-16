clc
clear all
close all
profile on
%%%%%%%%%%%%%%%%%%%%
% Tuning Params
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nbr_RBS=20;        % Radial basis functions
nbr_iter=100;       % Algorithm iterations count
Ke=5;              % Eliteness parameter
K=20;              % Smaples count
alpha=1;        % RBF coefficient 
learn=2;           % Choice biped/PUMA (1/2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%5,25,5,20,e-4,2
%% Reference Trajectories
if learn==1
    Tref=Trefs();
else 
    PumaTrajsGen;
    Tref=permute(q,[3 2 1]);
end
s=size(Tref);
nbr_param=nbr_RBS+s(2);

for RL_q_ref=1:1
%% Initial Trajectories Sampling Params

qu=num2str(RL_q_ref);
filename=strcat('Convergence_q_',qu,'.gif');  
mu= zeros(nbr_param,1);
V= rand (1,nbr_param);  
Sigma=diag(V);

for RL_q_dem=1:s(3)

    
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
    T(k,:)=exepolicy_RBF(teta(k,:),Tref(RL_q_ref,:,RL_q_dem),s(2),alpha);
end
%% Plotting sampled tajectories

t=1:s(2);
figure(1);
hold off
for i=1:K
    plot(t,T(i,:)); 
    iteration=num2str(iter);
    demo=num2str(RL_q_dem);
    title(strcat('Iteration N°',iteration,', Demo N°',demo));
    hold on;
end
idx=iter+nbr_iter*(-1+RL_q_dem);
frame = getframe(gcf);
im{idx} = frame2im(frame);

%% Iterations 
cost=zeros(K,1);
for k=1:K
    cost(k)=(J(Tref(RL_q_ref,:,RL_q_dem),T(k,:),teta(k,:),nbr_RBS,1));
end

%% sorting and weighting 
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
    sigma_new=sigma_new + (p(k).*(teta(k,:)'-mu(:)))*... 
           (teta(k,:)'-mu(:))';
end
end


end
%% Learned distribution
figure
qu=num2str(RL_q_ref);
teta_RL = mvnrnd(mu_new,sigma_new); 
T_RL=exepolicy_RBF(teta_RL,Tref(RL_q_ref,:,RL_q_dem),s(2),alpha);
plot(T_RL,'+')
for f=1:s(3)
hold on
plot(1:s(2),Tref(RL_q_ref,:,f),'-')  
end
legend('Learned','Reference')
title (strcat('Reference vs Learned',qu))
%% Generating the animated gif of the converging trajectories
for idx=1:nbr_iter*s(3)
    [A,map] = rgb2ind(im{idx},256);
if idx == 1
    imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
else
    imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);
end
end
end
profile off
profile viewer
%% testing
% figure
% qu=num2str(RL_q_ref);
% teta_RL = mvnrnd(mu_new,sigma_new); 
% T_RL=exepolicy_RBF(teta_RL(1:nbr_RBS),s(2),alpha);
% plot(T_RL,'+')
% hold on
% plot(1:s(2),Tref(RL_q_ref,:,1),'-')  
% hold on
% plot(1:s(2),Tref(RL_q_ref,:,2),'-')
% legend('Learned','Reference')
% title (strcat('Test Reference vs Learned',qu))
% figure;
% plot(T_RL,'+')

