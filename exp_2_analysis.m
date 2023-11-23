% 2023-11-3 15:25:07

clear,clc,close all;

sDataset={'AR','FEI','FERET','UMIST'}';
sAlgo={'LRC','CRC','SRC','GRC'}';
sR=1:10;
sPEV=[0.90,0.95,0.98];

nDataset=length(sDataset);
nAlgo=length(sAlgo);
nR=length(sR);
nPEV=length(sPEV);

temp=zeros(nPEV,nAlgo,nDataset,nR);
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    for iAlgo=1:nAlgo
        cAlgo=sAlgo{iAlgo,1};
        for iR=1:nR
            cR=sR(iR);
            for iPEV=1:nPEV
                cPEV=sPEV(iPEV);
                load(sprintf('exp_2/accuracy/%s/%s_r%d_PEV%d.mat',cDataset,cAlgo,cR,round(cPEV*100)),'accuracy');
                temp(iPEV,iAlgo,iDataset,iR)=accuracy;
            end
        end
    end
end
temp=mean(temp,4);
tmp=[temp(:,:,1);temp(:,:,2);temp(:,:,3);temp(:,:,4)];