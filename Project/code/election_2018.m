county_no = 100;

cd_allot = cd;

popdatwhole = xlsread('countygrowth_2020.xls');
turnoutwhole = readtable('Turnout.xlsx');
popdatwhole(1,:) = [];
popchange = popdatwhole(:,5);
turnoutwhole(1,:) = [];
newpop = zeros(size(cd));

totvot_D = readtable('HORTurnout2018_1.xlsx','Sheet',1);
totvot_D(1,:) = [];
totvot_D(:,1:2) = [];
votD = str2double(table2cell(totvot_D));
votD(:,3) = zeros(county_no,1); %No dem candidate stood

totvot_R = readtable('HORTurnout2018_1.xlsx','Sheet',3);
totvot_R(1,:) = [];
totvot_R(:,1:2) = [];
votR = str2double(table2cell(totvot_R));

dem_votes = sum(votD,2);
rep_votes = sum(votR,2);
no_voturn = dem_votes+rep_votes;


vot_by_trcts = zeros(trcts, 1); demtrct = zeros(trcts, 1); reptrct = zeros(trcts, 1);

for i = 1:county_no
    currpop = [];
    
    cn_indx = norcar(:,1)==2*i-1;
    currpop = norcar(cn_indx,:);
    
    currpop(:,3) = currpop(:,3)*(1+popchange(i));
    trfact = currpop(:,3)./sum(currpop(:,3));
    no_of_votes = no_voturn(i);
    
    voterpop = round(no_of_votes*trfact);
    vot_by_trcts(cn_indx) = voterpop;
    demtrct(cn_indx) = round(dem_votes(i)*trfact);
    reptrct(cn_indx) = round(rep_votes(i)*trfact);
    
end

demcong = zeros(dist_cnt,1); repcong = zeros(dist_cnt, 1);
demcong_old = demcong; repcong_old = repcong;

for i = 1:dist_cnt
    
    demcong(i) = sum(demtrct(cdnew==i));
    repcong(i) = sum(reptrct(cdnew==i));
    
    demcong_old(i) = sum(demtrct(cd==i));
    repcong_old(i) = sum(reptrct(cd==i));
    
end

[demcong repcong]
[demcong_old repcong_old]