classdef UpsertCurveDataActual
    %UpsertCurveDataActual UpsertCurveDataActual
    properties
        id
        timezone
        downloadedAt

        deferCommandExecution
        deferDataGeneration
        keepNulls
        
        rows
    end

    methods

        function obj = UpsertCurveDataActual(id, timezone, downloadedAt, data)
            obj.id = id;
            obj.timezone = timezone;
            obj.rows = dataRowToDictionary(data);
            obj.downloadedAt = downloadedAt;
            obj.deferCommandExecution = true;
            obj.deferDataGeneration = true;
            obj.keepNulls = false;
        end

    end

end
