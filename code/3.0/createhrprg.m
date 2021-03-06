function [prv,hvv] = createhrprg(siMatrix,th)
sizex = size(siMatrix,1);
pr = zeros(sizex,100);
hv =zeros(sizex,100);
count = 1;
for i = 0.01:0.01:1
    pr(:,count) = sum(siMatrix>=i,2);
    for j = 1:sizex
        hv(j,count) = siMatrix(j,floor((j-1)/4)+1)>=i;
    end
    count = count+1;
end 
prv = mean(pr)/sizex*100;
hvv = (sum(hv)/sizex)*100;
figure,
plot(prv,hvv);
title(strcat('Hit Rate Vs Penentration Rate for threshold =',num2str(th)));
xlabel('Penentration Rate')
ylabel('Hit Rate')
end