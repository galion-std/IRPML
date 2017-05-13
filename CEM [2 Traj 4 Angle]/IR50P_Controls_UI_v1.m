function varargout = IR50P_Controls_UI_v1(varargin)
% IR50P_CONTROLS_UI_V1 MATLAB code for IR50P_Controls_UI_v1.fig
%      IR50P_CONTROLS_UI_V1, by itself, creates a new IR50P_CONTROLS_UI_V1 or raises the existing
%      singleton*.
%
%      H = IR50P_CONTROLS_UI_V1 returns the handle to a new IR50P_CONTROLS_UI_V1 or the handle to
%      the existing singleton*.
%
%      IR50P_CONTROLS_UI_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IR50P_CONTROLS_UI_V1.M with the given input arguments.
%
%      IR50P_CONTROLS_UI_V1('Property','Value',...) creates a new IR50P_CONTROLS_UI_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IR50P_Controls_UI_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IR50P_Controls_UI_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IR50P_Controls_UI_v1

% Last Modified by GUIDE v2.5 14-Oct-2016 23:08:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IR50P_Controls_UI_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @IR50P_Controls_UI_v1_OutputFcn, ...
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


% --- Executes just before IR50P_Controls_UI_v1 is made visible.
function IR50P_Controls_UI_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IR50P_Controls_UI_v1 (see VARARGIN)

% Choose default command line output for IR50P_Controls_UI_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IR50P_Controls_UI_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IR50P_Controls_UI_v1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in connect.
function connect_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in disconnect.
function disconnect_Callback(hObject, eventdata, handles)
% hObject    handle to disconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in pre_pos.
function pre_pos_Callback(hObject, eventdata, handles)
% hObject    handle to pre_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pre_pos contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pre_pos


% --- Executes during object creation, after setting all properties.
function pre_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pre_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
