function [ res ] = J(Tref, T,coe,nbr_RBS,ts )
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

v=size(q);
%keyboard
for m=ts:v(2)
    
    cou=cou+abs(coe(nbr_RBS+m))*(q(m)-qref(m))^2;
    
end
res=(cou); % convexe form 
%res=(sqrt(abs(cou)));
%keyboard
end

