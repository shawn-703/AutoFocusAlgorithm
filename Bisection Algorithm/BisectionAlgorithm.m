function BisectionAlgorithm(Camera, SerialPort, StepSize)

        %speed can be added in same way as fine and coarse from linear algo

%Variable Declaration  
%     StepSize = 1;                           %comment when testing with camera
%     SerialPort = 1;                         %comment when testing with camera
%     Camera = videoinput('winvideo',1);      %comment when testing with camera
            
%   flag = 0;       %for Fine mode to run ROI once                       
    n = 1;          %number of iterations initialization (for ROI function)
    k = 1;          %number of iterations initialization (for algo)
    maxklength = 5; %number of algorithm iterations
    
    %Declaring max steps
    if(StepSize == 1) 
            max_step = 7750;     %for full step
    elseif(StepSize == 2)
            max_step = 15500;    %for half step
    elseif(StepSize == 4)
            max_step = 31000;    %for quarter step
	elseif(StepSize == 8)
            max_step = 62000;    %for eighth step
    end
            
    %INIT Function -- run once (Camera finishes in L3 = middle)
        [I1,I2,I3,L1,L2,L3] = BisectionINITFunction(Camera,SerialPort, StepSize, max_step);
    
    while (k <= maxklength)
    
    %ROI Function
        [R3,n] = BisectionROIFunction(I3,n);    
        [R1,n] = BisectionROIFunction(I1,n);                                                
        [R2,n] = BisectionROIFunction(I2,n);
            
    %Metric Function 
        F1 = BisectionMetricFunciton(R1); %store metric value 
        F2 = BisectionMetricFunciton(R2); %store metric value 
        F3 = BisectionMetricFunciton(R3); %store metric value 
               
    %Compare Function
        dir =  BisectionCompareFunction(F1,F2);
            
    %Stop Function 
        %if right contact switch is ON & dir = 'R'
        %k = 2*(maxklength); %stop iterations
        %elseif left contact switch is ON & dir = 'L'
        %k = 2*(maxklength); %stop iterations
        %end

        if (k <= maxklength)

        %Numeric Method Function
            Li = BisectionNumericFunction(L1,L2,L3,dir,SerialPort,StepSize);

        %Rename Function
            [L1,L2,L3,I1,I2,I3] = BisectionRenameFunction(Camera,dir,Li,L1,L2,L3,I1,I2,I3);
        end
        
            k = k+1;    %repeat
    end
end