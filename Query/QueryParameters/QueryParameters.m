classdef (Abstract) QueryParameters
    %QUERYPARAMETER Common Query Paramaters DTO
    
    properties
        Ids
        ExtractionRangeSelectionConfig
        ExtractionRangeType 
        TimeZone
        FilterId
    end
    
    methods
        function obj = QueryParameters(ids,extractionRangeSelectionConfig,extractionRangeType,timeZone,filterId)
            
            if (nargin == 0)
                ids = [];
                extractionRangeSelectionConfig = [];
                extractionRangeType = [];
                timeZone = [];
                filterId = [];
            end
            
            obj.Ids = ids;
            obj.ExtractionRangeSelectionConfig = extractionRangeSelectionConfig;
            obj.ExtractionRangeType = extractionRangeType;
            obj.TimeZone = timeZone;
            obj.FilterId = filterId;
        end
    end
end

