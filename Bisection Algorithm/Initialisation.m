function [I1, I2, I3, L1, L2, L3] = Initialisation(SerialPort,Camera)
    
    UARTTransimission(SerialPort,1,'L','IG')
    I1 = getsnapshot(Camera);
    L1 = 0;
    
    UARTTransimission(SerialPort,1,'R','IG')
    I2 = getsnapshot(Camera);
    L2 = 400;
    
    UARTTransimission(SerialPort,1,'L',L2) %Notsure on value
    I3 = getsnapshot(Camera);
    L3 = L2/2;
    