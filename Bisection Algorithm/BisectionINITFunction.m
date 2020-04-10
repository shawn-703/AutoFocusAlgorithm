function [I1,I2,I3,L1,L2,L3] = BisectionINITFunction(Camera, SerialPort, StepSize, max_step)


    %This function will serve as a calibration step that ONLY RUNS ONCE
  
    NoSteps = 'IG'; %Infinite steps 
    % ---------------------------- Whatch out for the done bit. 
    
    %Move_inf L until A
        UARTTransmit(SerialPort,num2str(StepSize), 'L', NoSteps);   
    %stop when one of the contact switches is ON
    %simple if statement 
                                                            
    %Take I1 and write L1 = 0 
        Image = getsnapshot(Camera); 
        I1 = Image; 
        L1 = 0;

    %Move_inf R until B
        UARTTransmit(SerialPort,num2str(StepSize), 'R', NoSteps);
    %stop when one of the contact switches is ON
    %simple if statement 
                                                            
    %Take I2 and write L2 = max_step 
        Image = getsnapshot(Camera);   
        I2 = Image; 
        L2 = max_step;
                                                          
    NoSteps = max_step/2;
                                                        
        UARTTransmit(SerialPort,num2str(StepSize), 'L', NoSteps);                                                        
    %Take I3 and write L3 = max_step/2
        Image = getsnapshot(Camera);
        I3 = Image;
        L3 = max_step/2;
end
