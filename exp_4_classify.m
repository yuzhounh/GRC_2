% 2020-7-13 08:56:27

clear,clc,close all;

% parameters
sDataset={'AR','FERET'}'; % face databases
sAlgo={'LRC','CRC','SRC','GRC'}'; % algorithms
sR=1:10; % repeat for ten times
sDim=[54,10:10:300]; % dimensionality

% length
nDataset=length(sDataset);
nAlgo=length(sAlgo);
nR=length(sR);
nDim=length(sDim);

% combinations of parameters 
paras=[];
count=0;
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    mkdir(sprintf('accuracy/%s/',cDataset));
    for iAlgo=1:nAlgo
        cAlgo=sAlgo{iAlgo,1};
        for iR=1:nR
            cR=sR(iR);
            for iDim=1:nDim
                cDim=sDim(iDim);
                count=count+1;
                paras{count,1}={cDataset,cAlgo,cR,cDim};
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
    cAlgo=para{1,2};
    cR=para{1,3};
    cDim=para{1,4};
    classifier_2(cDataset,cAlgo,cR,cDim);
end

% move the results to a new folder
mkdir('exp_4');
movefile('accuracy','exp_4\');