classdef VersionedQueryParameters < QueryParametersWithFill
    %VersionedQueryParameters Versioned Query Paramaters DTO
    
    properties
        VersionSelectionConfig
        VersionSelectionType VersionSelectionTypeEnum
        Granularity
        TransformId
    end
    
    methods
        function obj = VersionedQueryParameters(ids,extractionRangeSelectionConfig,extractionRangeType,timezone,filterId,fillerConfig,fillerKindType, ...
                granularity, transformId, versionSelectionConfig, versionSelectionType)
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
                versionSelectionConfig = [];
                versionSelectionType =[];
            end
            
            obj@QueryParametersWithFill(ids, extractionRangeSelectionConfig, extractionRangeType,timezone,filterId,fillerConfig,fillerKindType);
            
            obj.VersionSelectionConfig = versionSelectionConfig;
            obj.VersionSelectionType = versionSelectionType;
            obj.Granularity = granularity;
            obj.TransformId = transformId;
        end
    end
end

