rank = zeros(400,1);
rv = 1;
for count = 1:100
    for count2 = 1:2:8
        filename = strcat('C:\Users\Vamshi\Desktop\Fingerprint\Database\FVC2002\Dbs\DB1_A\',num2str(count),'_',num2str(count2),'.txt');
        [co,n] = getMinutiaDetails(filename);
        ETSU = getExtendedSet(co,n);
        [sizex,sizey] = size(ETSU);
        for i = 1:sizex
            x(i,1:3) = co(ETSU(i,1:3),1);
            y(i,1:3) = co(ETSU(i,1:3),2);
        end
        [ang,mval] = triangledetails(x,y);
        tsign = ones(sizex,1);
        hashTemplate = zeros(1,1,1,100);
        for i = 1:sizex
            temptsign(1:3) = co(ETSU(i,mval(i,1:3)),4)-1;
            te1 = 2;
            for te = 1:3
                tsign(i) = tsign(i)+temptsign(te)*(2^te1);
                te1 = te1-1;
            end
            ta1 = ang(i,1)+1;
            ta2 = ang(i,2)+1;
            for j1 = -2:2
                for j2 = -1:1
                    if((ta1+j1)>0 && (ta2+j2)>0 && (ta1+j1)<182 && (ta2+j2)<182)
                        hashTemplate = hashTemplate + (Htable(tsign(i),ta1+j1,ta2+j2,:)>0);
                    end
                end
            end
        end
        [sortedValues,sortIndex] = sort(hashTemplate(:),'descend');
        te = find(sortedValues==hashTemplate(1,1,1,count));
        rank(rv) = te(1);
        rv = rv + 1;
    end
end
r = hist(rank,1:100);
r = cumsum(r);
r = r*100/400;
plot([1:100],r);