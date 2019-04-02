classdef PolicyConfig
    %POLICYCONFIG Retry Policy and Parallelism Configuration    
    properties
        MaxParallelism = 3
        RetryCount = 3
        RetryWaitTimeMilliSec = 2000
    end
    
    methods
        function obj = PolicyConfig(maxParallelism, retryCount, retryWaitTimeMilliSec )
            if nargin >= 1
                obj.MaxParallelism = maxParallelism;
            end
            if nargin >= 2
                obj.RetryCount = retryCount;
            end
            if nargin >= 3
                obj.RetryWaitTimeMilliSec = retryWaitTimeMilliSec;
            end
        end
    end
end

