classdef MarketDataServiceAdmin
    %MarketDataServiceAdmin MarketDataServiceAdmin

    properties (Access = private)
        client
    end

    methods (Access = public)

        function obj = MarketDataServiceAdmin(client)
            obj.client = client;
        end

        function output = Create(obj, group)
            url = "/group";

            output = obj.client.ExecWrite("POST", url, group);
        end

        function output = Update(obj, groupId, group)
            url = "/group/" + groupId;

            output = obj.client.ExecWrite("PUT", url, group);
        end

        function output = Remove(obj, groupId)
            url = "/group/" + groupId;

            output = obj.client.Exec("DELETE", url);
        end

        function output = GetById(obj, groupId)
            url = "/group/" + groupId;

            output = obj.client.Exec("GET", url);
        end

        function output = Get(obj, page, pageSize)
            url = "/group";
            url = url + "?page=" + page;
            url = url + "&pageSize=" + pageSize;

            output = obj.client.Exec("GET", url);
        end

        function output = ReadUserPrincipals(obj, user)
            url = "/user/principals?user=" + user;

            output = obj.client.Exec("GET", url);
        end

    end

end
