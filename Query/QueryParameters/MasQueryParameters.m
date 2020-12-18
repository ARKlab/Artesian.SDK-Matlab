classdef MasQueryParameters < QueryParametersWithFill
    %MasQueryParameters Market Assessment Query Paramaters DTO
    
    properties
        Products
    end
    
    methods
        function obj = MasQueryParameters(ids,extractionRangeSelectionConfig,extractionRangeType,timezone,filterId,fillerConfig,fillerKindType, ...
                products)
             if (nargin == 0)
                ids = [];
                extractionRangeSelectionConfig = [];
                extractionRangeType = [];
                timezone = [];
                filterId = [];
                fillerConfig = [];
                fillerKindType = [];
                products = [];
             end
            
            obj@QueryParametersWithFill(ids, extractionRangeSelectionConfig, extractionRangeType,timezone,filterId,fillerConfig,fillerKindType);
            
            obj.Products = products;
        end
    end
end