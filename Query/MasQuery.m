classdef MasQuery < Query
    %MASQUERY MasQuery class
    properties (Access  = private)
        partition IPartitionStrategy = DefaultPartitionStrategy
    end
    methods (Access = ?QueryService)
        function obj = MasQuery(client, partition, policy)

            obj@Query(client,MasQueryParameters());

            if (nargin >= 2)
                obj.partition = partition;
            end
            if (nargin >= 3)
                obj.policy = policy;
            end
        end
    end  
    methods (Access = public)      
        function obj = ForProducts(obj,products)
            obj.queryParamaters.Products = products;
        end 
        function out=Execute(obj)
            urlArray = obj.buildRequest();
            out=obj.Exec(urlArray);
        end
    end
    methods (Access = private)  
          
        function urlArray=buildRequest(obj)
            obj.validateQuery();
            qParams= obj.partition.PartitionVersioned([obj.queryParamaters]);
            urlArray={};
            for qParam = qParams
                endUrl =  "/mas" + "/" + obj.buildExtractionRangeRoute(qParam) + "?_=1";
                if(~isempty(qParam.Ids) )
                    endUrl=endUrl+"&id="+urlencode(strjoin(string(qParam.Ids),','));
                end
                if(~isempty(qParam.FilterId) )
                    endUrl=endUrl+"&filderId="+urlencode(qParam.FilterId);
                end
                if(~isempty(qParam.TimeZone) )
                    endUrl=endUrl+"&tz="+urlencode(qParam.TimeZone);
                end
                if(~isempty(qParam.Products) )
                    endUrl=endUrl+"&p="+urlencode(strjoin(string(qParam.Products),','));
                end
                urlArray = [urlArray,endUrl];
            end
        end
    end
    methods (Access = protected)  
        function validateQuery(obj)
            validateQuery@Query(obj);
            if(isempty(obj.queryParamaters.Products))
                error("Products must be provided for extraction. Use .ForProducts() argument takes a string or string array of products")
            end
           
        end
    end
end

