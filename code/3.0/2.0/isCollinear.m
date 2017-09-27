function [x,y] = isCollinear(x,y)
sizex = size(x,1);
for i = 1:sizex
    
    if(det([x(i,1) y(i,1) 1;x(i,2) y(i,2) 1;x(i,3) y(i,3) 1]) == 0)
    x(i,:) = [];
    y(i,:) = [];
    end

end

end