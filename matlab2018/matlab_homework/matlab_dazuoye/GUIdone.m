function varargout = GUIdone(varargin)
% GUIDONE MATLAB code for GUIdone.fig
%      GUIDONE, by itself, creates a new GUIDONE or raises the existing
%      singleton*.
%
%      H = GUIDONE returns the handle to a new GUIDONE or the handle to
%      the existing singleton*.
%
%      GUIDONE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDONE.M with the given input arguments.
%
%      GUIDONE('Property','Value',...) creates a new GUIDONE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIdone_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIdone_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIdone

% Last Modified by GUIDE v2.5 20-Jul-2018 11:50:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIdone_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIdone_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUIdone is made visible.
function GUIdone_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIdone (see VARARGIN)


set(hObject,'Name','GUIdone_cluster');
hzhouqi=findobj(hObject,'Tag','liebiao');
set(hzhouqi,'Value',1);



%handles.square
%handles.angle
%handles.stw
%handles.trap
 t=[0:0.05:10];
% plot(t,sin(t));
handles.current_data=sin(t);


 surf(membrane);


% axes(handles.zuobiao);

% set(handles.zuobiao,'XMinorTick','on')
% grid on;
% %  style value::
% 0:membrane
% 1:square;  2: angle ; 3: stw; 4:trap;
% %

h1=findobj(hObject,'Tag','shifou');
set(h1,'Value',0);
set(handles.yes,'Value',0);
set(handles.edit5,'String','0.1');
handles.prev=0;
handles.prev_hold=0;
%ui menu


hls=uimenu(hObject,'Label','&About');

uimenu(hls,'Label','&Name','Callback','disp(''the name of the writer is Leihai Nie.'')');
uimenu(hls,'Label','&Xuehao','Callback','disp(''the xuehao is PB160803777.'')');

 hoption=uimenu(hObject,'Label','&Option');
 
 uimenu()
    hgon=uimenu(hoption,'Label','&Grig on','Callback','grid on');
    hgoff=uimenu(hoption,'Label','&Grig off','Callback','grid off');
    hbon=uimenu(hoption,'Label','&Box on','separator','on','Callback','box on');
    hboff=uimenu(hoption,'Label','&Box off','Callback','box off');
    hfigcor=uimenu(hoption,'Label','&Figure Color','Separator','on');
    uimenu(hfigcor,'Label','&Red','Accelerator','r','Callback','set(gcf,''Color'',''r'');');
    uimenu(hfigcor,'Label','&Blue','Accelerator','b','Callback','set(gcf,''Color'',''b'');');
    uimenu(hfigcor,'Label','&Yellow','Callback','set(gcf,''Color'',''y'');');     
    uimenu(hfigcor,'Label','&White','Callback','set(gcf,''Color'',''w'');');
    uimenu(hfigcor,'Label','&Black','Callback','set(gcf,''Color'',''k'')');
uimenu(hObject,'Label','&Quit','Callback','close(gcf)');


hcolor = uicontrol(hObject,'style', 'popupmenu', ...
	'string', 'default|hsv|hot|cool|winter|rand(64,3)', ...
	'position', [400, 50, 60, 20],'Tag','Colormap');
set(hcolor,'Callback',@hcool);
% Choose default command line output for GUIdone
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUIdone wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function hcool(src,event)
hcool=findobj(gcf,'Tag','Colormap');
switch get(hcool,'Value')   
    case 1
        colormap default;
    case 2
        colormap(hsv);
    case 3
        colormap(hot);
    case 4
        colormap(cool);
    case 5
        colormap(winter);
    case 6
        colormap(rand(64,3));
    otherwise
        disp('it''s Null.');
end

% function plotplot(src,event)
% str_2=get(findobj(gcf,'Tag','edit1'),'String');
% f0=str2double(str_2);
% str_3=get(findobj(gcf,'Tag','edit2'),'String');
% w=str2double(str_3);
% str_4=get(findobj(gcf,'Tag','edit3'),'String');
% fs=str2double(str_4);
% str_5=get(findobj(gcf,'Tag','edit4'),'String');
% k=str2double(str_5);
% is=get(findobj(gcf,'Tag','shifou'),'Value');
% 

% --- Outputs from this function are returned to the command line.
function varargout = GUIdone_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
input =str2double(get(hObject,'String'));
if(isempty(input))
    set(hObject,'string','300');
else
    if ~(input>0)
%         set(hobject,'string','0');
        disp('F0 is wrong.');
        disp('please input again.');
        set(hObject,'string','300');
    end
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string','300');


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
input =str2double(get(hObject,'String'));
if(isempty(input))
    set(hObject,'string','0.5');
else
    if ~(input>=0 && input <=1)
%         set(hobject,'string','0');
        disp('zhankongbi is wrong.');
        disp('please input again.');
        set(hObject,'string','0.5');
    end
