%clear all
%close all
clc
S = shaperead('cb_2018_37_tract_500k.shp');
%mat=load('bubu.mat');
%mat_data=mat(1).cd;
T1 = struct2table(S);
T1 = sortrows(T1, [6 7]);
S = table2struct(T1);
cdomit = cd;
cdomit([286, 1028, 1580]) = [];

mat_data=cdomit;
for ii=1:numel(S)
    S(ii).dist=mat_data(ii);
end

clr_ind = randperm(13);
clr = hsv(13);
%clr = rand(dist_cnt,3);
clr = clr(clr_ind,:);

check=makesymbolspec('Polygon',...
{'dist',[1,13],'FaceColor',clr,'EdgeAlpha',0.3});
mapshow(S,'SymbolSpec',check)

%%


% for ii=1:numel(S)
%     S(ii).dist=mat_data(ii);
% end
trctid = zeros(size(S));
cdomit = cdnew;
cdomit([286; 1028; 1580]) = [];
mat_data=cdomit;

for i = 1:size(S)
    trctid(i,1) = str2double(S(i).TRACTCE);
    trctid(i,2) = str2double(S(i).COUNTYFP);
    S(i).dist=mat_data(i);
 
end

%clr_ind = randperm(13);

%clr = clr(clr_ind,:);
figure(2)

check=makesymbolspec('Polygon',...
{'dist',[1,13],'FaceColor',clr,'EdgeAlpha',0.3});
mapshow(S,'SymbolSpec',check)

%%
% bb=1;
% norcar2 = norcar; cdx = cd; mm = [];
% while(bb~= 0)
%     locdiff = trctid(:,1)==norcar2(1:2192,2);
%     nn = find(locdiff==0);
%     
%     if isempty(nn)
%         bb = 0;
%     else
%         mm = [mm, nn(1)];
%         norcar2(nn(1),:) = [];
%     end
% end
%     
