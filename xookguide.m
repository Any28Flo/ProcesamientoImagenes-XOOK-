function varargout = xookguide(varargin)
% XOOKGUIDE M-file for xookguide.fig
%      XOOKGUIDE, by itself, creates a new XOOKGUIDE or raises the existing
%      singleton*.
%
%      H = XOOKGUIDE returns the handle to a new XOOKGUIDE or the handle to
%      the existing singleton*.
%
%      XOOKGUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XOOKGUIDE.M with the given input arguments.
%
%      XOOKGUIDE('Property','Value',...) creates a new XOOKGUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before xookguide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to xookguide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help xookguide

% Last Modified by GUIDE v2.5 17-May-2016 17:48:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @xookguide_OpeningFcn, ...
                   'gui_OutputFcn',  @xookguide_OutputFcn, ...
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


% --- Executes just before xookguide is made visible.
function xookguide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to xookguide (see VARARGIN)

% Choose default command line output for xookguide
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes xookguide wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = xookguide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen
global carga
[filename,pathname]= uigetfile('*.jpg','Seleccion de una imagen');
if isequal(filename,0) || isequal(pathname,0)
    disp ('Usuario presiono cancel');
    carga=0;
else  
    carga=1;
    disp(['Usuario selecciono',fullfile(pathname,filename)])
    todo=strcat(pathname,filename);
    imagen=imread(todo);
    %set(handles.text1,'String',filename);
    handles.filename=filename;
    imagen=uint8(imagen);%
    Img=image(imagen,'Parent', handles.axes1);
    set(handles.axes1,'Visible', 'off', 'YDir','reverse','Xlim' , get(Img,'XData'), 'YLim',get(Img,('XData')));
    guidata(hObject,handles);
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global captura
captura = videoinput('winvideo', 2, 'RGB24_640x480');
start(captura)
vidRes = get(captura, 'VideoResolution');
imWidth = vidRes(1);
imHeight = vidRes(2);
nBands = get(captura, 'NumberOfBands');
hImage = image( zeros(imHeight, imWidth, nBands),'Parent',handles.axes1 );
preview(captura,hImage);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global captura
global imagen
%global capt1
  imagen = getsnapshot(captura);
  img_r=imresize(imagen,[42 24]);
 imwrite(img_r, 'mul.bmp')
 axes(handles.axes2);
 axis off;
 imshow(imagen);
 handles.output = hObject;
 guidata(hObject, handles);
%  stoppreview(imagen)
%  stop(imagen)

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imagen;

%imshow(imagen);
%title('INPUT IMAGE WITH NOISE')
% Convert to gray scale
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end
% Convert to BW
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);
% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);
%Storage matrix word from image
word=[ ];
re=imagen;
%Opens text.txt as file for write
fid = fopen('text.txt', 'wt');
% Load templates
load templates
global templates
global numero
% Compute the number of letters in template file
num_letras=size(templates,2);
while 1
    %Fcn 'lines' separate lines in text
    [fl re]=lines(re);
    imgn=fl;
    %Uncomment line below to see lines one by one
    %imshow(fl);pause(0.5)    
    %-----------------------------------------------------------------     
    % Label and count connected components
    [L Ne] = bwlabel(imgn);    
    for n=1:Ne
        [r,c] = find(L==n);
        % Extract letter
        n1=imgn(min(r):max(r),min(c):max(c));  
        % Resize letter (same size of template)
        img_r=imresize(n1,[42 24]);
        %Uncomment line below to see letters one by one
         imshow(img_r);pause(0.5)
        %-------------------------------------------------------------------
        % Call fcn to convert image to text
        letter=read_letter(img_r,num_letras);
        % Letter concatenation
        word=[word letter];
        
    end
   
   
    
    fprintf(fid,'%s\n',lower(word));%Write 'word' in text file (lower)
    fprintf(fid,'%s\n',word);%Write 'word' in text file (upper)
    % Clear 'word' variable
    word=[ ];
    %*When the sentences finish, breaks the loop
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end    
end
%fclose(fid);
%Open 'text.txt' file
%winopen('text.txt')
%fprintf('For more information, visit: <a href= "http://www.matpic.com">www.matpic.com </a> \n')
clear all



function text01_Callback(hObject, eventdata, handles)
% hObject    handle to text01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text01 as text
%        str2double(get(hObject,'String')) returns contents of text01 as a double


% --- Executes during object creation, after setting all properties.
function text01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
