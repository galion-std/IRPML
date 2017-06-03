function [ res ] = J(Tref, T,coe,ts )
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
    cou=cou+coe(m)*(q(m)-qref(m,r))^2;
    end
end
res=abs(cou); % convexe form 
%res=(sqrt(abs(cou)));
%keyboard
end

