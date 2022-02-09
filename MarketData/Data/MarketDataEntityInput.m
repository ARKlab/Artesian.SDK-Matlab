classdef MarketDataEntityInput
    %MarketDataEntityInput MarketDataEntityInput
    properties
        providerName
        marketDataName
        originalGranularity
        originalTimezone
        aggregationRule
        type

        marketDataId
        eTag
        % transformId
        providerDescription
        tags
        path
    end

    methods

        function obj = MarketDataEntityInput(providerName, marketDataName, originalGranularity, originalTimezone, aggregationRule, type)
            obj.providerName = providerName;
            obj.marketDataName = marketDataName;
            obj.originalGranularity = originalGranularity;
            obj.originalTimezone = originalTimezone;
            obj.aggregationRule = aggregationRule;
            obj.type = type;
            obj.path = "/marketdata/system/" + providerName + "/" + marketDataName;
            obj.eTag = "";
            obj.marketDataId = 0;
            obj.providerDescription = "";
            obj.tags = {};
            % obj.transformId = "";
        end

    end

end
