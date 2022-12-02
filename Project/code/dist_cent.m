function [cents, centdist] = dist_cent(no_dist, cd, cood, pop)
cents = zeros(no_dist, 2);
centdist = zeros(size(cd,1), no_dist);
for i = 1:no_dist
    dc = cood(cd==i,:);
    peep = pop(cd==i,:);
    cents(i,:) = sum(peep.*dc)/sum(peep);
end

for i = 1: no_dist
    centdist(:,i) = sum((cood-cents(i,:)).^2,2);
end


