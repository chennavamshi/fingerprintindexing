function [co,n] = getMinutiaDetails(filename)
f = strcat(filename);
fileID = fopen(f,'r');
n = fscanf(fileID,'%d',1);
co = zeros(n,4);
for i=1:n
    co(i,1:3) = fscanf(fileID,'%d',3);
    temp = fscanf(fileID,'%s',1);
    if (strcmp(temp,'Bifurcation') == 1)
        co(i,4) = 2;
    else
        co(i,4) = 1;
    end
end
fclose(fileID);
end