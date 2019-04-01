classdef MasQueryParameters < QueryParameters
    %MasQueryParameters Market Assessment Query Paramaters DTO
    
    properties
        Products
    end
    
    methods
        function obj = MasQueryParameters(ids,extractionRangeSelectionConfig,extractionRangeType,timezone,filterId, ...
                products)
             if (nargin == 0)
                ids = [];
                extractionRangeSelectionConfig = [];
                extractionRangeType = [];
                timezone = [];
                filterId = [];
                products = [];
            end
            obj@QueryParameters(ids, extractionRangeSelectionConfig, extractionRangeType,timezone,filterId);
            obj.Products = products;
        end
    end
end