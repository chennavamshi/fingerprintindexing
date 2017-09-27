function Htable = createhashtable(ang,tsign,id,Hashtable)
%Htable = zeros(8,180,180);
[sizex,sizey] = size(ang);
for i = 1:sizex
    Htable(tsign(i),ang(i,1),ang(i,2)) = id;
end
end