classdef DeleteCurveDataAuction
    %DeleteCurveDataAuction DeleteCurveDataAuction
    properties
        id
        timezone
        rangeStart
        rangeEnd

        deferCommandExecution
        deferDataGeneration
    end

    methods

        function obj = DeleteCurveDataAuction(id, timezone, rangeStart, rangeEnd)
            if nargin < 3
                rangeStart = "0001-01-01T00:00:00";
                rangeEnd = "9999-12-31T00:00:00";
            end

            obj.id = id;
            obj.timezone = timezone;
            obj.rangeStart = rangeStart;
            obj.rangeEnd = rangeEnd;
            obj.deferCommandExecution = true;
            obj.deferDataGeneration = true;
        end

    end

end
