% 2020-7-13 08:56:27

clear,clc,close all;

% parameters
sDataset={'AR','FEI','FERET','UMIST'}'; % face databases
sAlgo={'LRC','CRC','SRC','GRC'}'; % algorithms
sR=1:10; % repeat for ten times
sPEV=[0.90,0.95,0.98]; % percentage of explained varainces

% length
nDataset=length(sDataset);
nAlgo=length(sAlgo);
nR=length(sR);
nPEV=length(sPEV);

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
            for iPEV=1:nPEV
                cPEV=sPEV(iPEV);
                count=count+1;
                paras{count,1}={cDataset,cAlgo,cR,cPEV};
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
    cPEV=para{1,4};
    classifier_2(cDataset,cAlgo,cR,cPEV); % classification
end

% move the results to a new folder
mkdir('exp_2');
movefile('accuracy','exp_2\');