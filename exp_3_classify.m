% 2020-7-13 08:56:27

clear,clc,close all;

% parameters
sDataset={'AR','FERET'}'; % face databases
sR=1:10; % repeat for ten times
sDim=[54,120,200,300]; % dimensionality
sS=0.1:0.1:2.0; % s value for GRC
sP=0.1:0.1:2.0; % p value for GRC

% length
nDataset=length(sDataset);
nR=length(sR);
nDim=length(sDim);
nS=length(sS);
nP=length(sP);

% combinations of parameters 
paras=[];
count=0;
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    mkdir(sprintf('accuracy/%s/',cDataset));
    for iR=1:nR
        cR=sR(iR);
        for iDim=1:nDim
            cDim=sDim(iDim);
            for iS=1:nS
                cS=sS(iS);
                for iP=1:nP
                    cP=sP(iP);
                    count=count+1;
                    paras{count,1}={cDataset,cR,cDim,cS,cP};
                end
            end
        end
    end
end

% parallel computing
n=size(paras,1);
fprintf('The number of tasks: %d. \n\n',n);
para_workers;
parfor i=1:n
    para=paras{i,1};
    cDataset=para{1,1};
    cR=para{1,2};
    cDim=para{1,3};
    cS=para{1,4};
    cP=para{1,5};
    classifier_1(cDataset,cR,cDim,cS,cP); % classification
end

% move the results to a new folder
mkdir('exp_3');
movefile('accuracy','exp_3\');