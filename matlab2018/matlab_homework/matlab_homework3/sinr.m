gx=-10:0.1:10;

[x,y]=meshgrid(gx);
r=sqrt(x.^2+y.^2);

z=sin(r)./r;
mesh(x,y,z);