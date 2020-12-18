classdef BidAskValue
    %BidAskValue Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        BestBidPrice
        BestAskPrice
        BestBidQuantity
        BestAskQuantity
        LastPrice
        LastQuantity
    end
    
    methods
        function obj = BidAskValue(bestBidPrice, bestAskPrice, bestBidQuantity, bestAskQuantity, lastPrice, lastQuantity)       
           
            if (nargin == 0)
                bestBidPrice = [];
                bestAskPrice = [];
                bestBidQuantity = [];
                bestAskQuantity = [];
                lastPrice = [];
                lastQuantity = [];
            end
            
            obj.BestBidPrice = bestBidPrice;
            obj.BestAskPrice = bestAskPrice;
            obj.BestBidQuantity = bestBidQuantity;
            obj.BestAskQuantity = bestAskQuantity;
            obj.LastPrice = lastPrice;
            obj.LastQuantity = lastQuantity;
        end
        
    end
end

