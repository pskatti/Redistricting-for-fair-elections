H = zeros(dist_cnt*trcts, dist_cnt*trcts);
for i = 1:dist_cnt*trcts
    i_ind = mod(i,13)+1; j = floor(i/13)+1; 
    H(i, i_ind:dist_cnt:end) = A(j,:);
end

H = sparse(H);
fd = H*ones(dist_cnt*trcts,1);
[centr, centdists] = dist_cent(dist_cnt, cd, [norcar(:,5) norcar(:,4)], norcar(:,3)); % initial centroids

centdist_arr = reshape(centdists',size(centdists,1)*size(centdists,2), 1);
alfquad = 1;

u_quad = quadprog(-H,fd+centdist_arr*alfquad, -popmat,-lb*ones(dist_cnt,1), eqmat, onesvec', lob, uob);
u = reshape(unew, dist_cnt, trcts)';