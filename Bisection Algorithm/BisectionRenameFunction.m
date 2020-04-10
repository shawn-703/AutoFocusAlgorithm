function [L1,L2,L3,I1,I2,I3] = BisectionRenameFunction(Camera,dir,Li,L1,L2,L3,I1,I2,I3)


%Variable Decleration

    if dir == 'L' 
        L1 = L1;    %stays the same
        L2 = L3;    %L2new = L3old           
        L3 = Li;    %L3new = L3 - (move_step)
        
        I1 = I1;
        I2 = I3;
        
    elseif dir == 'R'
        
        L1 = L3;    %L1new = L3old  
        L2 = L2;    %stays the same
        L3 = Li;    %L3new = L3 - (move_step)
        
        I1 = I3;
        I2 = I2;    %stays the same
    end
        %take I3 -- image in the new location 
        Image = getsnapshot(Camera);
        I3 = Image; %new I3 (updated)
end 



  