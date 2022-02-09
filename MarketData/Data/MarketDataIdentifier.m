classdef MarketDataIdentifier
    %MarketDataIdentifier MarketDataIdentifier    
    properties
        Provider
        Name
    end
    
    methods
        function obj = MarketDataIdentifier(provider, curveName)
            obj.Provider = provider;
            obj.Name = curveName;
        end
    end
end

