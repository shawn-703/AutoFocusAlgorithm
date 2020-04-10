function varargout = GUI_Figure(varargin)
% Last Modified by GUIDE v2.5 10-Mar-2020 18:23:51
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Figure_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Figure_OutputFcn, ...
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


% --- Executes just before GUI_Figure is made visible.
function GUI_Figure_OpeningFcn(hObject, eventdata, handles, varargin)

%Variables 
    handles.MotorForwardEnable=0; % initialisation of the boolean motor infinte movement
    handles.MotorBackEnable=0; % initialisation of the boolean motor infinte movement
    
%UART Test and initialisation
    handles.SerialPort = UARTInitialisation;

%Camera Configuration
    %Choose default command line output for GUI_Figure
    handles.output = hObject;
    axes(handles.axes1);
    handles.Camera = videoinput('winvideo',2); %3
    %hh=imshow(getsnapshot(handles.Camera),[]);
    himage=image(getsnapshot(handles.Camera),"parent",handles.axes1);%'MJPG_1024x768'
    preview(handles.Camera,himage);

guidata(hObject, handles);  % Update handles structure


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Figure_OutputFcn(hObject, eventdata, handles) 

    % Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on button press in TakePhotopushbutton.
function TakePhotopushbutton_Callback(hObject, eventdata, handles)
    image = getsnapshot(handles.Camera);
    figure;
    imshow(image);

%baseFileName = 'image.jpg'; % Whatever....
%fullFileName = fullfile(someFolder(address), baseFileName);
%imwrite(rgbImage, fullFileName);


% --- Executes on button press in FocusButton.
function FocusButton_Callback(hObject, eventdata, handles)
%InitialisationData = Initialisation(handles.SerialPort, handles.Camera);

    %focus(handles.Camera,handles.SerialPort);
    if(handles.Algorithim == 1)
        %LinearAlgorithim(handles.Camera, handles.SerialPort, handles.Speed); 
        msgbox('Not Available yet');
    elseif(handles.Algorithim == 2)
        BisectionAlgorithm(handles.Camera, handles.SerialPort, handles.StepSize);
    end
    
% --- Executes on button press in ShowImagespushbutton.
function ShowImagespushbutton_Callback(hObject, eventdata, handles)


% --- Executes on button press in MotorForward.
function MotorForward_Callback(hObject, eventdata, handles)
    if(handles.MotorForwardEnable == 0)
        UARTTransmit(handles.SerialPort,handles.StepSize, 'L', 'IG')
        handles.MotorForwardEnable = 1;
    elseif(handles.MotorForwardEnable == 1)
        UARTTransmit(handles.SerialPort,handles.StepSize, 'L', 'IS')
        handles.MotorForwardEnable = 0;
    end
guidata(hObject, handles);  % Update handles structure


% --- Executes on button press in MotorBackButton.
function MotorBackButton_Callback(hObject, eventdata, handles)
    if(handles.MotorBackEnable == 0)
        UARTTransmit(handles.SerialPort,handles.StepSize, 'R', 'IG')
        handles.MotorBackEnable = 1;
    elseif(handles.MotorBackEnable == 1)
        UARTTransmit(handles.SerialPort,handles.StepSize, 'R', 'IS')
        handles.MotorBackEnable = 0;
    end
guidata(hObject, handles);  % Update handles structure


% --- Executes during object creation, after setting all properties.
function StepSizeMenu_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    handles.StepSize = 1;
    StepSize = 1;
    
    assignin('base','StepSize',StepSize);  
    guidata(hObject, handles);  % Update handles structure

    
% --- Executes on selection change in StepSizeMenu.
function StepSizeMenu_Callback(hObject, eventdata, handles)
    contents = cellstr(get(hObject,'String'));
    StepChoice = contents{get(hObject,'Value')};
    if (strcmp(StepChoice,'Full Step'))
        handles.StepSize = 1;
        StepSize = 1;
    elseif (strcmp(StepChoice,'Half Step'))
        handles.StepSize = 2;
        StepSize = 2;
    elseif (strcmp(StepChoice,'Quarter Step'))
        handles.StepSize = 4;
        StepSize = 4;
    elseif (strcmp(StepChoice,'Eight Step'))
        handles.StepSize = 8;
        StepSize = 8;
    end
    assignin('base','StepSize',StepSize);   
guidata(hObject, handles);  % Update handles structure


% --- Executes on button press in DisconnectButton.
function DisconnectButton_Callback(hObject, eventdata, handles)
    fclose(instrfind)
    close GUI_Figure
    clear all
    close all
    clc


% --- Executes on selection change in SpeedSelection.
function SpeedSelection_Callback(hObject, eventdata, handles)
% hObject    handle to SpeedSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SpeedSelection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SpeedSelection

contents = cellstr(get(hObject,'String'));
   SpeedChoice = contents{get(hObject,'Value')};
    if (strcmp(SpeedChoice,'Coarse'))
        handles.Speed = 1;
        Speed = 1;
    elseif (strcmp(SpeedChoice,'Fine'))
        handles.Speed = 2;
        Speed = 2;
    end
    assignin('base','Speed',Speed);   
guidata(hObject, handles);  % Update handles structure

% --- Executes during object creation, after setting all properties.
function SpeedSelection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpeedSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.Speed = 1;
    Speed = 1;
    
    assignin('base','Speed',Speed);  
    guidata(hObject, handles);  % Update handles structure


% --- Executes on selection change in AlgorithimType.
function AlgorithimType_Callback(hObject, eventdata, handles)
% hObject    handle to AlgorithimType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AlgorithimType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AlgorithimType

contents = cellstr(get(hObject,'String'));
    AlgorithimChoice = contents{get(hObject,'Value')};
    if (strcmp(AlgorithimChoice,'Linear Algorithim'))
        handles.Algorithim = 1;
        Algorithim = 1;
    elseif (strcmp(AlgorithimChoice,'Bi-Section Algorithim'))
        handles.Algorithim = 2;
        Algorithim = 2;
    end
    assignin('base','Algorithim',Algorithim);   
guidata(hObject, handles);  % Update handles structure


% --- Executes during object creation, after setting all properties.
function AlgorithimType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AlgorithimType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.Algorithim = 1;
Algorithim = 1;
    
assignin('base','Algorithim',Algorithim);  
guidata(hObject, handles);  % Update handles structure
