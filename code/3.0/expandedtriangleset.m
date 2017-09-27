ratio = zeros(100*8,1);
ratioc1 = zeros(100*8,1);
ratioc2 = zeros(100*8,1);

kcount = 1;
for count = 45:45
    for count2 = 1:1
f = strcat('C:\Users\Vamshi\Desktop\Fingerprint\Database\FVC2002\Dbs\DB1_A\',num2str(count),'_',num2str(count2),'.txt');
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
triplot(TR1,co(1:n,1),co(1:n,2))
ETS = TR1;
for k = 1:n
    [i,j] = ind2sub(size(TR1),find(ismember(TR1,k)));
    [l,m]=size(i);
    temp = k;
    for tq = 1:l
        if(j(tq)==1)
            temp(end+1:end+2) = [TR1(i(tq),j(tq)+1),TR1(i(tq),j(tq)+2)];
        else if(j(tq)==2)
            temp(end+1:end+2) = [TR1(i(tq),j(tq)+1),TR1(i(tq),j(tq)-1)];
            else
            temp(end+1:end+2) = [TR1(i(tq),j(tq)-1),TR1(i(tq),j(tq)-2)];
            end
        end
    end
    temp = unique(temp);
    temp1 = co(temp,1:2);
    tempTR = delaunay(temp1);
    ETS = vertcat(ETS,tempTR);
end
ETSU = sort(ETS,2);
ETSU = unique(ETSU,'rows');
figure,
triplot(ETSU,co(1:n,1),co(1:n,2))
fclose(fileID);
[p q] = size(TR1);
[p1,q1] = size(ETSU);
ratio(kcount) = p1;
ratioc1(kcount) = count;
ratioc2(kcount) = count2;
kcount = kcount+1;
    end
end