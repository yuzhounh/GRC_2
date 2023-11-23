function label_predict=GRC_2(x_train, x_test, label_train, para)
% GRC, solution 2
% 2020-5-19 07:44:52

warning('off');

X=x_train;
Y=x_test;

% parameters
s=para.s;
p=para.p;
lam=para.lam;

% q=p/(p-1);

m=size(X,2); 
n=size(Y,2); 

% representation coefficients
A=(X'*X+1e-3*eye(m))\(X'*Y); % CRC as initialization
for i=1:n
    y=Y(:,i);
    a=A(:,i);
    
    err=1;
    iter=1;
    while ~(err<1e-3 || iter>30)
        a0=a;
        
        b=y-X*a;
        z=X'*(abs(b).^(s-1).*sign(b));
        a=s/(lam*p)*(abs(a).^(2-p)).*z;
        
        err=norm(a-a0)/norm(a0); % relative error        
        iter=iter+1;
    end
    
    A(:,i)=a;
end

% regularized residuals
k=length(unique(label_train)); % number of classes
rsd=zeros(k,n);
for i=1:k
    ix=label_train==i;
    Ai=A.*repmat(ix',1,n);
    rsd(i,:)=norm_col(Y-X*Ai,s)./norm_col(Ai,p);
end
[~,label_predict]=min(rsd);
