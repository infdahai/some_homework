function sig = mysawth(A,T1,T2)

%N=5
%matlab ?????

% default:  A=1,T1=0,T2=0.5

if nargin<3 
    T2=0.5;
end
if nargin<2
    T1=0;
end
if nargin<1
    A=1;
end
N=100;
fs=1/(T2-T1)*N;
 t=-0.5:1/fs:1;
 t1=-0.5:1/fs:(T1-1/fs);
 t2=T2:1/fs:1;
 t3=T1:1/fs:T2-1/fs;
%t=T1:1/fs:T2;
w=1/(T2-T1);
disp('Y: default ;  N:  fuliye jishu');
reply =input('Do you want more? Y/N','s');
if isempty(reply)
    reply='Y';
end
if reply=='N'
    disp('you selected No ');
x=zeros(1,length(t3));
%x=zeros(1,length(t));
 for  k=1:1000
  %  x=x+((-1)^(k+1))*sin(k*fs*t3)/(k*pi);
  x=x+((-1)^(k+1))*sin(k*w*t3)/(k)*2;
  %x=x+((-1)^(k+1))*sin(k*fs*t)/(k*pi);
 end
 
 sig=[zeros(1,length(t1)),x*A,zeros(1,length(t2))];
%    sig=x*A;
 plot(t,sig);
 title('this is fuliye jishu action.')
else
    disp('You selected Yes');
    x=(t3-T1)./(T2-T1).*A;
    sig=[zeros(1,length(t1)),x,zeros(1,length(t2))];
    plot(t,sig);
   title('this is default action.');
end




 

