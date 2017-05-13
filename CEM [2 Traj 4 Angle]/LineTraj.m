close all
clc
% % ---------------------------
% Meziani Yeser
% M2 AIII November 7th 2016
% Trajectory generation using IGM
% Robot IR50P
% % -------------------------------
%%% defining a cartesian trajectory line drawing

% z=a distance between robot and tab
% x= h height of the drawn line
% y-y0=step where step is  the

t=[0:.05:10]; % 10 sec window of time to perform the movement
z=40*ones(1,201);
x=200*ones(1,201);
y=[-10:0.1:10];
nbrpts=size(y)
plot3(x,y,z)
% creating the matrix defining trajectory
T_line=[x',y',z'];

%% using the Corke method
% via points: line extremities 

% plotting in 3D the trajectory between the two summits
% the last 4 arguments are optional (Formatting)
plot3(path(:,1),path(:,2),path(:,3),'color','g','LineWidth',1)
path =[200 -10 40;200 10 40];
% generating the continuous line between the summits
% Args= [Summits speeds init.coord. sample_t accel_t]
p = mstraj(path, [0.5 0.5 0.3], [], [2 2 2], 0.02, 0.2);
%cartesian poses
Tp=transl(p);
% Tp now holds the trajectory in cartesian poses which we will use to
% generate the corresponding joint configurations.
% multiplies each pose by the intial pose
Tp_final = homtrans( transl(p(1,:)), Tp);






