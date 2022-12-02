function centdist = distcents2(cents, cood, no_dist)
centdist= zeros(max(size(cood)), no_dist);
for i = 1:no_dist
    centdist(:,i) = sum((cood-cents(i,:)).^2,2);
end