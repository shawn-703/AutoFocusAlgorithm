%UART initialisation
function SerialPort = UARTInitialisation()
%Setup of UART
    %obtain com port
        Com = inputdlg('Enter COM Port');
    %config string for com port setting
        ComPort = ['COM' num2str(Com{1})];
    %open com port
        SerialPort = serial(ComPort);
    %Set SerialPort Settings
        set(SerialPort,'BaudRate',9600,'StopBits',1,'FlowControl','none','Parity','none','DataBits',8,'OutputBufferSize',8);
    %Create Buffer Size
        SerialPort.InputBufferSize=3;     
    %Time out
        %SerialPort.TimeOut=60;
    %Serial Terminator
        SerialPort.Terminator = '$';
    %Open SerialPort Object
        fopen(SerialPort);
        
%Testing UART before opening GUI    
    %Write to  SerialPort Object
        fwrite(SerialPort,'OK$');
    %Read the  SerialPort Object
        Recieved = fscanf(SerialPort);
    if (~strcmp((Recieved),'OK$'))
        f = msgbox('UART not Active');
        fclose(instrfind);
        while 1 %trap if not working
        end
    end
    
    
