classdef MarketDataServiceTimeTransform
    %MarketDataServiceTimeTransform MarketDataServiceTimeTransform

    properties (Access = private)
        client
    end

    methods (Access = public)

        function obj = MarketDataServiceTimeTransform(client)
            obj.client = client;
        end

        function marketDataEntity = GetById(obj, id)
            url = "/timetransform/entity/" + id;

            marketDataEntity = obj.client.Exec("GET", url);
        end

        function marketDataEntity = Get(obj, page, pageSize, userDefined)
            url = "/timetransform/entity";

            url = url + "?page=" + page;
            url = url + "&pageSize=" + pageSize;
            url = url + "&userDefined=" + userDefined;

            marketDataEntity = obj.client.Exec("GET", url);
        end

        function marketDataEntity = Create(obj, timeTransform)
            url = "/timetransform/entity";

            marketDataEntity = obj.client.ExecWrite("POST", url, timeTransform);
        end

        function marketDataEntity = Update(obj, timeTransform)
            url = "/timetransform/entity/" + timeTransform.id;

            marketDataEntity = obj.client.ExecWrite("PUT", url, timeTransform);
        end

        function marketDataEntity = Delete(obj, id)
            url = "/timetransform/entity/" + id;

            marketDataEntity = obj.client.Exec("DELETE", url);
        end

    end

end
