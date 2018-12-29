%% ezmesh and ezsurf

% R=4;
% r=0:.2:R;

% %[u,v]=meshgrid(gu);
% x=(r.*cos(u)+R).*cos(v);
% y=(r.*cos(u)+R).*sin(v);
% z=r.*sin(u);
% 
%ezmesh(x,y,z)
%ezmesh(x,y,z,[1,1,-1,1])
%figure
%surf(x,y,z);

function emesh(R,r)
 %u=0:pi/10:2*pi;
 %v=0:pi/10:2*pi;
fx=@(u,v) (r.*cos(u)+R).*cos(v);
fy=@(u,v)(r.*cos(u)+R).*sin(v);
fz=@(u,v) r.*sin(u);
ezmesh(fx,fy,fz);

gx=@(u,v) (r.*cos(u)+R).*cos(v)+R;
gy=@(u,v)(r.*cos(u)+R).*sin(v)+R;
gz=@(u,v) r.*sin(u)+R;
hold on
ezsurf(gx,gy,gz);