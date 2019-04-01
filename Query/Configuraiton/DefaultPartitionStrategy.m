classdef DefaultPartitionStrategy < IPartitionStrategy
    %DEFAULTPARTITIONSTRATEGY Default Partition Strategy
    properties
        maxids=20
    end
    
    methods
        function result = PartitionActual(obj, actualQueryParametersArray)
            result= obj.idPartition(actualQueryParametersArray);
        end
        function result = PartitionVersioned(obj, versionedQueryParametersArray)
            result= obj.idPartition(versionedQueryParametersArray);
        end
        function result = PartitionMas(obj, masQueryParametersArray)
            result= obj.idPartition(masQueryParametersArray);
        end
    end
    methods (Access = private)
        function result = idPartition(obj, parameters)
            maxIds=obj.maxids;
            result = [];
            for i = parameters
                if(isempty(i.Ids))
                    result = [result, i];
                    continue;
                end
                x=i.Ids;
                element = numel(x);
                nArray = floor(element/maxIds);
                batches = num2cell(reshape(x(1:(nArray*maxIds)), maxIds, nArray), 1);
                if(~(mod(element,maxIds)==0))
                    batches{end+1}= reshape(x((nArray*maxIds)+1:element),element - nArray*maxIds,1);
                end
                for batch = batches
                    i.Ids = batch{1};
                    result = [result, i];
                end
            end      
        end
        
    end
end

