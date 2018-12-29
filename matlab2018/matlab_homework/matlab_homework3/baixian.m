function baixian
t=0:pi/100:2*pi;
a=20;b=2;
x=(a+b)*cos(t)-b*cos((a+b)*t/b);
y=(a+b)*sin(t)-b*sin((a+b)*t/b);
h=plot(x,y);
hold on;
axis equal;
N=length(t);
hp = plot(x(1),y(1),'marker','o','markersize',10,'markerfacecolor','r');
for k=1:N
    set(hp,'xdata',x(k),'ydata',y(k));
%drawnow
    pause(0.05)

F = getframe;
im = frame2im(F);
[I,map] = rgb2ind(im,256); %Gif,???256?
%?? GIF89a ????
if k == 1
imwrite(I,map,'test.gif','GIF', 'Loopcount',inf,'DelayTime',0.1);
else
imwrite(I,map,'test.gif','GIF','WriteMode','append',...
'DelayTime',0.1);
end
end