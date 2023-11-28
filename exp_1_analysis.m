% 2022-1-13 14:32:55

clear,clc,close all;

sDataset={'AR','FEI','FERET','UMIST'}';
sR=1:10;
sS=0.1:0.1:2.0;
sP=0.1:0.1:2.0;

nDataset=length(sDataset);
nR=length(sR);
nS=length(sS);
nP=length(sP);

%% load accuracy
fprintf('loading...\n');
acc=zeros(nP,nS,nR,nDataset);
paras=[];
count=0;
PEV=0.98;
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    fprintf('%s\n', cDataset);
    for iR=1:nR
        cR=sR(iR);
        for iS=1:nS
            cS=sS(iS);
            for iP=1:nP
                cP=sP(iP);
                file=sprintf('exp_1/accuracy/%s/r%d_PEV%d_s%d_p%d.mat',cDataset,cR,round(PEV*100),round(cS*10),round(cP*10));
                try
                    load(file);
                    acc(iP,iS,iR,iDataset)=accuracy;
                catch
                    fprintf('%s\n',file);
                    count=count+1;
                    paras{count,1}={cDataset,iR,iS,iP};
                end
            end
        end
    end
end
save('todo.mat','paras');

%% draw
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    tmp=acc(:,:,:,iDataset);
    tmp=mean(tmp,3);
    tmp=tmp';

    %% Accuracy vs. parameter s
    % p=2.0
    figure;
    temp=tmp(:,20);
    plot(sP,temp,'-o',LineWidth=1.2);
    xlabel('$s$','Interpreter','LaTex');
    ylabel('Accuracy');
    title(cDataset);

    pos=get(gcf,'Position');
    scale=0.7;
    set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);

    %% Accuracy vs. parameter p
    % s=2.0
    figure;
    plot(sP,tmp(20,:),'-o',LineWidth=1.2);
    xlabel('$p$','Interpreter','LaTex');
    ylabel('Accuracy');
    title(cDataset);

    pos=get(gcf,'Position');
    scale=0.7;
    set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);

    %% Accuracy vs. parameter pair (s, p)
    figure1 = figure; % create figure
    axes1 = axes('Parent',figure1); % create axes
    imagesc(tmp);
    xlabel('$p$','Interpreter','LaTex');
    ylabel('$s$','Interpreter','LaTex');
    colorbar;
    title(sprintf('%s',cDataset));

    set(axes1,'Layer','top','XTickLabel',{'0.5','1.0','1.5','2.0'},'YTickLabel',...
        {'0.5','1.0','1.5','2.0'});

    pos=get(gcf,'Position');
    scale=0.7;
    set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);
end

%% Analysis
% p=2.0
fprintf('\nThe highest classification accuracy when p=2.0:\n');
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    tmp=acc(:,:,:,iDataset);
    tmp=mean(tmp,3);
    tmp=tmp';

    temp=tmp(:,20)';
    c=max(temp);
    d=find(c==temp);
    for i=1:length(d)
        fprintf('%s, %0.4f, s=%0.1f\n', cDataset, c, d(i)*0.1);
    end
end

% s=2.0
fprintf('\nThe highest classification accuracy when s=2.0:\n');
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    tmp=acc(:,:,:,iDataset);
    tmp=mean(tmp,3);
    tmp=tmp';

    temp=tmp(20,:)';
    c=max(temp);
    d=find(c==temp);
    for i=1:length(d)
        fprintf('%s, %0.4f, p=%0.1f\n', cDataset, c, d(i)*0.1);
    end
end

% CRC
fprintf('\nCRC\n');
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    tmp=acc(:,:,:,iDataset);
    tmp=mean(tmp,3);
    tmp=tmp';

    fprintf('%s, %0.4f\n',cDataset, tmp(20,20));
end

% SRC
fprintf('\nSRC\n');
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    tmp=acc(:,:,:,iDataset);
    tmp=mean(tmp,3);
    tmp=tmp';

    fprintf('%s, %0.4f\n',cDataset, tmp(20,10));
end

% (s, p)
fprintf('\nThe highest classification accuracy:\n');
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    tmp=acc(:,:,:,iDataset);
    tmp=mean(tmp,3);
    tmp=tmp';

    [a,b]=find(tmp==max(tmp(:)));
    for i=1:length(a)
        fprintf('%s, %0.4f, s=%0.1f, p=%0.1f\n',cDataset, max(tmp(:)),a(i)*0.1,b(i)*0.1);
    end
end
