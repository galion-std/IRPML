%% Initialisation
clc
clear all
close all

K=10; %number of samples of the set of params
N=20; % sampling time in traj 
h=10; %Elitness Parameter %hyperparameter
nbr_iter=100;
nbr_RBS=80;
alfa=0.001;

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

mu= zeros(nbr_RBS,1);
V= rand (1,nbr_RBS);  
Sigma=diag(V);

%% PI� Algorithm
% Generate K sample of the trajectory
% with different teta vectors

for iter=1:nbr_iter

teta=zeros(K,nbr_RBS);
T=zeros(K,s(2));
    if iter ~=1
        mu=mu_new;
    end
%% sampling 
T=zeros(K,s(2));
teta=zeros(K,nbr_RBS);
for k=1:K 
    teta(k,:)=mvnrnd(mu,Sigma);
    T(k,:)=exepolicy_RBF(teta(k,:),ref_traj(RL_q_ref,:,:),s(2),alfa);
end
%%%% WORKING Code 
% J needs be evaluated at each time step i

%%  Updating the parameters
teta_new=zeros(s(2),1);


P=zeros(K,s(2));
S=zeros(K,s(2));

for i=1:s(2)
    for k=1:K
        som=0;
        for m=i:s(2)
            som=som+(J(ref_traj(RL_q_ref,:,:),T(k,:),m));
        end
        %S(i,k)=sum(J(T(k,:),i:N));%%TODO Works it?
        S(i,k)=som;
        if k==1
            alpha=1; % TODO
        else
        alpha = -h*(S(i,k)-min(S(i,:)))/...
               max(S(i,:))-min(S(i,:));
        end
        som=0;
        for ind=1:K
            som=som+exp(alpha*S(i,ind));
        end
        P(i,k)=exp(alpha*S(i,k))/som;
    end
    som=0;
    for ind=1:K
         som=som+P(i,ind)*teta(ind);
    end
    teta_new(i)=som;
end
Nom=0;
Den=0;
for i=1:s(2)
    Nom=Nom+(N-i)*teta_new(i);
    Den=Den+(N-i);
end
mu_new=Nom/Den;

end

