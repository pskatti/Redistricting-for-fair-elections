%Run this file first. Then districting.m, then linmethod.m and then mapping
%and elections

dist_cnt = 13;
usp = shaperead('cb_2018_us_cd116_500k.shp');
norcar = csvread('norcar.csv');

for cds = 1:size(usp, 1)
    
    if strcmp(usp(cds).STATEFP, '37')
        distnum = str2double(usp(cds).CD116FP);
        distX{distnum} = usp(cds).X;
        distY{distnum} = usp(cds).Y;
    end
end

%%
for i = 1:dist_cnt
    polly = polyshape(distX{i}, distY{i});
    %[xx, yy] = projfwd(mstruct, distX{i}, distY{i}); polly = polyshape(yy,xx);
    plot(polly); hold on;
end
plot(norcar(:,5), norcar(:,4),'.'); hold on;
%[x, y] = projfwd(mstruct, norcar(:,4), norcar(:,5)); plot(x, y,'.'); hold off;

%%
cd = zeros(size(norcar,1), 1);

for i = 1:size(norcar,1)
    for k = 1:dist_cnt
        inp = inpolygon(norcar(i,5), norcar(i,4), distX{k}, distY{k});
        if inp == 1
            cd(i) = k;
            continue;
        end
    end
end

cd(cd==0) = 13;
%%
trcts = size(norcar,1);
u = zeros(trcts, dist_cnt); u = one_hot(size(u), cd);