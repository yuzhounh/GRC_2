function label_predict=LRC(x_train, x_test, label_train)
% Linear regression classifier. 
% 2022-6-29 16:52:51

Y=x_test;
n=size(Y,2);
k=length(unique(label_train)); % number of classes
err=zeros(k,n); % representation errors
for i=1:k
    X=x_train(:,label_train==i);
    m=size(X,2);
    A=(X'*X+1e-3*eye(m))\(X'*Y);  % representation coefficients
    err(i,:)=norm_col(Y-X*A);
end
[~,label_predict]=min(err);