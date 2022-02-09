classdef MarketDataTypeEnum < int32
    enumeration
        ActualTimeSerie (0),
        VersionedTimeSerie (1),
        MarketAssessment (2),
        Auction (3),
        BidAsk (4)
    end
end