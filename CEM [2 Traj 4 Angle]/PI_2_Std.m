%% Initialisation

K=10; %number of samples of the set of params
N=20; % sampling time in traj 
h=10; %Elitness Parameter %hyperparameter

teta_new=zeros(N,1);
teta=zeros(K,1);
T=zeros(K,N);
S=zeros(K,N);
P=zeros(K,N);
%% Reference trajectory BiPed
ref_traj=Trefs();
s=size(ref_traj);

%% PDF For Gaussian Distro 
%!! Multivariate distribution instead
%G = makedist('Normal','mu',mu,'sigma',sigma); 
% Sigma standard variation
% mu Mean value
% sigma_PI is the covariance matrix
mu = [0 0 0 0 0];
V= [.25 .3 1 .5 .9]; %initial sigma Covariance
Sigma=diag(V);

%% PI² Algorithm
% Generate K sample of the trajectory
% with different teta vectors

for k=1:K
    teta=mvnrnd(mu,Sigma);
    T(k,:)=exepolicy_Gauss(teta,N);
end
%%%% WORKING Code 
% J needs be evaluated at each time step i
for i=1:N
    for k=1:K
        som=0;
        for m=i:N
            som=som+(J(ref_traj,T(k,:),m));
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
        som=som+P(i,ind)*teta();%TODO
    end
    teta_new(i)=som;
end
Nom=0;
Den=0;
for i=1:N
    Nom=Nom+(N-i)*teta_new(i);
    Den=Den+(N-i);
end
teta_new=Nom/Den;