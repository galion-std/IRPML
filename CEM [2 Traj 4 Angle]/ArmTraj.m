%% Manipulator robot 5DOF Serial Arm IR 50 P
% 11/10/2016 par Meziani Yeser M2 AII
% Robot arm definition and trajectory geenration using rvc-tools lib.
close all
clc

%% Robot defenition using DHM configuration
% Creating links
% L = Link([theta, dj, aj, alphaj, Sigmaj])
% NB: usually we pass in a zero as placeholder forthe theta variable
% L is a Link object its theta property is set to q joint angle.

% Links definition along
L(1)=Link([0, 0, 0, 0, 0]);
L(2)=Link([0, 0, 0, pi/2, 0]);
L(3)=Link([0, 0, 250, 0, 0]);
L(4)=Link([0, 0, 250, 0, 0]);
%L(5)=Link([0, 0, 0, -pi/2, 0]);

% L is a vector holding all descriptions of the 5 links
% Instantiating the SerialLink object the  composition
% of our predescribed links, which are held in L.

IR50P=SerialLink(L, 'name', 'IR50P');

%% Plotting the robot with the desired pose. 
% !!! Slow method
%using plot method of the IR50P object
%IR50P.plot([0, pi/2, -pi, pi/2, pi/4])


%% Generating Trajectories
% Initial and final poses.

T1 = transl(1, 1.5, 1) * trotx(0)
T2 = transl(1, 1, 1) * trotx(pi/2)

% the correspondent joint space coordinates
q1=IR50P.ikine(T1,[0 0 0 0],[1 1 1 1 0 0])
q2=IR50P.ikine(T2,[0 0 0 0],[1 1 1 1 0 0])

% or using jacobian matrix such as / dX=J*dq

%J_IR50P=IR50P.jacob0(q)

% the time vector underlying the time elapsed between q1 and q2
% a duration of 10 sec with a 500ms step

t=[0:0.5:10]';

[IR50P_q_traj, qd, qdd]= mtraj(@tpoly, q1 ,q2, t);
%qplot(t,IR50P_q_traj)
q=IR50P_q_traj;
plot(t,q(:,1),t,q(:,2),t,q(:,3),t,q(:,4))

% about(IR50P_q_traj)
% about(q1)
% or
% Invoking the traj method of the IR50P object 
%IR50P_q_traj=IR50P.jtraj(T1, T2, t)

% !!!! Unstable : Depending on the q0 vector choice
%plotting the movement from q1 to q2
figure(1)
IR50P.plot(IR50P_q_traj)

%plotting the trajectories in joint space coordinates
figure(2)
plot(t, IR50P_q_traj)

% caluculating the cartesian trajectories using FKM
IR50P_T_traj=IR50P.fkine(IR50P_q_traj)
IR50P_P_traj=transl(IR50P_T_traj)
qplot(t,IR50P_P_traj)
plot(IR50P_P_traj(:,1), IR50P_P_traj(:,2))

p=IR50P_P_traj;
plot(t,p(:,1),t,p(:,2),t,p(:,3))




%%
%%%%%
% Partie Line Drawing
Tp_final;
% Unstable DIVERGE !!!
qp_final=IR50P.ikine(Tp_final,(pi/2).*[1 1 1 1],[1 1 1 1 0 0]);
q0=(pi/2).*[1 1 1 1];
Jac=JacobMLT(q0,20.5,20.5)
eig(Jac(1:4,1:4))
% !!!! Unstable : Depending on the q0 vector choice
%plotting the movement from q1 to q2
figure(1)
IR50P.plot(qp_final)

%plotting the trajectories in joint space coordinates
figure(2)
plot(t, qp_final) 

% caluculating the cartesian trajectories using FKM
IR50P_Tp_traj=IR50P.fkine(qp_final)










