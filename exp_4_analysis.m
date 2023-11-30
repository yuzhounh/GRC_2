% 2023-11-3 15:25:07

clear,clc,close all;

sDataset={'AR','FERET'}';
sAlgo={'LRC','CRC','SRC','GRC'}';
sR=1:10;
sDim=[54,120,200,300];

nDataset=length(sDataset);
nAlgo=length(sAlgo);
nR=length(sR);
nDim=length(sDim);

temp=zeros(nAlgo,nDim,nDataset,nR);
for iDataset=1:nDataset
    cDataset=sDataset{iDataset,1};
    for iAlgo=1:nAlgo
        cAlgo=sAlgo{iAlgo,1};
        for iR=1:nR
            cR=sR(iR);
            for iDim=1:nDim
                cDim=sDim(iDim);
                load(sprintf('exp_4/accuracy/%s/%s_r%d_Dim%d.mat',cDataset,cAlgo,cR,cDim),'accuracy');
                temp(iAlgo,iDim,iDataset,iR)=accuracy;
            end
        end
    end
end
temp=mean(temp,4);
table_4=temp(:,:,1);
table_5=temp(:,:,2);