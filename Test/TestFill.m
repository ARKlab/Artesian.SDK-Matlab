cfg = ArtesianServiceConfig("baseaddr","apikey");
qs = QueryService(cfg);


%Actual
testA = qs.CreateActual() ...
    .ForMarketData([100001250]) ...
    .InAbsoluteDateRange("2021-01-01","2021-01-02") ...
    .InTimeZone("UTC") ...
    .InGranularity(GranularityEnum.Hour) ...
    .WithFillLatestValue("P0Y0M1D") ...
    .Execute()

%BidAsk
b = BidAskValue(12,[],[],[],11,[]);

testB = qs.CreateBidAsk() ...
.ForMarketData([100219392]) ...
.ForProducts(["D+1","Feb-18"]) ...
.InAbsoluteDateRange("2018-01-01","2018-01-02") ...
.WithFillCustomValue(b) ...
.Execute()


%Versioned
testV = qs.CreateVersioned() ...
    .ForMarketData([100042422,100042283,100042285,100042281,100042287,100042291,100042289]) ...
    .InAbsoluteDateRange("2018-01-01","2018-01-02") ...
    .InTimeZone("UTC") ...
    .InGranularity(GranularityEnum.Hour)...
    .WithFillCustomValue(5);


testV.ForMUV().Execute()


%Mas
% m = MarketAssessmentValue(3,[],[],[],[],[],[],[]);
% 
% testM = qs.CreateMarketAssessment() ...
%         .ForMarketData([100000032,100000043]) ...
%         .ForProducts(["D+1","Feb-18"]) ...
%         .InAbsoluteDateRange("2018-01-01","2018-01-02") ...
%         .Execute()