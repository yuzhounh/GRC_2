function classifier_3(cDataset,algo,r,para_PCA)

load(sprintf('data/%s/r%d.mat',cDataset,r)); % load data
[x_train,x_test]=x_zscore(x_train,x_test); % zscore
[x_train,x_test]=x_pca(x_train,x_test,para_PCA); % PCA

% set the parameters for various algorithms and datasets
if strcmp(algo,'LRC')
    label_predict=LRC(x_train,x_test,label_train);
else
    if strcmp(algo,'CRC')
        s=2.0;
        p=2.0;
    elseif strcmp(algo,'SRC')
        s=2.0;
        p=1.0;
    elseif strcmp(algo,'GRC')
        if strcmp(cDataset,'AR')
            s=1.8;
            p=1.2;
        elseif strcmp(cDataset,'FERET')
            s=1.8;
            p=1.2;
        end
    end

    % parameters
    para.s=s;
    para.p=p;
    para.lam=1e-3;
    label_predict=GRC_4(x_train,x_test,label_train,para); % classification
end

% calculate mean accuracy
accuracy=mean(label_predict==label_test);

% save the results
if para_PCA<=1
    PEV=para_PCA; % percentage of explained variances
    save(sprintf('accuracy/%s/%s_r%d_PEV%d.mat',cDataset,alog,r,round(PEV*100)),'accuracy');
elseif para_PCA>1 
    dim=para_PCA; % reduced dimensionality
    save(sprintf('accuracy/%s/%s_r%d_dim%d.mat',cDataset,algo,r,dim),'accuracy');
end