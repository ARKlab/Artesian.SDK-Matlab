classdef MarketDataServiceDeleteCurve
    %MarketDataServiceDeleteCurve MarketDataServiceDeleteCurve

    properties (Access = private)
        client
    end

    methods (Access = public)

        function obj = MarketDataServiceDeleteCurve(client)
            obj.client = client;
        end

        function marketDataEntity = Delete(obj, data)
            url = "/marketdata/deletedata";

            marketDataEntity = obj.client.ExecWrite("POST", url, data);
        end

    end

end
