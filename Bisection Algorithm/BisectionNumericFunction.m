function Numericfn = BisectionNumericFunction(L1,L2,L3, dir,SerialPort,StepSize)
    
    if dir == 'R'             %new location to the right
        Li = ((L2-L3)/2)+L3;
        NoSteps = int16(Li-L3);   %declaring the bisect interval -- this updates for every interation  
        
        %Move Motor Function
        UARTTransmit(SerialPort,num2str(StepSize), 'R', NoSteps);
        
	elseif dir == 'L'         %new location to the left 
        Li = ((L3-L1)/2)+L1;
        NoSteps = int16(L3-Li);   %declaring the bisect interval -- this updates for every interation  
        
        %Move Motor Function
        UARTTransmit(SerialPort,num2str(StepSize), 'L', NoSteps);
    end 
        Numericfn = [Li]; %Li = new location
end
