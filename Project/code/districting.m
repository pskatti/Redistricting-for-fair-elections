dist_cnt = 13;
trcts = size(norcar, 1);
w = zeros(trcts, trcts);
k = 200;
sigmax = zeros(trcts,1);

for i = 1:trcts
    row = (norcar(i,4)-norcar(:,4)).^2 + (norcar(i,5)-norcar(:,5)).^2;
    [vals, indxs] = mink(row, k);
    sigmax(i) = median(vals);
    rowtemp = row;
    rowtemp(indxs) = 0;
    dmat = row - rowtemp;
    w(i, :) = dmat./sigmax(i);
end

for j=1:trcts
    
    indx = w(:,j)~=0;
    w(indx,j) = exp(-w(indx,j)./sigmax(j));
    
end

r = diag(sum(w,1));
w = r^-0.5*w*r^-.5;

A = w'*w;    
[centr, centdists] = dist_cent(dist_cnt, cd, [norcar(:,5) norcar(:,4)], norcar(:,3)); % initial centroids

alfa = 1;

E = sum(sum(0.5*u'*A*(1-u) + alfa*u'*centdists/max(max(centdists))));