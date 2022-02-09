classdef MarketDataService
    %MarketDataService MarketDataService

    properties (Access = public)
        Acl
        Admin
        ApiKey
        CustomFilter
        MarketData
        % Operations
        SearchFacet
        TimeTransform
        UpsertCurve
    end

    methods (Access = public)

        function obj = MarketDataService(cfg)
            client = ClientArtesian(cfg, ArtesianConstants.MetadataVersion);
            obj.Acl = MarketDataServiceAcl(client);
            obj.Admin = MarketDataServiceAdmin(client);
            obj.ApiKey = MarketDataServiceApiKey(client);
            obj.CustomFilter = MarketDataServiceCustomFilter(client);
            obj.MarketData = MarketDataServiceMarketData(client);
            % obj.Operations = MarketDataServiceOperations(client);
            obj.SearchFacet = MarketDataServiceSearchFacet(client);
            obj.TimeTransform = MarketDataServiceTimeTransform(client);
            obj.UpsertCurve = MarketDataServiceUpsertCurve(client);
        end

    end

end
