function UARTTransmit(SerialPort, StepSize, Direction, Steps)

%conditioning the data input for protocol
    StepSizeTransmit = ['S' (num2str(StepSize)) '$']; 
    DirectionTransmit = ['D' Direction '$'];
    if(strcmp(Steps,'IG') || strcmp(Steps,'IS'))    %infinite steps  
        StepsTransmit = [Steps '$'];
    else    %Variable steps
        
       %initialise as char
       x = Steps;
       a = '0';
       b = '0';
       c = '0';
       d = '0';
       e = '0';
       
       x = num2str(x);  %extracting the size of array of chars
       sizex = size(x);
       sizex = sizex(2);

       if(sizex == 1)
           a = x(1);

       elseif(sizex == 2)
           a = x(2);
           b = x(1);

       elseif(sizex == 3)
           a = x(3);
           b = x(2);
           c = x(1);

       elseif(sizex == 4)
           a = x(4);
           b = x(3);
           c = x(2);
           d = x(1);

       elseif(sizex == 5)
           a = x(5);
           b = x(4);
           c = x(3);
           d = x(2);
           e = x(1);
       end    
       StepsTransmit = ['M' e d c b a '$']; %fixed 7 char transmission
   end
   %transmit variables
   fwrite(SerialPort,StepSizeTransmit);
   fwrite(SerialPort,DirectionTransmit);
   fwrite(SerialPort,StepsTransmit);
   
%    if(~strcmp(Steps,'IG') || ~strcmp(Steps,'IS'))
%        contin = 0;
%        
%        while contin == 0
%            
%            while SerialPort.BytesAvailable == 0 %test
%            end
%            Recieved = fscanf(SerialPort);
%            if (strcmp((Recieved),'DN$') || strcmp((Recieved),'SE$') || strcmp((Recieved),'SI$'))
%                contin = 1;
%            end
%        end
   end
   
   