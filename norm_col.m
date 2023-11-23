function y=norm_col(x,p)
% Calculate Lp-norm for each column of x.
% 2013-3-12 8:09:54

if nargin==1
    p=2;
end

n=size(x,2);
y=zeros(1,n);
for i=1:n
    y(i)=norm(x(:,i),p);
end