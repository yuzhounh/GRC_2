% 2022-1-13 14:32:55

clear,clc,close all;

sDataset={'AR','FERET'}';
sR=1:10;
sDim=[54,120,200,300];
sS=0.1:0.1:2.0;
sP=0.1:0.1:2.0;

nDataset=length(sDataset);
nR=length(sR);
nDim=length(sDim);
nS=length(sS);
nP=length(sP);

%% load accuracy
fprintf('loading...\n');
acc=zeros(nP,nS,nDim,nR,nDataset);
paras=[];
count=0;
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    fprintf('%s\n', cDataset);
    for iR=1:nR
        cR=sR(iR);
        for iDim=1:nDim
            cDim=sDim(iDim);
            for iS=1:nS
                cS=sS(iS);
                for iP=1:nP
                    cP=sP(iP);
                    file=sprintf('exp_3/accuracy/%s/r%d_dim%d_s%d_p%d.mat',cDataset,cR,cDim,round(cS*10),round(cP*10));
                    try
                        load(file);
                        acc(iP,iS,iDim,iR,iDataset)=accuracy;
                    catch
                        fprintf('%s\n',file);
                        count=count+1;
                        paras{count,1}={cDataset,cR,cDim,cS,cP};
                    end
                end
            end
        end
    end
end
save('todo.mat','paras');

%% draw
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    temp=acc(:,:,:,:,iDataset);
    temp=mean(temp,4);
    for iDim=1:nDim
        cDim=sDim(iDim);
        tmp=temp(:,:,iDim);
        tmp=tmp';

        %% Accuracy vs. parameter pair (s, p)
        figure1 = figure; % create figure
        axes1 = axes('Parent',figure1); % create axes
        imagesc(tmp);
        xlabel('$p$','Interpreter','LaTex');
        ylabel('$s$','Interpreter','LaTex');
        colorbar;
        title(sprintf('%s, dim=%d',cDataset,cDim));

        set(axes1,'Layer','top','XTickLabel',{'0.5','1.0','1.5','2.0'},'YTickLabel',...
            {'0.5','1.0','1.5','2.0'});

        pos=get(gcf,'Position');
        scale=0.7;
        set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);
    end
end

%% Analysis
% CRC
fprintf('\nCRC\n');
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    temp=acc(:,:,:,:,iDataset);
    temp=mean(temp,4);
    for iDim=1:nDim
        cDim=sDim(iDim);
        tmp=temp(:,:,iDim);
        tmp=mean(tmp,3);
        tmp=tmp';
        fprintf('%s, dim=%d, %0.4f\n',cDataset, cDim, tmp(20,20));
    end
end

% SRC
fprintf('\nSRC\n');
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    temp=acc(:,:,:,:,iDataset);
    temp=mean(temp,4);
    for iDim=1:nDim
        cDim=sDim(iDim);
        tmp=temp(:,:,iDim);
        tmp=mean(tmp,3);
        tmp=tmp';
        fprintf('%s, dim=%d, %0.4f\n',cDataset, cDim, tmp(20,10));
    end
end

% (s, p)
fprintf('\nThe highest classification accuracy:\n');
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    temp=acc(:,:,:,:,iDataset);
    temp=mean(temp,4);
    for iDim=1:nDim
        cDim=sDim(iDim);
        tmp=temp(:,:,iDim);
        tmp=mean(tmp,3);
        tmp=tmp';

        [a,b]=find(tmp==max(tmp(:)));
        for i=1:length(a)
            fprintf('%s, dim=%d, %0.4f, s=%0.1f, p=%0.1f\n',cDataset, cDim, max(tmp(:)),a(i)*0.1,b(i)*0.1);
        end
    end
end
