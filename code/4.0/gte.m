core = 0;
delta = 0;
cd = 0;
for count = 1:100
    for count2 = 1:8
        filename = strcat('C:\Users\Vamshi\Desktop\Fingerprint\Database\FVC2002\Dbs\DB1_A\',num2str(count),'_',num2str(count2),'.txt');
        [c,d] = getMinutiaDetails(filename);
        if(c==0 && d==0)
           cd = cd+1;
        end
        if(c==0)
         core = core+1;
        end
        if(d==0)
                delta = delta +1;
            end
        
    end
end