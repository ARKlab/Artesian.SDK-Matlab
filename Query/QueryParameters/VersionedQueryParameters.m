classdef VersionedQueryParameters < QueryParameters
    %VersionedQueryParameters Versioned Query Paramaters DTO
    
    properties
        VersionSelectionConfig
        VersionSelectionType VersionSelectionTypeEnum
        Granularity
        TransformId
    end
    
    methods
        function obj = VersionedQueryParameters(ids,extractionRangeSelectionConfig,extractionRangeType,timezone,filterId, ...
                granularity, transformId, versionSelectionConfig, versionSelectionType)
            if (nargin == 0)
                ids = [];
                extractionRangeSelectionConfig = [];
                extractionRangeType = [];
                timezone = [];
                filterId = [];
                granularity = [];
                transformId = [];
                versionSelectionConfig = [];
                versionSelectionType =[];
            end
            
            obj@QueryParameters(ids, extractionRangeSelectionConfig, extractionRangeType,timezone,filterId);
            obj.VersionSelectionConfig = versionSelectionConfig;
            obj.VersionSelectionType = versionSelectionType;
            obj.Granularity = granularity;
            obj.TransformId = transformId;
        end
    end
end

