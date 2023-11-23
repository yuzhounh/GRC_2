% 2020-7-13 08:56:27

clear,clc,close all;

% parameters
sDataset={'AR','FEI','FERET','UMIST'}'; % face databases
sR=1:10; % repeat for ten times
sPEV=0.98; % percentage of explained varainces
sS=0.1:0.1:2.0; % s value for GRC
sP=0.1:0.1:2.0; % p value for GRC

% length
nDataset=length(sDataset);
nR=length(sR);
nPEV=length(sPEV);
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
        for iPEV=1:nPEV
            cPEV=sPEV(iPEV);
            for iS=1:nS
                cS=sS(iS);
                for iP=1:nP
                    cP=sP(iP);
                    count=count+1;
                    paras{count,1}={cDataset,cR,cPEV,cS,cP};
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
    cPEV=para{1,3};
    cS=para{1,4};
    cP=para{1,5};
    classifier_1(cDataset,cR,cPEV,cS,cP); % classification
end

% move the results to a new folder
mkdir('exp_1');
movefile('accuracy','exp_1\');
