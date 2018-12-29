%five angles
theta1=0:0.4*pi:2*pi;
%theta1=0:0.4*pi:1.6*pi;
theta2=0.2*pi:0.4*pi:2*pi;
r=zeros(1,11);
theta=zeros(1,11);
%t = sin(108/180*pi)/sin(36/180*pi);
t=tand(72);
for k =1:5
        theta(2*k-1)=theta1(k);
        theta(2*k)=theta2(k);
        r(2*k-1)=t;
        r(2*k)=1;
% r=[r theta1(k)*sqrt(3) theta2(k)];
end
r(11)=t;
theta(11)=theta1(6);
%plot(r);
x=r.*sin(theta);
y=r.*cos(theta);
plot(x,y,'r');

shg
axis off

