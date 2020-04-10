function BestDirection = BisectionCompareFunction(F1,F2)

    if(F1 > F2)
        dir = 'L';
    elseif(F1 < F2)
        dir = 'R';
    end
        
    BestDirection = [dir];