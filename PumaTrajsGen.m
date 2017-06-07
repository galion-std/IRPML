
% upload the puma model
mdl_puma560 
% visualizing the puma p560
p560 
%% Generating Examples
q=zeros(10,382,6);
c = randi([1 4],1,10);
for n=1:10
% define the extremeties of the segment in absolute cartesian units
path = [ 1 0 1; 1 0 0] 
% generate a continuous path 
%mstraj(summits, max_speeds, intialCord,sample interval, acceleration time)
p = mstraj(path, [0.5 0.5 0.3], [], [2 2 2], 0.02, 0.2); 
% corresponding Homogeneous transformation matrices
Tp=transl(0.1*p);
% Placing the origin of the path at (0.4,0,0)
Tp2=homtrans(transl(c(n)/10,0,0),Tp);
% tool facing downward 
p560.tool=trotx(pi);
% generating associated joint angle trajectories
q(n,:,:)=p560.ikine6s(Tp2);
end

%% Graphical Represnetation

% %visualize the resulting path
% figure;
% plot3(path(:,1),path(:,2),path(:,3))
% % animate
% figure;
% p560.plot(q);
% % plot q trajs
% figure;
% qplot(q);


