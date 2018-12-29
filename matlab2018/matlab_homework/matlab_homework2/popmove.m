function [Y,N]= popmove(P,X0,N,method)

%define  P :translate matrix X0: intialize  population matrix  N: times
%method=1 :default method =2:???????
% Y:population after N years
% N  
% test the P matrix
disp('now test P .')
flag=0
for i = 1:length(P)
 %   if (abs(sum(P(i,:))-1)>eps)
    if(sum(P(i,:))~=1)
        flag=1;
        break;
    end
end
if flag==1
    disp('P is not good.')
    return;
end
        
        
if nargin <4 
    method=1;
end
if nargin<3
    N=10;
end
if(method==1)
    [Y,N]=method_1(P,X0,N);
elseif method==2
    [Y,N]=method_2(P,X0,N);
end



function [T,N]= method_1(P,X0,N)
    for k=1:N
        X0=P*X0;
    end
    T=X0;
    
function [T,N]=method_2(P,X0,N)
    [V,D]=eig(P);
    x= inv(V)*X0;
    le=length(x);
    T=zeros(length(X0),1);
    for k=1:le
        T=T+D(k,k)^N*x(k)*V(:,k);
    end
    

