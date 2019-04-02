classdef ActualQuery < Query
    %ACTUALQUERY ActualQuery class
    properties (Access  = private)
        partition IPartitionStrategy = DefaultPartitionStrategy
    end
    methods (Access = ?QueryService)
        function obj = ActualQuery(client, partition, policy)

            obj@Query(client, ActualQueryParameters());

            if (nargin >= 2)
                obj.partition = partition;
            end
            if (nargin >= 3)
                obj.policy = policy;
            end
        end
    end  
    methods (Access = public)
        function obj = WithTimeTransform(obj,tr)
            obj.queryParamaters.TransformId = tr;
        end
        
        function obj = InGranularity(obj,granularity)
            obj.queryParamaters.Granularity = granularity;
        end
        
        function out=Execute(obj)
            urlArray = obj.buildRequest();
            out=obj.Exec(urlArray);
        end
    end
    methods (Access = private)  
          
        function urlArray=buildRequest(obj)
            obj.validateQuery();
            qParams= obj.partition.PartitionActual([obj.queryParamaters]);
            urlArray={};
            for qParam = qParams
                endUrl =  "/ts/" + char(qParam.Granularity) + "/" + obj.buildExtractionRangeRoute(qParam) + "?_=1";
                if(~isempty(qParam.Ids) )
                    endUrl=endUrl+"&id="+urlencode(strjoin(string(qParam.Ids),','));
                end
                if(~isempty(qParam.FilterId) )
                    endUrl=endUrl+"&filterId="+urlencode(string(qParam.FilterId));
                end
                if(~isempty(qParam.TimeZone) )
                    endUrl=endUrl+"&tz="+urlencode(qParam.TimeZone);
                end
                if(~isempty(qParam.TransformId) )
                    endUrl=endUrl+"&tr="+urlencode(string(qParam.TransformId));
                end
                urlArray = [urlArray,endUrl];
            end
        end
    end
    methods (Access = protected)  
        function validateQuery(obj)
            validateQuery@Query(obj);
            if(isempty(obj.queryParamaters.Granularity))
                error("Extraction granularity must be provided. Use .InGranularity() argument takes a granularity type")
            end
        end
    end
end

