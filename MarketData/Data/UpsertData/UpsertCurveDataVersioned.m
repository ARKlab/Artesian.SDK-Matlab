classdef UpsertCurveDataVersioned
    %UpsertCurveDataVersioned UpsertCurveDataVersioned
    properties
        id
        version
        timezone
        downloadedAt

        deferCommandExecution
        deferDataGeneration
        keepNulls

        rows
    end

    methods

        function obj = UpsertCurveDataVersioned(id, version, timezone, downloadedAt, data)
            obj.id = id;
            obj.version = version;
            obj.timezone = timezone;
            obj.downloadedAt = downloadedAt;
            obj.rows = dataRowToDictionary(data);
            obj.deferCommandExecution = true;
            obj.deferDataGeneration = true;
            obj.keepNulls = false;
        end

    end

end
