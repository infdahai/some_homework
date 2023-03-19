function [X,Y]=sports()

%% 
%?????avi?????GIF??
%         ????  https://zhidao.baidu.com/question/66297831.html
close all; clear all;

%??????
t = linspace(0,2.5*pi,40);
fact = 10*sin(t);
fig=figure;
[x,y,z] = peaks;
for k=1:length(fact)
    h = surf(x,y,fact(k)*z);
    axis([-3 3 -3 3 -80 80])
    axis off
    caxis([-90 90])
    %??????
    F = getframe(fig);
    
    %??gif??,???256?
    im = frame2im(F);
    [I,map] = rgb2ind(im,256);
    %?? GIF89a ????    
    if k == 1;
        imwrite(I,map,'test2.gif','GIF', 'Loopcount',inf,'DelayTime',1.5);
    else
        imwrite(I,map,'test2.gif','GIF','WriteMode','append','DelayTime',1.5);
    end    
end

