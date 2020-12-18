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
        
        %FILLER
        function obj = WithFillNull(obj)
            obj.queryParamaters.FillerKindType = FillerKindTypeEnum.Null;
        end
        function obj = WithFillCustomValue(obj, value)
            obj.queryParamaters.FillerKindType = FillerKindTypeEnum.CustomValue;
            obj.queryParamaters.FillerConfig.FillerMasDV = value;
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
                if(~isempty(qParam.FillerKindType) )
                    endUrl=endUrl+"&fillerK="+urlencode(string(qParam.FillerKindType));
                end
                if(qParam.FillerKindType ~= FillerKindTypeEnum.Default)
                    if(~isempty(qParam.FillerConfig.FillerMasDV.Settlement) )
                        endUrl=endUrl+"&fillerDVs="+urlencode(string(qParam.FillerConfig.FillerMasDV.Settlement));
                    end
                    if(~isempty(qParam.FillerConfig.FillerMasDV.Open) )
                        endUrl=endUrl+"&fillerDVo="+urlencode(string(qParam.FillerConfig.FillerMasDV.Open));
                    end
                    if(~isempty(qParam.FillerConfig.FillerMasDV.Close) )
                        endUrl=endUrl+"&fillerDVc="+urlencode(string(qParam.FillerConfig.FillerMasDV.Close));
                    end
                    if(~isempty(qParam.FillerConfig.FillerMasDV.High) )
                        endUrl=endUrl+"&fillerDVh="+urlencode(string(qParam.FillerConfig.FillerMasDV.High));
                    end
                    if(~isempty(qParam.FillerConfig.FillerMasDV.Low) )
                        endUrl=endUrl+"&fillerDVl="+urlencode(string(qParam.FillerConfig.FillerMasDV.Low));
                    end
                    if(~isempty(qParam.FillerConfig.FillerMasDV.VolumePaid) )
                        endUrl=endUrl+"&fillerDVvp="+urlencode(string(qParam.FillerConfig.FillerMasDV.VolumePaid));
                    end
                    if(~isempty(qParam.FillerConfig.FillerMasDV.VolumeGiven) )
                        endUrl=endUrl+"&fillerDVvg="+urlencode(string(qParam.FillerConfig.FillerMasDV.VolumeGiven));
                    end
                    if(~isempty(qParam.FillerConfig.FillerMasDV.Volume) )
                        endUrl=endUrl+"&fillerDVvt="+urlencode(string(qParam.FillerConfig.FillerMasDV.Volume));
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

