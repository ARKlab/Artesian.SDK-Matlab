classdef DeleteCurveDataBidAsk
    %DeleteCurveDataBidAsk DeleteCurveDataBidAsk
    properties
        id
        timezone
        rangeStart
        rangeEnd

        deferCommandExecution
        deferDataGeneration

        product
    end

    methods

        function obj = DeleteCurveDataBidAsk(id, timezone, product, rangeStart, rangeEnd)
            if nargin < 4
                rangeStart = "0001-01-01T00:00:00";
                rangeEnd = "9999-12-31T00:00:00";
            end

            obj.id = id;
            obj.timezone = timezone;
            obj.product = {product};
            obj.rangeStart = rangeStart;
            obj.rangeEnd = rangeEnd;
            obj.deferCommandExecution = true;
            obj.deferDataGeneration = true;
        end

    end

end
