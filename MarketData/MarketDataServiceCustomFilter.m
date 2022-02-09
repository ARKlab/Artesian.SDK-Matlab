classdef MarketDataServiceCustomFilter
    %MarketDataServiceCustomFilter MarketDataServiceCustomFilter

    properties (Access = private)
        client
    end

    methods (Access = public)

        function obj = MarketDataServiceCustomFilter(client)
            obj.client = client;
        end

        function output = Create(obj, filter)
            url = "/filter";

            output = obj.client.ExecWrite("POST", url, filter);
        end

        function output = Update(obj, filterId, filter)
            url = "/filter/" + filterId;

            output = obj.client.ExecWrite("PUT", url, filter);
        end

        function output = GetById(obj, id)
            url = "/filter/" + id;

            output = obj.client.Exec("GET", url);
        end

        function output = Delete(obj, id)
            url = "/filter/" + id;

            output = obj.client.Exec("DELETE", url);
        end

        function output = Get(obj, page, pageSize)
            url = "/filter";
            url = url + "?page=" + page;
            url = url + "&pageSize=" + pageSize;

            output = obj.client.Exec("GET", url);
        end

    end

end
