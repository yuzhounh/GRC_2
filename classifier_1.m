function classifier_1(cDataset,r,para_PCA,s,p)

% parameters of GRC
para_GRC.s=s;
para_GRC.p=p;
para_GRC.lam=1e-3;

load(sprintf('data/%s/r%d.mat',cDataset,r)); % load data
[x_train,x_test]=x_zscore(x_train,x_test); % zscore
[x_train,x_test]=x_pca(x_train,x_test,para_PCA); % PCA
label_predict=GRC_4(x_train,x_test,label_train,para_GRC); % classification by GRC
accuracy=mean(label_predict==label_test); % calculate mean accuracy

% save the results
if para_PCA<=1
    PEV=para_PCA; % percentage of explained variances
    save(sprintf('accuracy/%s/r%d_PEV%d_s%d_p%d.mat',cDataset,r,round(PEV*100),round(s*10),round(p*10)),'accuracy');
elseif para_PCA>1 
    dim=para_PCA; % reduced dimensionality
    save(sprintf('accuracy/%s/r%d_dim%d_s%d_p%d.mat',cDataset,r,dim,round(s*10),round(p*10)),'accuracy');
end