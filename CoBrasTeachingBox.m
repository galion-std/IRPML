function varargout = CoBrasTeachingBox(varargin)
% COBRASTEACHINGBOX MATLAB code for CoBrasTeachingBox.fig
%      COBRASTEACHINGBOX, by itself, creates a new COBRASTEACHINGBOX or raises the existing
%      singleton*.
%
%      H = COBRASTEACHINGBOX returns the handle to a new COBRASTEACHINGBOX or the handle to
%      the existing singleton*.
%
%      COBRASTEACHINGBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COBRASTEACHINGBOX.M with the given input arguments.
%
%      COBRASTEACHINGBOX('Property','Value',...) creates a new COBRASTEACHINGBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CoBrasTeachingBox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CoBrasTeachingBox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CoBrasTeachingBox

% Last Modified by GUIDE v2.5 15-May-2017 23:15:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CoBrasTeachingBox_OpeningFcn, ...
                   'gui_OutputFcn',  @CoBrasTeachingBox_OutputFcn, ...
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


% --- Executes just before CoBrasTeachingBox is made visible.
function CoBrasTeachingBox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CoBrasTeachingBox (see VARARGIN)

% Choose default command line output for CoBrasTeachingBox
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = CoBrasTeachingBox_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on slider movement.
function teta1_Callback(hObject, eventdata, handles)
% hObject    handle to teta32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear a s1
global storedPath c1
a=arduino('COM6','Uno')
s1 = servo(a,'D4');
wp(s1,get(hObject,'Value'));
get(hObject,'Value')
storedPath(1,c1)=rp(s1);
c1=c1+1;


% --- Executes during object creation, after setting all properties.
function teta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to teta32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function teta32_Callback(hObject, eventdata, handles)
% hObject    handle to teta32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear a s3 s2
global storedPath  c3  c2
a =arduino('COM6','Uno')
s2 = servo(a,'D5');
s3 = servo(a,'D6');
b=get(hObject,'Value');
wp(s2,b);
wp(s3,180-b);
storedPath(3,c3)=rp(s3);
storedPath(2,c2)=rp(s2);
c3=c3+1;
c2=c2+1;





% --- Executes during object creation, after setting all properties.
function teta32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to teta32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function teta4_Callback(hObject, eventdata, handles)
% hObject    handle to teta6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear a s4
global storedPath c4
a =arduino('COM6','Uno')
s4 = servo(a,'D7');
wp(s4,get(hObject,'Value'));
get(hObject,'Value')
storedPath(4,c4)=rp(s4);
c4=c4+1;


% --- Executes during object creation, after setting all properties.
function teta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to teta6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function teta5_Callback(hObject, eventdata, handles)
% hObject    handle to teta6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear a s5
global storedPath c5
a =arduino('COM6','Uno')
s5 = servo(a,'D8');
wp(s5,get(hObject,'Value'));
get(hObject,'Value')
storedPath(5,c5)=rp(s5);
c5=c5+1;



% --- Executes during object creation, after setting all properties.
function teta5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to teta6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function teta6_Callback(hObject, eventdata, handles)
% hObject    handle to teta6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear a s6
global storedPath c6
a =arduino('COM6','Uno')
s6 = servo(a,'D9');
wp(s6,get(hObject,'Value'));
get(hObject,'Value')
storedPath(6,c6)=rp(s6);
c6=c6+1;



% --- Executes during object creation, after setting all properties.
function teta6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to teta6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function teta7_Callback(hObject, eventdata, handles)
% hObject    handle to teta7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear a s7
global storedPath c7
a =arduino('COM6','Uno')
s7 = servo(a,'D10');
wp(s7,get(hObject,'Value'));
get(hObject,'Value')
storedPath(7,c7)=rp(s7);
c7=c7+1;


% --- Executes during object creation, after setting all properties.
function teta7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to teta7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all
%clear global
clc
%global s1 s2 s3 s4 s5 s6 s7 
global c1 c2 c3 c4 c5 c6 c7 storedPath
c1=1;c2=1;c3=1;c4=1;c5=1;c7=1;c6=1;
storedPath= zeros(7,1000);
a =arduino('COM6','Uno')
% s1 = servo(a,'D4');
% s2 = servo(a,'D5');
% s3 = servo(a,'D6');
% s4 = servo(a,'D7');
% s5 = servo(a,'D8');
% s6 = servo(a,'D9');
% s7 = servo(a,'D10');
