eqmat = zeros(trcts, trcts*dist_cnt);
popmat = zeros(dist_cnt, trcts*dist_cnt);
onesvec= ones(1, trcts);
popl = sum(norcar(:,3));
ub = ceil(popl/dist_cnt)*1.001; lb = ceil(popl/dist_cnt)*0.999; 
%eqmat = sparse(eqmat); popind = sparse(popind);
lob = zeros(trcts*dist_cnt,1); uob = ones(trcts*dist_cnt,1);
slack = 0.002;
lb = ceil(popl/dist_cnt)*(1-slack);

for i = 1:dist_cnt
    
    popind = i:dist_cnt:(dist_cnt*(trcts-1)+i);
    popmat(i, popind) = norcar(:,3)';
    
end

for i = 1:trcts
   eqmat(i,(i-1)*dist_cnt+1:i*dist_cnt) = ones(1,dist_cnt);    
end

eqmat = sparse(eqmat); popind = sparse(popind);
%%
cood = [norcar(:,5) norcar(:,4)];
cdx = cd(randperm(length(cd)));
u = zeros(trcts, dist_cnt); u = one_hot(size(u), cd); alfa = 150;
Emat = []; psimin = []; psinin = [];
T = 0.01;
[centr, centdists] = dist_cent(dist_cnt, cd, [norcar(:,5) norcar(:,4)], norcar(:,3)); % initial centroids
factr = norm([max(norcar(:,5)) - min(norcar(:,5)); max(norcar(:,4))-min(norcar(:,4))])^2;
n = 100;
uall = zeros(trcts, dist_cnt,n); 

for q=1:n
    
    factr = max(max(centdists));
    %factr = 1;
 
    E = sum(sum(0.5*u'*A*(1-u) + alfa*u'*centdists/factr));
    Emat = [Emat, E];

    psi = alfa*centdists/factr - w*u;
    nois = T*randn(size(psi)); psi = psi+nois;T = 0.95*T;
    
    psilin = reshape(psi', size(psi,1)*size(psi,2), 1);
    
    unew = linprog(psilin, -popmat,-lb*ones(dist_cnt,1), eqmat, onesvec', lob, uob);
    psimin = [psimin psilin'*unew];
    u = reshape(unew, dist_cnt, trcts)';
    
   cents = (u'*cood)./sum(u,1)';
   u(u<0.5) = 0;
   u(u>0.5) = 1;
    
   centdists = distcents2(cents, cood, dist_cnt); 
   uall(:,:,q) = u; 
end
u(u<0.5) = 0;
u(u>0.5) = 1;

cdnew = u*(1:13)';
cdnew = round(cdnew);
%%
hold on
figure(1); plot(Emat,'g');
figure(2); gscatter(norcar(:,5), norcar(:,4), cdnew,[],[],10)
