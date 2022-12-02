m = 1; epsmin = 1/2/dist_cnt; epsinit = 1; scale = 27;
trnum = (1:trcts)';
cdn = cd;
popl = sum(norcar(:,3));
ub = ceil(popl/dist_cnt)*1.001; lb = ceil(popl/dist_cnt)*0.999; 
unew = u;iter = 0;
icsmat = []; volall = [];
for i = 1:m
    psi = alfa*centdists/max(centdists) - A*unew;
    totpop = sum(norcar(:,3));
    a = 1-psi; 
    p = zeros(dist_cnt,1); t = p; eps = epsinit;
    ctr = 0;
    assm = zeros(size(cd)); d = p-t; cdn = zeros(size(cd));

    while eps>epsmin
         while(sum(assm == 0)~=0) 
             empts = trnum(assm == 0);
             tic;
                for l = 1:length(empts)
                      
                    [M, ics] = maxk(a(empts(l),:)-d',2);
                    a_in_ics = trnum(cdn==ics(1));
                    pop_of_x = norcar(empts(l),3);
                    bidi = eps + M(1) - M(2) + d(ics(2));
                    
                    peeps = norcar(cdn==ics(1),3);
                    vol = sum(peeps);
                    volall = [volall vol];
                    icsmat = [icsmat ics(1)];
                    
                    if vol+pop_of_x >= ub
                        [bid, pop_of_rep, rep_guy, pop_of_y, rep_bid] = conflict_bids(a, ics, eps, a_in_ics, d, norcar);
                        if vol+pop_of_x-pop_of_y < ub
                            assm(rep_guy) = 0; assm(empts(l)) = 1;
                            cdn(rep_guy) = 0; cdn(empts(l)) = ics(1);
                            d(ics(1)) = rep_bid;
                        end
                    else
%                         if (vol+pop_of_x) >= lb && vol <= lb && d(ics(1)) < 0
%                             [bid, pop_of_rep, rep_guy, pop_of_y, rep_bid] = conflict_bids(a, ics, eps, a_in_ics, d, norcar);
%                             assm(rep_guy) = 0; assm(empts(l)) = 1; cdn(empts(l)) = ics(1);
%                             cdn(rep_guy) = 0; d(ics(1)) = min(rep_bid, 0); 
%                         else
%                            
                            assm(empts(l)) = 1; cdn(empts(l)) = ics(1);
                        %end
                        %icsmat = [icsmat ics(1)];

                    end
                end
                ctr = ctr+1
                sum(assm==1)
                toc
         end
         p = max(d,0); t = max(-d,0); eps = eps/scale;
    end
    unew = one_hot(size(u), cdn);
    [centr, centdists] = dist_cent(dist_cnt, cd, [norcar(:,5) norcar(:,4)], norcar(:,3)); % initial centroids
end
                    
                            
                        
                            

