classdef QueryParametersWithFill < QueryParameters
    %QueryParametersWithFill Query Paramaters with Fill DTO
    
    properties
        FillerConfig
        FillerKindType
    end
    
    methods        
        function obj = QueryParametersWithFill(ids,extractionRangeSelectionConfig,extractionRangeType,timezone,filterId, ...
                fillerConfig,fillerKindType)
            
            if (nargin == 0)
                ids = [];
                extractionRangeSelectionConfig = [];
                extractionRangeType = [];
                timezone = [];
                filterId = [];
                fillerConfig = [];
                fillerKindType = [];
            end
            
            obj@QueryParameters(ids, extractionRangeSelectionConfig,extractionRangeType,timezone,filterId);
             
            obj.FillerConfig = FillerConfig();
            obj.FillerKindType = FillerKindTypeEnum.Default;
            
            
        end
    end
end