classdef MarketDataServiceUpsertCurve
    %MarketDataServiceUpsertCurve MarketDataServiceUpsertCurve

    properties (Access = private)
        client
    end

    methods (Access = public)

        function obj = MarketDataServiceUpsertCurve(client)
            obj.client = client;
        end

        function marketDataEntity = Upsert(obj, data)
            url = "/marketdata/upsertdata";

            marketDataEntity = obj.client.ExecWrite("POST", url, data);
        end

    end

end
