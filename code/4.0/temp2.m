%rank = zeros(100,1);
siMatrix = zeros(400,100);
%temprank = zeros(4,1);
trv = 1;
rv = 1;
rv1 = 1;
thres = 10;
for count = 1:100
    for count2 = 1:2:8
       % if((count == 32 && count2 == 7)||rv == 55 || rv==107 ||rv==144||rv==150||rv==228||rv==286||rv==304||rv==363||rv==385||rv==388||rv==400)
       %     rv = rv+1;
       %     continue;
       % end
        if((count == 32 && count2 == 7))
            rv = rv+1;
            continue;
        end
       
       filename = strcat('C:\Users\Vamshi\Desktop\Fingerprint\Database\FVC2002\Dbs\DB2_A\',num2str(count),'_',num2str(count2),'.txt');
        [co,n] = getMinutiaDetails(filename);
        ETSU = getExtendedSet(co,n);
        [sizex,sizey] = size(ETSU);
        x= zeros(sizex,3);
        Y= zeros(sizex,3);
        for i = 1:sizex
            x(i,1:3) = co(ETSU(i,1:3),1);
            y(i,1:3) = co(ETSU(i,1:3),2);
        end
        [ang,dist,mval] = triangledetails(x,y);
        tsign = ones(sizex,1);
        hashT= zeros(400,1);
        for i = 1:sizex
            temptsign(1:3) = co(ETSU(i,mval(i,1:3)),4)-1;
            te1 = 2;
            for te = 1:3
                tsign(i) = tsign(i)+temptsign(te)*(2^te1);
                te1 = te1-1;
            end
            ta1 = ang(i,1)+1;
            ta2 = ang(i,2)+1;
            temphashTemplate = zeros(400,1);
            for j1 = -thres:thres
                for j2 = -thres:thres
                    if((ta1+j1)>0 && (ta2+j2)>0 && (ta1+j1)<182 && (ta2+j2)<182)
                    numel = Htable(tsign(i),ta1+j1,ta2+j2,1);
                    if(numel>0)
                             for elem = 1:numel
                             enrd = zeros(3,1);
                             ind = (elem - 1)*4 + 2;
                             enrd(1:3,1) = Htable(tsign(i),ta1+j1,ta2+j2,(ind+1):(ind+3));
                             enrd = int16(enrd');
                             distb = (abs(dist(i,1:3)- enrd));
                             if(sum(distb)<10)
                             temphashTemplate(Htable(tsign(i),ta1+j1,ta2+j2,ind)) = 1;
                             end
                             end
                    end
                    end
                end
            end
            hashT = hashT + (temphashTemplate>0);
        end
        hashT2 = reshape(hashT,4,100);
        hashT2 = hashT2';
        [hashT1,y1] = max(hashT2,[],2);
        siMatrix(rv,:)=hashT1/size(ETSU,1); 
        rv = rv+1;
    end
 end
[prv,hvv] = createhrprg(siMatrix,thres);
