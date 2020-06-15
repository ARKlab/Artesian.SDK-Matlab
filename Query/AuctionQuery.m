classdef AuctionQuery < Query
    %ACTUALQUERY ActualQuery class
    properties (Access = private)
        partition IPartitionStrategy = DefaultPartitionStrategy
    end

    methods (Access = ?QueryService)

        function obj = AuctionQuery(client, partition, policy)

            obj@Query(client, AuctionQueryParameters());

            if (nargin >= 2)
                obj.partition = partition;
            end

            if (nargin >= 3)
                obj.policy = policy;
            end

        end

    end

    methods (Access = public)

        function out = Execute(obj)
            urlArray = obj.buildRequest();
            out = obj.Exec(urlArray);
        end

        function obj = InRelativeInterval(obj)
            error("Cannot define a relative interval for an auction");
        end

    end

    methods (Access = private)

        function urlArray = buildRequest(obj)
            obj.validateQuery();
            qParams = obj.partition.Partition([obj.queryParamaters]);
            urlArray = {};

            for qParam = qParams
                endUrl = "/auction/" + obj.buildExtractionRangeRoute(qParam) + "?_=1";

                if (~isempty(qParam.Ids))
                    endUrl = endUrl + "&id=" + urlencode(strjoin(string(qParam.Ids), ','));
                end

                if (~isempty(qParam.FilterId))
                    endUrl = endUrl + "&filterId=" + urlencode(string(qParam.FilterId));
                end

                if (~isempty(qParam.TimeZone))
                    endUrl = endUrl + "&tz=" + urlencode(qParam.TimeZone);
                end

                urlArray = [urlArray, endUrl];
            end

        end

    end

end
