classdef ArtesianServiceConfig
    %ARTESIANSERVICECONFIG ArtesianService Configuration    
    properties
        BaseAddress
        ApiKey
    end
    
    methods
        function obj = ArtesianServiceConfig(baseAddress,apiKey)
            obj.BaseAddress = baseAddress;
            obj.ApiKey = apiKey;
        end
    end
end

