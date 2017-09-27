for count = 1:100
    for count2 = 1:8
f = strcat('C:\Users\Vamshi\Desktop\Fingerprint\Database\FVC2004\Dbs\DB2_A\',num2str(count),'_',num2str(count2),'.txt');
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
dist = zeros(n,n);
distb = zeros(n,n);
for i = 1:n
    for j = i+1:n
       dist(i,j) = int16(sqrt((co(i,1)-co(j,1))^2+(co(i,2)-co(j,2))^2));
       if(co(j,4) == 2||co(i,4)==2)
           distb(i,j) = dist(i,j);
       end
    end
end
dist = dist + dist';
distb = distb + distb';
rangeval = zeros(n,1);
for i = 1:n
    rangeval(i) = sum(dist(i,:)<60)-1;
end
if(count==1&&count2==1)
    trange = rangeval;
else
    trange = vertcat(trange,rangeval);
end
fclose(fileID);
end
end
[p q] = hist(trange,10);
plot(q,p)