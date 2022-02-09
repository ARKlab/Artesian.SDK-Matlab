classdef MarketDataServiceSearchFacet
    %MarketDataServiceSearchFacet MarketDataServiceSearchFacet

    properties (Access = private)
        client ClientArtesian
    end

    methods (Access = public)

        function obj = MarketDataServiceSearchFacet(client)
            obj.client = client;
        end

        function marketDataEntity = Search(obj, filter)
            url = "/marketdata/searchfacet";

            url = url + "?page=" + filter.page;
            url = url + "&pageSize=" + filter.pageSize;

            if (isfield(filter, "searchText"))
                url = url + "&searchText=" + filter.searchText;
            end

            if (isfield(filter, "sorts"))
                url = url + "&sorts=" + filter.sorts;
            end

            if (isfield(filter, "filters"))
                url = url + "&filters=" + structToFilterString(filter.filters);
            end

            marketDataEntity = obj.client.Exec("GET", url);
        end

    end

end

function output = structToFilterString(struct)
    fields = fieldnames(struct);
    output = strings (1, numel(fields));

    for i = 1:numel(fields)
        key = fields{i};
        output(i) = key + ":" + struct.(key);
    end

    output = join(output, ",");
end
