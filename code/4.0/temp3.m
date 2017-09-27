rank = zeros(400,1);
%siMatrix = zeros(400,100);
%temprank = zeros(4,1);
trv = 1;
rv = 1;
rv1 = 1;
thres = 5;
for count = 1:100
    for count2 = 1:2:8
        [sortedValues,sortIndex] = sort(siMatrix(rv,1:100),'descend');
        te = find(sortedValues==siMatrix(rv,count));
        rank(rv) = te(1);
        rv = rv+1;
        %temprank(trv) = te(1);
        %trv = trv+1;
    end
        %rank(rv) = min(temprank);
        %rv = rv + 1;
        %trv = 1;
end
%[prv,hvv] = createhrprg(siMatrix,thres);
r = hist(rank,1:100);
r = cumsum(r);
r = r*100/100;
plot([1:100],r);