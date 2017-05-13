function [ J ] = JacobMLT( teta,D3,D4)
% Analytic expression of the IR50P jacobian Matrix
%   Detailed explanation goes here
J(1,1)=-0.5*D4*sin(teta(1)+teta(2)+teta(3))+ ...
    0.5*D4*sin(teta(2)+teta(3)-teta(1))-...
    0.5*D3*sin(teta(1)+teta(2))+...
    0.5*D3*sin(-teta(1)+teta(2));
J(1,2)=-0.5*D4*sin(teta(1)+teta(2)+teta(3))- ...
    0.5*D4*sin(teta(2)+teta(3)-teta(1))-...
    0.5*D3*sin(teta(1)+teta(2))-...
    0.5*D3*sin(-teta(1)+teta(2));
J(1,3)=-0.5*D4*sin(teta(3)+teta(1)+teta(2))-...
    0.5*D4*sin(teta(3)-teta(1)+teta(2));
J(1,4)=0;
J(1,5)=0;
J(2,1)=0.5*D4*cos(teta(3)-teta(1)+teta(2))+...
    0.5*D4*cos(teta(3)+teta(1)+teta(2))+...
    0.5*D3*cos(teta(2)-teta(1))+...
    0.5*D3*cos(teta(1)+teta(2));
J(2,2)=-0.5*D4*cos(teta(3)+teta(2)-teta(1))+...
    0.5*D4*cos(teta(3)+teta(1)+teta(2))-...
    0.5*D3*cos(teta(2)-teta(1))+...
    0.5*D3*cos(teta(1)+teta(2));
J(2,3)=-0.5*D4*cos(teta(3)-teta(1)+teta(2))+...
    0.5*D4*cos(teta(3)+teta(2)+teta(1));
J(2,4)=0;
J(2,5)=0;
J(3,1)=0;
J(3,2)=D4*cos(teta(2)+teta(3))+ D3*cos(teta(2));
J(3,3)=D4*cos(teta(2)+teta(3));
J(3,4)=0;
J(3,5)=0;
J(4,1)=0;
J(4,2)=sin(teta(1));
J(4,3)=sin(teta(1));
J(4,4)=sin(teta(1));
J(4,5)=-0.5*sin(teta(4)+teta(3)+teta(2)-teta(1));
J(5,1)=0;
J(5,2)=-cos(teta(1));
J(5,3)=-cos(teta(1));
J(5,4)=-cos(teta(1));
J(5,5)=0.5*cos(teta(1)+teta(2)+teta(3)+teta(4));
J(6,1)=1;
J(6,2)=0;
J(6,3)=0;
J(6,4)=0;
J(6,5)=cos(teta(2)+teta(3)+teta(4));

end

