classdef MarketDataServiceApiKey
    %MarketDataServiceApiKey MarketDataServiceApiKey

    properties (Access = private)
        client
    end

    methods (Access = public)

        function obj = MarketDataServiceApiKey(client)
            obj.client = client;
        end

        function output = Create(obj, key)
            url = "/apikey/entity";

            output = obj.client.ExecWrite("POST", url, key);
        end

        function output = GetById(obj, id)
            url = "/apikey/entity/" + id;

            output = obj.client.Exec("GET", url);
        end

        function output = GetByUserId(obj, page, pageSize, userId)
            url = "/apikey/entity";
            url = url + "?page=" + page;
            url = url + "&pageSize=" + pageSize;
            url = url + "&userId=" + userId;

            output = obj.client.Exec("GET", url);
        end

        function output = Delete(obj, id)
            url = "/apikey/entity/" + id;

            output = obj.client.Exec("DELETE", url);
        end

    end

end
