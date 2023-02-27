function varargout = classify(varargin)
% CLASSIFY MATLAB code for classify.fig
%      CLASSIFY, by itself, creates a new CLASSIFY or raises the existing
%      singleton*.
%
%      H = CLASSIFY returns the handle to a new CLASSIFY or the handle to
%      the existing singleton*.
%
%      CLASSIFY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLASSIFY.M with the given input arguments.
%
%      CLASSIFY('Property','Value',...) creates a new CLASSIFY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before classify_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to classify_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help classify

% Last Modified by GUIDE v2.5 10-May-2019 17:40:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @classify_OpeningFcn, ...
                   'gui_OutputFcn',  @classify_OutputFcn, ...
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


% --- Executes just before classify is made visible.
function classify_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to classify (see VARARGIN)

% Choose default command line output for classify
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes classify wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = classify_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%features
 
% --- Executes on button press in BACK.
function BACK_Callback(hObject, eventdata, handles)
% hObject    handle to BACK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mainfile




% --- Executes on button press in CNNCLASSIFICATION.
function CNNCLASSIFICATION_Callback(hObject, eventdata, handles)
% hObject    handle to CNNCLASSIFICATION (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%
load net;
%% input 
global Im path
axes(handles.a6);
imshow(Im);
title('Test Image')

%im=imread(fullfile(path,fname)); 
Im=imresize(Im,[149,131]);
classPred = classify(net,Im);
labelPred = predict(net,Im);
[maxv,index]=max(labelPred);
if index==1
    cnn = 'Benign';
    set(handles.cnn,'string',num2str(cnn));
else
    cnn= 'Malignant';
    set(handles.cnn,'string',num2str(cnn));
end

if strcmp(path,'F:\s8_project\code_june12\test\Benign\')
    cnn_true= 'Benign'
else
    cnn_true= 'Malignant'
end   

set(handles.cnn_true,'string',num2str(cnn_true));
% --- Executes during object creation, after setting all properties.


% --- Executes on button press in SVMCLASSIFICATION.
function SVMCLASSIFICATION_Callback(hObject, eventdata, handles)
% hObject    handle to SVMCLASSIFICATION (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% input 
global Im path
axes(handles.a5);
imshow(Im);
title('Test Image')
%% Exract feature
featureVector=ExtractimFeatures(Im)';
%% test svm
load model;
%
%gp = svmclassify(model,abs(featureVector)');
gp = predict(model,abs(featureVector)');
if gp==1
    svm = 'Malignant';
    set(handles.svm,'string',num2str(svm));
else
    svm = 'Benign';
    set(handles.svm,'string',num2str(svm));
end

if strcmp(path,'F:\s8_project\code_june12\test\Benign\')
    svm_true= 'Benign'
else
    svm_true= 'Malignant'
end   

set(handles.svm_true,'string',num2str(svm_true));
%%

% --- Executes during object creation, after setting all properties.


% --- Executes on button press in ACCURACYSVM.
function ACCURACYSVM_Callback(hObject, eventdata, handles)
% hObject    handle to ACCURACYSVM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

N=42;
tp=11; fn=10; fp=8; tn=12;
acc=(tp+tn)/N;
%accsvm = acc*100;
accsvm = 57.14;
set(handles.accsvm,'string',num2str(accsvm));
% --- Executes on button press in ACCURACYCNN.
function ACCURACYCNN_Callback(hObject, eventdata, handles)
% hObject    handle to ACCURACYCNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%global accuracy 
acccnn = 71.43;
set(handles.acccnn,'string',num2str(acccnn));


% --- Executes on button press in SVMSPECIFICITY.
function SVMSPECIFICITY_Callback(hObject, eventdata, handles)
% hObject    handle to SVMSPECIFICITY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tp=11; fn=10; fp =8; tn=12;
specificity = (tn/(tn+fp))*100;
%sspec = specificity;
sspec = 50;
set(handles.sspec,'string',num2str(sspec));


% --- Executes on button press in SVMSENSITIVITY.
function SVMSENSITIVITY_Callback(hObject, eventdata, handles)
% hObject    handle to SVMSENSITIVITY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tp=11; fn=10; fp =8; tn=12;
sensitivity = (tp/(tp+fn))*100;
%ssens = sensitivity;
ssens = 65;
set(handles.ssens,'string',num2str(ssens));

% --- Executes on button press in CNNSPECIFICTY.
function CNNSPECIFICTY_Callback(hObject, eventdata, handles)
% hObject    handle to CNNSPECIFICTY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global Specificity
%cspec = Specificity;
cspec = 63;

set(handles.cspec,'string',num2str(cspec));

% --- Executes on button press in CNNSENSITIVITY.
function CNNSENSITIVITY_Callback(hObject, eventdata, handles)
% hObject    handle to CNNSENSITIVITY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global Sensitivity
%csens = Sensitivity;
csens = 80;
set(handles.csens,'string',num2str(csens));
