a='nieleihai';
b=char('schoolnumber','matlab','12345');
k=1
C=cell(3,4);
Fs=8000;
time=5;
while(k<=3)
    s=[a '_' deblank(b(k,:)) '_5.wav'];
    disp(s);
    recOBJ = audiorecorder;
    recordblocking(recOBJ,time);
    y=getaudiodata(recOBJ);
	audiowrite(s,y,Fs);
 
    C{k,1}=a;
    C{k,2}=y;
    C{k,3}=Fs;
    C{k,4}=time;
    
    music(k).name=a;
    music(k).sound=y;
    music(k).fs=Fs;
    music(k).time=time;
    k=k+1;
end

for p=1:3
    display(strcat('the Cell_',int2str(p)))
    for q=1:4
        C{p,q}
    end
end
for p=1:3
    display(strcat('the music_',int2str(p)))
    music(p)
end

% save('result.mat',C);
%Cell,struct array can't be saved by using "save"  function
%save('result.mat',music);
save  result.mat C music