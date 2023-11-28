% Randomly split the face data into training and testing sets.
% 2020-5-18 21:00:52

clear,clc,close all;

% make a new directory
if ~exist('data')
    mkdir('data');
end

% four face databases
sDataset={'AR','FEI','FERET','UMIST'}';
nDataset=length(sDataset);
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    mkdir(sprintf('data/%s',cDataset));

    % load data
    load(sprintf('face/%s.mat',cDataset));
    [height,width,nPics]=size(x);

    x=reshape(x,[height*width,nPics]);
    label=label';

    % number of subjects
    if strcmp(cDataset,'AR')
        nSub=120;
    elseif strcmp(cDataset,'FEI')
        nSub=200;
    elseif strcmp(cDataset,'FERET')
        nSub=200;
    elseif strcmp(cDataset,'UMIST')
        nSub=20;
    end

    % number of pictures of each subject
    nPic=nPics/nSub; 

    % number of training and testing samples
    if strcmp(cDataset,'FERET')
        nTr=4; % number of training samples
        nTs=3; % number of testing samples
    else
        nTr=6; % number of training samples
        nTs=4; % number of testing samples
    end

    % randomly choose the training and testing samples from each subject
    rng(0);
    nR=10; % number of random separations
    for iR=1:nR
        ix_train=[];
        ix_test=[];
        for iSub=1:nSub
            ix=(iSub-1)*nPic+1:iSub*nPic;
            rSeries=randperm(nPic);  % random series
            ix=ix(rSeries);

            ix_train=[ix_train,ix(1:nTr)];
            ix_test=[ix_test,ix(nTr+1:nTr+nTs)];
        end

        x_train=x(:,ix_train);
        x_test=x(:,ix_test);

        label_train=label(ix_train);
        label_test=label(ix_test);

        save(sprintf('data/%s/r%d.mat',cDataset,iR),'x_train','x_test','label_train','label_test');
    end
end