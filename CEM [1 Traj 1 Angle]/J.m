function [ res ] = J(Tref, T,ts )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

q(:)=T(:);
qref(:)=Tref(:);
cou=0;
res=0;
%keyboard
v=size(q);
for m=ts:v(2)
    cou=cou+(q(m)-qref(m))^2;
end
res=sqrt(cou);
%keyboard
end

