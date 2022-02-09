classdef UpsertCurveDataAuction
    %UpsertCurveDataAuction UpsertCurveDataAuction
    properties
        id
        timezone
        downloadedAt

        deferCommandExecution
        deferDataGeneration
        keepNulls
        
        auctionRows
    end

    methods

        function obj = UpsertCurveDataAuction(id, timezone, downloadedAt, data)
            obj.id = id;
            obj.timezone = timezone;
            obj.downloadedAt = downloadedAt;
            obj.auctionRows = dataRowToDictionary(data);
            obj.deferCommandExecution = true;
            obj.deferDataGeneration = true;
            obj.keepNulls = false;
        end

    end

end
