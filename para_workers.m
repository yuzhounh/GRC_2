function para_workers(poolsize)
% Start parallel workers for parallel computing.
%
% The poolsize is a positive integer whose upper limit is constrainted by
% several factors. Check:
%   1) Running Code on Parallel Pools - MATLAB & Simulink - MathWorks China
%   http://t.cn/Rq5rP8P
%   2) Memory. Reduce the pool size in case of the out of memory problem.
%
% 2013-1-11 15:09:25

% the maximum number of parallel workers
import java.lang.*;
nCPU=Runtime.getRuntime.availableProcessors; % number of CPUs
poolsize_max=floor(nCPU*0.95); % use 95% CPUs

% save the NumWorkers in Cluser Profile
cluster=parcluster;
cluster.NumWorkers=poolsize_max;
saveProfile(cluster);

% check the poolsize
if nargin==0 || poolsize>poolsize_max
    poolsize=poolsize_max;
end

% the current pool size
poolobj = gcp('nocreate');
if isempty(poolobj) % no pool
    if poolsize~=0
        parpool(poolsize);
    end
else
    if poolsize==0
        delete(gcp);
    elseif poolsize~=poolobj.NumWorkers % a different poolsize
        delete(gcp);
        parpool(poolsize);
    end
end