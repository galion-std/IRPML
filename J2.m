function [ res ] = J2(Tref, T,ts )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

q(:)=T(:);
w=size(Tref);
for g=1:w(3)
qref(:,g)=Tref(1,:,g);
end

cou=0;
res=0;
%keyboard
v=size(q);
for m=ts:v(2)
    for r=1:w(3)
    cou=cou+(q(m)-qref(m,r))^2;
    end
end
res=cou; % convexe form 
res=(sqrt(cou))^2;
%keyboard
end

