classdef MarketDataServiceMarketData
    %MarketDataServiceMarketData MarketDataServiceMarketData

    properties (Access = private)
        client ClientArtesian
    end

    methods (Access = public)

        function obj = MarketDataServiceMarketData(client)
            obj.client = client;
        end

        function marketDataEntity = GetByProviderName(obj, id)
            url = "/marketdata/entity";

            url = url + "?provider=" + id.Provider;
            url = url + "&curveName=" + id.Name;

            marketDataEntity = obj.client.Exec("GET", url);
        end

        function marketDataEntity = GetById(obj, id)
            url = "/marketdata/entity/" + id;

            marketDataEntity = obj.client.Exec("GET", url);
        end

        function curveRange = ReadCurveRange(obj, id, page, pageSize, product, versionFrom, versionTo)
            url = "/marketdata/entity";

            if (nargin < 4)
                error("id, page, pageSize are needed");
            else
                url = url + "/" + string(id) + "/" + "curves" + "?page=" + string(page) + "&pagesize=" + string(pageSize);
            end

            if (nargin >= 5 && ~isempty(product))
                url = url + "&product=" + product;
            end

            if (nargin >= 7)
                url = url + "&versionFrom=" + versionFrom;
                url = url + "&versionTo=" + versionTo;
            end

            curveRange = obj.client.Exec("GET", url);
        end

        function marketDataEntity = Create(obj, data)
            url = "/marketdata/entity/";

            marketDataEntity = obj.client.ExecWrite("POST", url, data);
        end

        function marketDataEntity = Update(obj,  data)
            url = "/marketdata/entity/" + data.MarketDataId;

            marketDataEntity = obj.client.ExecWrite("PUT", url, data);
        end

        function marketDataEntity = Delete(obj, id)
            url = "/marketdata/entity/" + id;

            marketDataEntity = obj.client.Exec("DELETE", url);
        end

    end

end
