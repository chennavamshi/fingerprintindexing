function [a m d] = triangledetails(x,y);
n = 3;

dist = zeros(n,n);
max = 0;
t1 = [1 2 3];
for i = 1:n
    for j = i:n
          dist(i,j) = int16(sqrt((x(i)-x(j))^2+(y(i)-y(j))^2));
        if(dist(i,j)>=max)
        max = dist(i,j);
        maxij = [i,j];
        end
    end
end
dist = dist + dist';
temp1 = ismember(t1,maxij);
m1 = find(temp1 == 0);
if(dist(m1,maxij(1))>dist(m1,maxij(2)))
    m2 = maxij(2);
    m3 = maxij(1);
else
    m2 = maxij(1);
    m3 = maxij(2);
end
  a1 = acosd((dist(m1,m2)^2+dist(m1,m3)^2-dist(m2,m3)^2)/(2*dist(m1,m2)*dist(m1,m3)));
  a2 = acosd((dist(m1,m2)^2+dist(m2,m3)^2-dist(m1,m3)^2)/(2*dist(m1,m2)*dist(m2,m3)));
  a3 = acosd((dist(m3,m2)^2+dist(m1,m3)^2-dist(m1,m2)^2)/(2*dist(m3,m2)*dist(m1,m3)));
  a = [ a1 a2 a3];
  m = [ m1 m2 m3];
  d = [ dist(m2,m3),dist(m3,m1),dist(m1,m2)];
      
  
 