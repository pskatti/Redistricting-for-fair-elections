clc
S = shaperead('cb_2018_37_tract_500k.shp');
%mat=load('bubu.mat');
%mat_data=mat(1).cd;
T1 = struct2table(S);
T1 = sortrows(T1, [6 7]);
S = table2struct(T1);
cdomit = cd; %district map arragned in order
cdomit([286, 1028, 1580]) = []; % ye district hatana hai

mat_data=cdomit;
for ii=1:numel(S)
    S(ii).dist=mat_data(ii);
end

clr_ind = randperm(13);% for random coloring. Else jut comment line 18.
clr = hsv(13);
clr = clr(clr_ind,:);

check=makesymbolspec('Polygon',...
{'dist',[1,13],'FaceColor',clr,'EdgeAlpha',0.3});
mapshow(S,'SymbolSpec',check)