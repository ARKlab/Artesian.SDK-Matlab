classdef (Abstract) Query
    %QUERY Common Query class
    properties (Access  = protected)
        queryParamaters
        policy PolicyConfig
        client ClientArtesian
    end
    methods (Access = protected)
        function obj = Query(client, qp)
            obj.client = client;
            obj.queryParamaters = qp;
        end
    end
    methods (Access = public)
        function obj = ForMarketData(obj, ids)            
            obj.queryParamaters.FilterId = [];
            obj.queryParamaters.Ids = ids;
        end
        
        function obj = ForFilterId(obj,filterId)
            obj.queryParamaters.FilterId = filterId;
            obj.queryParamaters.Ids = [];
        end
        
        function obj = InTimeZone(obj,tz)
            obj.queryParamaters.TimeZone = tz;
        end
        
        function obj = InAbsoluteDateRange(obj,rangeStart, rangeEnd)
            obj.queryParamaters.ExtractionRangeType = ExtractionRangeTypeEnum.DateRange;
            obj.queryParamaters.ExtractionRangeSelectionConfig.DateStart = rangeStart;
            obj.queryParamaters.ExtractionRangeSelectionConfig.DateEnd = rangeEnd;
        end
        
        function obj = InRelativePeriodRange(obj,from, to)
            obj.queryParamaters.ExtractionRangeType = ExtractionRangeTypeEnum.PeriodRange;
            obj.queryParamaters.ExtractionRangeSelectionConfig.PeriodFrom = from;
            obj.queryParamaters.ExtractionRangeSelectionConfig.PeriodTo = to;
        end
        
        function obj = InRelativePeriod(obj,extractionPeriod)
            obj.queryParamaters.ExtractionRangeType = ExtractionRangeTypeEnum.Period;
            obj.queryParamaters.ExtractionRangeSelectionConfig.Period = extractionPeriod;
        end
        
        function obj = InRelativeInterval(obj,relativeInterval)
            obj.queryParamaters.ExtractionRangeType = ExtractionRangeTypeEnum.RelativeInterval;
            obj.queryParamaters.ExtractionRangeSelectionConfig.Interval = relativeInterval;
        end
    end
    methods (Access = protected)
        function subPath = buildExtractionRangeRoute(obj,queryParamaters)
            switch queryParamaters.ExtractionRangeType
            case ExtractionRangeTypeEnum.DateRange
                subPath = queryParamaters.ExtractionRangeSelectionConfig.DateStart + "/" + queryParamaters.ExtractionRangeSelectionConfig.DateEnd;
            case ExtractionRangeTypeEnum.Period
                subPath = queryParamaters.ExtractionRangeSelectionConfig.Period;
            case ExtractionRangeTypeEnum.PeriodRange
                subPath = queryParamaters.ExtractionRangeSelectionConfig.PeriodFrom + "/" + queryParamaters.ExtractionRangeSelectionConfig.PeriodTo;
            case ExtractionRangeTypeEnum.RelativeInterval
                subPath = char(queryParamaters.ExtractionRangeSelectionConfig.Interval);
            otherwise
              error('Unknown ExtractionRangeType.')
            end
        end
        
        function out = Exec(obj,x)
            waitRetry=obj.policy.RetryWaitTimeMilliSec/1000;
            element = numel(x);
            maxP=min(obj.policy.MaxParallelism,element);
            nArray = floor(element/maxP);
            div = maxP;
            m = mod(element,maxP);
            if (~(m==0))
                div = div-1;
            end
            batches = num2cell(reshape(x(1:(nArray*div)), nArray, div), 1); 
            if (~(m==0))
                batches{end+1}= reshape(x((nArray*div)+1:element), 1, m+nArray);
            end
            result = cell(numel(batches),1);
            maxRetry=obj.policy.RetryCount;            
            for i = 1:numel(batches)                
                todo = batches{i};
                result{i} = {};
                for loop = 1:maxRetry
                    failed = {};
                    for e = todo
                        try
                            result{i}{end+1} = obj.client.Exec("get",e);
                        catch ex
                            if(~(loop==maxRetry))
                                failed=[failed,e]
                            else
                                rethrow(ex);
                            end
                        end
                    end
                    todo = failed;
                    if numel(todo) > 0
                        pause(waitRetry);
                    end
                end
           end
            bah = horzcat(result{:});
            boh = cat(1, bah{:});
            
            if (isempty(boh))
                out = boh;
            else            
                out = struct2table(boh);
            end
        end
        
        function validateQuery(obj)
            if(isempty(obj.queryParamaters.ExtractionRangeType))
                error("Data extraction range must be provided. Provide a date range , period or period range or an interval eg .InAbsoluteDateRange()")
            end
            if(isempty(obj.queryParamaters.Ids) && isempty(obj.queryParamaters.FilterId))
                error("Marketadata ids OR filterId must be provided for extraction. Use .ForMarketData() OR .ForFilterId() and provide an integer or integer array as an argument")
            end
        end
    end
   
end

