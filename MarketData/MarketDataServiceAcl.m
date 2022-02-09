classdef MarketDataServiceAcl
    %MarketDataServiceAcl MarketDataServiceAcl

    properties (Access = private)
        client
    end

    methods (Access = public)

        function obj = MarketDataServiceAcl(client)
            obj.client = client;
        end

        function output = ReadRolesByPath(obj, path)
            url = "/acl/me?path=" + path;

            output = obj.client.Exec("GET", url);
        end

        function output = GetRoles(obj, page, pageSize, principalIds, asOf)
            url = "/acl";

            url = url + "?page=" + page;
            url = url + "&pageSize=" + pageSize;
            url = url + "&principalIds=" + join(principalIds, ",");

            if (nargin > 5)
                url = url + "&asOf=" + asOf;
            end

            output = obj.client.Exec("GET", url);
        end

        function output = AddRoles(obj, data)
            url = "/acl/roles";

            output = obj.client.ExecWrite("POST", url, data);
        end

        function output = RemoveRoles(obj, data)
            url = "/acl/roles";

            output = obj.client.ExecWrite("DELETE", url, data);
        end

    end

end
