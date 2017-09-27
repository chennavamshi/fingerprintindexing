%matchtable = [ 1 1 1 ; 1 1 2; 1 2 1;1 2 2; 2 1 1; 2 1 2; 2 2 1; 2 2 2];
Htable = zeros(8,181,181,100);
for count = 1:100
   for count2 = 1:2:8
f = strcat('C:\Users\Vamshi\Desktop\Fingerprint\Database\FVC2002\Dbs\DB1_A\',num2str(count),'_',num2str(count2),'.txt');
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
TR1 = delaunay(co(1:n,1),co(1:n,2));
ETS = TR1;
for k = 1:n
    [i,j] = find(TR1==k);
    temp = TR1(i,1:3);
    temp1 = unique(temp);
    temp1 = temp1(temp1~=k);
    temp2 = co(temp1,1:2);
    [sizex,sizey] = size(temp2);
    if(sizex>=3)
    tempTR = delaunay(temp2);
    ETS = vertcat(ETS,tempTR);
    end
end
ETSU = sort(ETS,2);
ETSU = unique(ETSU,'rows');
fclose(fileID);
[sizex,sizey] = size(ETSU);
x = zeros(sizex,3);
y = zeros(sizex,3);
for i1 = 1:sizex
    x(i1,1:3) = co(ETSU(i1,1:3),1);
    y(i1,1:3) = co(ETSU(i1,1:3),2);
end
[ang mval dist] = triangledetails(x,y);
tsign = ones(sizex,1);
for i = 1:sizex
    temptsign(1:3) = co(ETSU(i,mval(i,1:3)),4)-1;
    te1 = 2;
    for te = 1:3
        tsign(i) = tsign(i)+temptsign(te)*(2^te1);
        te1 = te1 - 1;
      end
    Htable(tsign(i),ang(i,1)+1,ang(i,2)+1,count) = Htable(tsign(i),ang(i,1)+1,ang(i,2)+1,count)+1;
end
end
end