function [x_train,x_test]=x_pca(x_train,x_test,para)
%PCAX principal component analysis
% [X_TRAIN,X_TEST]=PCAX(X_TRAIN,X_TEST,PARA) apply PCA to reduce dimensionality
% of data. Each column in x(x_train, x_test) is a sample and each column is
% a feature.
%
% See also: svd, pca, princomp

% Jing Wang
% 2013-07-19

% substract the mean of training data
temp=mean(x_train,2);
x_train=x_train-repmat(temp,1,size(x_train,2));
x_test=x_test-repmat(temp,1,size(x_test,2));

% SVD
% the last eigen value in s is close to zero
[u,s,~]=svd(x_train,0);

% set the number of PCs
if para>1
    n=para; % the reduced dimensionality (>1)
else
    % the percentage of the total variance explained by each principal component
    s=diag(s);
    s=s.*s;
    s=s/sum(s);
    s=cumsum(s);
    n=sum(s<=para); % the percentage of explained variance (<= 100%)
end

% choose the first k Principal Components
u=u(:,1:n);

% projection
x_train=u'*x_train;
x_test=u'*x_test;