m = 1; epsmin = 1/2/dist_cnt; epsinit = 1; scale = 1.5;
trnum = 1:trcts';
cdn = cd;
popl = sum(norcar(:,3));
ub = ceil(popl/dist_cnt)*1.001; lb = ceil(popl/dist_cnt)*0.999; 

for i = 1:m
    psi = alfa*centdists/max(max(centdists)) - A*u;
    totpop = sum(norcar(:,3));
    a = 1-psi; 
    p = zeros(dist_cnt,1); t = p; eps = epsinit;
    ctr = 0;
    while eps>epsmin
        
         assm = zeros(size(cd)); d = p-t;
         while(~isempty(assm == 0))
             tic
             empts = trnum(assm == 0);
                for l = 1:length(empts)
                      
                    [M, ics] = maxk(a(empts(l),:)-d',2);
                    a_in_ics = trnum(cdn==ics(1));
                    pop_of_x = norcar(empts(l),3);
                    bid = zeros(size(a_in_ics));
                    for j = 1:length(a_in_ics)
                        bid = zeros(1, length(a_in_ics));
                        [M2, ics2] = maxk(a(a_in_ics(j),:)-d',2);
                            if ics2(1) == ics
                                sec_ch = ics2(2); sec_M = M2(2);
                            else
                                sec_ch = ics2(1); sec_M = M2(1);
                            end
                            
                            bid(j) = eps+a(a_in_ics(j), ics(1)) - (sec_M - d(sec_ch));
                    end
                    
                    
                    bidi = eps + M(1) - M(2) + d(ics(2));
                    pop_of_rep = norcar(a_in_ics(:), 3);
                    
                    peeps = norcar(cdn==ics(1),3);
                    vol = sum(peeps);
                    %replaced_flag = 0;
                    %while(replaced_flag = 0)
                    [rep_bid, minI] = min(bid);
                    rep_guy = a_in_ics(minI);
                    pop_of_y = pop_of_rep();    
                    
                    if vol+pop_of_x >= ub
                        if vol+pop_of_x-pop_of_y < ub
                            assm(rep_guy) = 0; assm(l) = 1;
                            cdn(rep_guy) = 0; cdn(l) = ics(1);
                            d(ics(1)) = rep_bid;
                        end
                    else
                        if (vol+pop_of_x) >= lb && d(ics(1)) < 0
                            assm(rep_guy) = 0; assm(l) = 1;
                            cdn(rep_guy) = 0; d(ics(1)) = min(rep_bid, 0); 
                        else
                            assm(l) = 1; cdn(l) = ics(1);
                        end
                    end
                end
                ctr = ctr+1
                toc
         end
         p = max(d,0); t = min(-d,0); eps = eps/scale;
    end
    unew = one_hot(size(u), cdn);
    
end
                    
                            
                        
                            

