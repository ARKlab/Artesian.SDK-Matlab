classdef (Abstract) IPartitionStrategy
    %IPARTITIONSTRATEGY Partition Strategy Interface

    methods (Abstract)
        actualQueryParametersArray = PartitionActual(obj, actualQueryParametersArray)
        
        versionedQueryParametersArray = PartitionVersioned(obj, versionedQueryParametersArray)
        
        masQueryParametersArray = PartitionMas(obj, masQueryParametersArray)
        
    end
end

