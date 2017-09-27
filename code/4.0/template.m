for count = 32:32
    for count2 = 6:6
%if(count == 32 && count2==7)
%    continue;
%end
f = strcat('C:\Users\Vamshi\Desktop\Fingerprint\Database\FVC2002\Dbs\DB2_A\',num2str(count),'_',num2str(count2),'.txt');
fileID = fopen(f,'r');
formatSpec = '%d';
n = fscanf(fileID,formatSpec,1);
co = zeros(n,4);
for i=1:n
    co(i,1:3) = fscanf(fileID,formatSpec,3);
    temp = fscanf(fileID,'%s',1);
    if (strcmp(temp,'Bifurcation') == 1)
        co(i,4) = 2;
    else
        co(i,4) = 1;
    end
end
%p = textread('C:\Users\Vamshi\Desktop\Fingerprint\Database\FVC2004\Dbs\DB1_A\1_1.txt','%d', 1)
%[p1 q1 r1] = textread('C:\Users\Vamshi\Desktop\Fingerprint\Database\FVC2004\Dbs\DB1_A\1_1.txt','%d', 1)
%file = textread(f, '%s', 'delimiter', '\n','whitespace', '');
%fileID = fopen(f);
%C = textscan(fileID,'%d %d %s');
%fclose(fileID);
%celldisp(C)
TR1 = delaunay(co(1:n,1),co(1:n,2));
%figure,
%triplot(TR1,co(1:n,1),co(1:n,2))
ETS = TR1;
for k = 1:n
  [i,j] = find(TR1==k);
    temp = TR1(i,1:3);
    temp1 = unique(temp);
    temp1 = temp1(temp1~=k);
    temp2 = co(temp1,1:2);
    [sizex] = size(temp2,1);
    if(sizex>=3)
        tempTR = delaunay(temp2);
        ETS = vertcat(ETS,tempTR);
    end
 
end

ETSU = sort(ETS,2);
ETSU = unique(ETSU,'rows');
 sizex = size(ETSU,1);
        x = zeros(sizex,3);
        y = zeros(sizex,3);
        for i = 1:sizex
            x(i,1:3) = co(ETSU(i,1:3),1);
            y(i,1:3) = co(ETSU(i,1:3),2);
        end
        [ang,mval] = triangledetails(x,y);
%figure,
%triplot(ETSU,co(1:n,1),co(1:n,2))
fclose(fileID);
    end
end