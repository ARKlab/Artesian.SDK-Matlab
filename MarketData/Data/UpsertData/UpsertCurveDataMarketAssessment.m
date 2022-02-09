classdef UpsertCurveDataMarketAssessment
    %UpsertCurveDataMarketAssessment UpsertCurveDataMarketAssessment
    properties
        id
        timezone
        downloadedAt

        deferCommandExecution
        deferDataGeneration
        keepNulls

        marketassessment
    end

    methods

        function obj = UpsertCurveDataMarketAssessment(id, timezone, downloadedAt, data)
            obj.id = id;
            obj.timezone = timezone;
            obj.downloadedAt = downloadedAt;
            obj.marketassessment = productDataRowToDictionary(data);
            obj.deferCommandExecution = true;
            obj.deferDataGeneration = true;
            obj.keepNulls = false;
        end

    end

end