end

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string','0.5');


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
input =str2double(get(hObject,'String'));
edit_1=findobj(gcf,'Tag','edit1');
input_f0=str2double(get(edit_1,'String'));
if(isempty(input))
    set(hObject,'string','8000');
else
    if ~(input>0&&input>2*input_f0&&input>=1000&&input<=30000)
%         set(hobject,'string','0');
        disp('fs is wrong.');
        disp('please input again.');
        set(hObject,'string','8000');
    end
end

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string','8000');


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
input =str2double(get(hObject,'String'));
if(isempty(input))
    set(hObject,'string','50');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'string','50');
guidata(hObject,handles);
% data.push_id=0;
% set(hObject,'UserData',data.push_id);


% --- Executes on button press in shifou.
function shifou_Callback(hObject, eventdata, handles)
% hObject    handle to shifou (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if(handles.prev==1&&val==1)
    val=0;
end
set(hObject,'Value',val);
handles.prev=val;
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle state of shifou


% --------------------------------------------------------------------
function shiyu_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to shiyu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function hecheng_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to hecheng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in liebiao.
function liebiao_Callback(hObject, eventdata, handles)
% hObject    handle to liebiao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns liebiao contents as cell array
%        contents{get(hObject,'Value')} returns selected item from liebiao
%str=get(hObject,'String');
% val=get(hObject,'Value');
% handles.style=val;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function liebiao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to liebiao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bofang.
function bofang_Callback(hObject, eventdata, handles)
% hObject    handle to bofang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(handles.shifou,'Value');
if(val==0)
sound(handles.current_data);
% else
%     k=str2double(get(handles.edit4,'String'));
%     for n =1 :k
%         sound(handles.current_data)
%         pause(0.1);
%     end
end
guidata(hObject,handles);

% --- Executes on button press in guanbi.
function guanbi_Callback(hObject, eventdata, handles)
% hObject    handle to guanbi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound
close

disp('the project is closed. Thank you.');
return
% --------------------------------------------------------------------
%%function meanu1_Callback(hObject, eventdata, handles)
% hObject    handle to meanu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in huatu.
function huatu_Callback(hObject, eventdata, handles)
% hObject    handle to huatu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f0=str2double(get(handles.edit1,'String'));
w=str2double(get(handles.edit2,'String'));
fs=str2double(get(handles.edit3,'String'));
T0=1/f0;
Ts=1/fs;

t1=[T0-w*T0+Ts:Ts:T0-Ts];
t0=[0:Ts:T0-w*T0];
% for k=1:3
%     t=[t,t0,t1];
% end
axes(handles.zuobiao);
val=get(handles.liebiao,'Value');
switch val
    case 1
            
            sig1=[zeros(1,length(t0)),ones(1,length(t1))];
            sig=repmat(sig1,1,3);
%             t=ones(1,length(sig));
            t=[t0,t1];
            for k=2:3
                t=[t,(k-1)*T0+t0,(k-1)*T0+t1]; 
            end
            plot(t,sig);
            
            
    case 2
           
            t00=[T0-w*T0+Ts:Ts:T0-w*T0/2];
            t01=[T0-w*T0/2+Ts:Ts:T0-Ts];
            A0=(t00-T0+w*T0)/(w*T0/2);
            A1=(T0-t01)/(w*T0/2);
            sig1=[zeros(1,length(t0)),A0,A1];
            sig=repmat(sig1,1,3);
            t=[t0,t00,t01];
            for k=2:3
               t=[t,(k-1)*T0+[t0,t00,t01]]; 
            end
%             t=ones(1,length(sig));
            plot(t,sig);
           
    case 3
           
            A=(t1-(T0-w*T0))/(w*T0);
            sig1=[zeros(1,length(t0)),A];
            sig=repmat(sig1,1,3);
            t=[t0,t1];
            for k=2:3
                t=[t,(k-1)*T0+[t0,t1]]; 
            end
%             t=ones(1,length(sig));
            plot(t,sig);
    case 4
          
            t00=[T0-w*T0+Ts:Ts:T0-w*T0/2];
            t01=[T0-w*T0/2+Ts:Ts:T0-Ts];
            A0=(t00-T0+w*T0)/(w*T0/2);
         %   A1=(T0-t01)/(w*T0/2);
            sig1=[zeros(1,length(t0)),A0,ones(1,length(t01))];
            sig=repmat(sig1,1,3);
            t=[t0,t00,t01];
            for k=2:3
                t=[t,(k-1)*T0+[t0,t00,t01]]; 
            end
%             t=ones(1,length(sig));
            plot(t,sig);
    otherwise
            disp('it''s dumped.');
end
 handles.current_data=sig; 
set(handles.zuobiao,'XMinorTick','on');
grid on;
guidata(hObject,handles);




% --- Executes on button press in chonggou.
function chonggou_Callback(hObject, eventdata, handles)
% hObject    handle to chonggou (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

f0=str2double(get(handles.edit1,'String'));
w=str2double(get(handles.edit2,'String'));
fs=str2double(get(handles.edit3,'String'));
T0=1/f0;
Ts=1/fs;
% t1=[T0-w*T0+Ts:Ts:T0-Ts];
% t0=[0:Ts:T0-w*T0];
t=0:Ts:3*T0;
x=zeros(1,length(t));

k=str2double(get(handles.edit4,'String'));
sec=str2double(get(handles.edit5,'String'));
val=get(handles.liebiao,'Value');
axes(handles.zuobiao);
c=1-w;
d=1-w/2;
a=zeros(1,length(k));
b=a;
is_not=get(handles.shifou,'value');

if(is_not==0)
  switch val
    case 1
            for m=1:k
            a(m)=(-1)/(m*pi)*sin(2*m*pi*(1-w));
            b(m)=(-1)/(m*pi)*(1-cos(2*m*pi*(1-w)));
            x=x+a(m)*cos(2*m*pi/T0*t)+b(m)*sin(2*m*pi/T0*t);
            end
           sig=x+w;
    case 2          
            
            for m=1:k
                a(m)=2/(m*m*w*pi*pi)*(1-cos(m*w*pi));
                x=x+a(m)*cos(2*m*pi/T0*(t-d*T0));
            end
            sig =x+w/2;             
    case 3
            for m=1:k
                a(m)=1/(2*m*m*pi*pi*w)*(1-cos(2*m*pi*(1-w)));
                b(m)=(-1)/(m*pi)+(-1)/(2*m*m*pi*pi*w)*sin(2*m*pi*(1-w));
                x=x+a(m)*cos(2*m*pi/T0*t)+b(m)*sin(2*m*pi/T0*t);
            end
          sig=x+w/2;       
    case 4           
          for m=1:k
              a(m)=1/(m*m*w*pi*pi)*(cos(2*m*d*pi)-cos(2*m*c*pi));
              b(m)=1/(m*pi)*(-1+(sin(2*m*d*pi)-sin(2*m*c*pi))/(m*w*pi));
              x=x+a(m)*cos(2*m*pi/T0*t)+b(m)*sin(2*m*pi/T0*t);
          end
          sig=x+3/4*w;   
    otherwise
        disp('chonggou is wrong.');
  end
            plot(t,sig);          
else
  
    switch val
       case 1        
            for m=1:k
            a(m)=(-1)/(m*pi)*sin(2*m*pi*(1-w));
            b(m)=(-1)/(m*pi)*(1-cos(2*m*pi*(1-w)));
            x=x+a(m)*cos(2*m*pi/T0*t)+b(m)*sin(2*m*pi/T0*t);
            sig=x+w;
            plot(t,sig);
            sound(sig);
            pause(sec);
            end
    case 2  
            for m=1:k
            a(m)=2/(m*m*w*pi*pi)*(1-cos(m*w*pi));
            x=x+a(m)*cos(2*m*pi/T0*(t-d*T0));
            sig =x+w/2;
            plot(t,sig);
            sound(sig);
            pause(sec);
            end
    case 3       
                for m=1:k
                a(m)=1/(2*m*m*pi*pi*w)*(1-cos(2*m*pi*(1-w)));
                b(m)=(-1)/(m*pi)+(-1)/(2*m*m*pi*pi*w)*sin(2*m*pi*(1-w));
                x=x+a(m)*cos(2*m*pi/T0*t)+b(m)*sin(2*m*pi/T0*t);
                sig=x+w/2;  
                plot(t,sig);
                sound(sig);
                pause(sec);
            end
    
    case 4
              for m=1:k
              a(m)=1/(m*m*w*pi*pi)*(cos(2*m*d*pi)-cos(2*m*c*pi));
              b(m)=1/(m*pi)*(-1+(sin(2*m*d*pi)-sin(2*m*c*pi))/(m*w*pi));
              x=x+a(m)*cos(2*m*pi/T0*t)+b(m)*sin(2*m*pi/T0*t);
                sig=x+3/4*w;               
                plot(t,sig);
                sound(sig);
                pause(sec);
            end
    otherwise
        disp('chonggou is wrong.');
    end

end
handles.current_data=sig;
guidata(hObject,handles);


% --- Executes on button press in yes.
function yes_Callback(hObject, eventdata, handles)
% hObject    handle to yes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of yes
val=get(hObject,'Value');
if(handles.prev_hold==1&&val==1)
    val=0;
end
set(hObject,'Value',val);
handles.prev_hold=val;
if(val==1)
    hold on;
else
    hold off;
end
guidata(hObject,handles);



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
input =str2double(get(hObject,'String'));
if(isempty(input))
    set(hObject,'string','0.1');
else
    if ~(input>0)
%         set(hobject,'string','0');
        disp('second is wrong.');
        disp('please input again.');
        set(hObject,'string','0.1');
    end
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','0.1');
guidata(hObject,handles);


% --- Executes on button press in closemusic.
function closemusic_Callback(hObject, eventdata, handles)
% hObject    handle to closemusic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound
