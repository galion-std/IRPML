function [ output_args ] = exepolicy_DMP( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%y trajectory
% g is goal
% control policy CP
%ci and sigma i are width and centers
%Learn to extract the wi weights 

N=5; % source: PI Article
dz=alpha_z*(beta_z(g-y)-z);

x_=(x-xo)/(g-xo);

for i=1:N
    ksi(i)=exp(-(x_ - c(i))^2/2*sigma(i)^2);
end

dy=z+((sum(ksi(:).*w(i)))/(sum(ksi(:))))*v;

dv=alpha_v(beta_v(g-x)-v);

dx=v;

end

