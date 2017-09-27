function [x,y] = isCollinear(x,y)
if(size(x,1)>3);
else
    if(det([x(1,1) y(1,1) 1;x(2,1) y(2,1) 1;x(3,1) y(3,1) 1]) == 0)
        x = [];
        y = [];
    end 
end
end

if(count == 32 && count2 == 7)
            rank(rv) = 10;
            rv = rv+1;
            continue;
        end
        