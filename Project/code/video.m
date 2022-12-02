n = 25;
cdnew = cd;
clr_ind = randperm(13);

for i = 1:n
%     clr = hsv(13);
%     clr = clr(clr_ind,:);

    check=makesymbolspec('Polygon',...
    {'dist',[1,13],'FaceColor',clr,'EdgeAlpha',0.1});
    mapshow(S,'SymbolSpec',check)
    F(i) = getframe(gcf);
    
    un = uall(:,:,i);
    cdnew = un*(1:13)';
    
    cdomit = cdnew;
    cdomit([286; 1028; 1580]) = [];
    mat_data=cdomit;
    
    

    for i = 1:size(S)
        S(i).dist=mat_data(i);

    end

    %

end
v = VideoWriter('districting_flow.avi',1);
open(v)
writeVideo(v, F);
close(v)