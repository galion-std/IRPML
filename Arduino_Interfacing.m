clear all
%a=arduino%('COM7','MKR1000');
a = arduino('192.168.137.155','MKR1000',9500)
s = servo(a,'D5')
pos1=readPosition(s)
writePosition(s,1)
pos2=readPosition(s)
pause(2);
writePosition(s,0.5)
pos3=readPosition(s)
pause(2);
writePosition(s,0)
pos4=readPosition(s)
% % %keyboard
% pos=zeros(1,10);
% for i=1:10
%     pos(i)=readPosition(s);
% end