function [ res ] = J(Tref, T,coe,ts )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

q(:)=T(:);
w=size(Tref);
% for g=1:w(3)
% qref(:,g)=Tref(1,:,g);
% end
qref(:)=Tref(:);
cou=0;
res=0;
%keyboard
v=size(q);
for m=ts:v(2)
    
    cou=cou+1*(q(m)-qref(m))^2;
    
end
res=(cou); % convexe form 
%res=(sqrt(abs(cou)));
%keyboard
end

