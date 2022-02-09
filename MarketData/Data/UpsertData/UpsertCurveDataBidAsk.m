classdef UpsertCurveDataBidAsk
    %UpsertCurveDataBidAsk UpsertCurveDataBidAsk
    properties
        id
        timezone
        downloadedAt

        deferCommandExecution
        deferDataGeneration
        keepNulls

        bidAsk
    end

    methods

        function obj = UpsertCurveDataBidAsk(id, timezone, downloadedAt, data)
            obj.id = id;
            obj.timezone = timezone;
            obj.bidAsk = productDataRowToDictionary(data);
            obj.downloadedAt = downloadedAt;
            obj.deferCommandExecution = true;
            obj.deferDataGeneration = true;
            obj.keepNulls = false;
        end

    end

end
