classdef DeleteCurveDataActual
    %DeleteCurveDataActual DeleteCurveDataActual
    properties
        id
        timezone
        rangeStart
        rangeEnd

    end

    methods

        function obj = DeleteCurveDataActual(id, timezone, rangeStart, rangeEnd)
            if nargin < 3
                rangeStart = "0001-01-01T00:00:00";
                rangeEnd = "9999-12-31T00:00:00";
            end

            obj.id = id;
            obj.timezone = timezone;
            obj.rangeStart = rangeStart;
            obj.rangeEnd = rangeEnd;
        end

    end

end
