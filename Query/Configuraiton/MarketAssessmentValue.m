classdef MarketAssessmentValue
    %MarketAssessmentValue Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Settlement
        Open
        Close
        High
        Low
        VolumePaid
        VolumeGiven
        Volume
    end
    
    methods
        function obj = MarketAssessmentValue(settlement, open, close, high, low, volumePaid, volumeGiven, volume)       
           
            if (nargin == 0)
                settlement = [];
                open = [];
                close = [];
                low = [];
                volumePaid = [];
                volumeGiven = [];
                volume = [];
            end
            
            obj.Settlement = settlement;
            obj.Open = open;
            obj.Close = close;
            obj.High = high;
            obj.Low = low;
            obj.VolumePaid = volumePaid;
            obj.VolumeGiven = volumeGiven;
            obj.Volume = volume;
        end
        
    end
end

