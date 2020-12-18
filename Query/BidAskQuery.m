classdef BidAskQuery < Query
    %BIDASKQUERY BidAskQuery class
    properties (Access  = private)
        partition IPartitionStrategy = DefaultPartitionStrategy
    end
    methods (Access = ?QueryService)
        function obj = BidAskQuery(client, partition, policy)

            obj@Query(client,BidAskQueryParameters());

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
        
        %FILLER
        function obj = WithFillNull(obj)
            obj.queryParamaters.FillerKindType = FillerKindTypeEnum.Null;
        end
        function obj = WithFillCustomValue(obj, value)
            obj.queryParamaters.FillerKindType = FillerKindTypeEnum.CustomValue;
            obj.queryParamaters.FillerConfig.FillerBidAskDV = value;
        end
        function obj = WithFillLatestValue(obj, period)
            obj.queryParamaters.FillerKindType = FillerKindTypeEnum.LatestValidValue;
            obj.queryParamaters.FillerConfig.FillerPeriod = period;
        end
        function obj = WithFillNone(obj)
            obj.queryParamaters.FillerKindType = FillerKindTypeEnum.NoFill;
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
                endUrl =  "/ba" + "/" + obj.buildExtractionRangeRoute(qParam) + "?_=1";
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
                if(~isempty(qParam.FillerKindType) )
                    endUrl=endUrl+"&fillerK="+urlencode(string(qParam.FillerKindType));
                end
                if(qParam.FillerKindType ~= FillerKindTypeEnum.Default)
                    if(~isempty(qParam.FillerConfig.FillerBidAskDV.BestBidPrice) )
                        endUrl=endUrl+"&fillerDVbbp="+urlencode(string(qParam.FillerConfig.FillerBidAskDV.BestBidPrice));
                    end
                    if(~isempty(qParam.FillerConfig.FillerBidAskDV.BestAskPrice) )
                        endUrl=endUrl+"&fillerDVbap="+urlencode(string(qParam.FillerConfig.FillerBidAskDV.BestAskPrice));
                    end
                    if(~isempty(qParam.FillerConfig.FillerBidAskDV.BestBidQuantity) )
                        endUrl=endUrl+"&fillerDVbbq="+urlencode(string(qParam.FillerConfig.FillerBidAskDV.BestBidQuantity));
                    end
                    if(~isempty(qParam.FillerConfig.FillerBidAskDV.BestAskQuantity) )
                        endUrl=endUrl+"&fillerDVbaq="+urlencode(string(qParam.FillerConfig.FillerBidAskDV.BestAskQuantity));
                    end
                    if(~isempty(qParam.FillerConfig.FillerBidAskDV.LastPrice) )
                        endUrl=endUrl+"&fillerDVlp="+urlencode(string(qParam.FillerConfig.FillerBidAskDV.LastPrice));
                    end
                    if(~isempty(qParam.FillerConfig.FillerBidAskDV.LastQuantity) )
                        endUrl=endUrl+"&fillerDVlq="+urlencode(string(qParam.FillerConfig.FillerBidAskDV.LastQuantity));
                    end
                    if(~isempty(qParam.FillerConfig.FillerPeriod) )
                        endUrl=endUrl+"&fillerP="+urlencode(string(qParam.FillerConfig.FillerPeriod));
                    end
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

