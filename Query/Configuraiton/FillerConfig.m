classdef FillerConfig
    %FILLERCONFIG Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        FillerTimeSeriesDV
        FillerPeriod
        FillerMasDV
        FillerBidAskDV
    end
    
    methods
        function obj = FillerConfig()
            %FILLERCONFIG Construct an instance of this class
            %   Detailed explanation goes here
            obj.FillerTimeSeriesDV = [];
            obj.FillerPeriod = [];
            obj.FillerMasDV = [];
            obj.FillerBidAskDV = [];
        end
        
    end
end

