classdef ActualQueryParameters < QueryParametersWithFill
    %ActualQueryParameters Actual Query Paramaters DTO
    
    properties
        Granularity
        TransformId
    end
    
    methods        
        function obj = ActualQueryParameters(ids,extractionRangeSelectionConfig,extractionRangeType,timezone,filterId,fillerConfig,fillerKindType, ...
                granularity, transformId)
            
            if (nargin == 0)
                ids = [];
                extractionRangeSelectionConfig = [];
                extractionRangeType = [];
                timezone = [];
                filterId = [];
                fillerConfig = [];
                fillerKindType = [];
                granularity = [];
                transformId = [];
            end
            
            obj@QueryParametersWithFill(ids, extractionRangeSelectionConfig, extractionRangeType,timezone,filterId,fillerConfig,fillerKindType);
            
            obj.Granularity = granularity;
            obj.TransformId = transformId;
        end
    end
end