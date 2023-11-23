function [x_train, x_test]=x_zscore(x_train,x_test)
%NORM_ZSCORE Normalize data by zscore so that each feature is centered to 
% have a mean of zero and scaled to have a standard deviation of one. 
% Apply the same parameters to test data.
% [X_TRAIN,X_TEST]=NORM_ZSCORE(X_TRAIN,X_TEST)

% Jing Wang
% 2013-06-24

[x_train,mu,sigma]=zscore(x_train,0,2);
n=size(x_test,2);
x_test=(x_test-repmat(mu,1,n))./repmat(sigma,1,n);