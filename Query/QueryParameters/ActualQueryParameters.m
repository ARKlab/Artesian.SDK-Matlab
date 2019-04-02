classdef ActualQueryParameters < QueryParameters
    %ActualQueryParameters Actual Query Paramaters DTO
    
    properties
        Granularity
        TransformId
    end
    
    methods        
        function obj = ActualQueryParameters(ids,extractionRangeSelectionConfig,extractionRangeType,timezone,filterId, ...
                granularity, transformId)
            
            if (nargin == 0)
                ids = [];
                extractionRangeSelectionConfig = [];
                extractionRangeType = [];
                timezone = [];
                filterId = [];
                granularity = [];
                transformId = [];
            end
            
            obj@QueryParameters(ids, extractionRangeSelectionConfig, extractionRangeType,timezone,filterId);
            
            obj.Granularity = granularity;
            obj.TransformId = transformId;
        end
    end
end