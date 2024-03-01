cfg = ArtesianServiceConfig("baseaddr","apikey");

mds = MarketDataService(cfg);
qs = QueryService(cfg);


id = MarketDataIdentifier("testProviderAuction","testMarketDataAuction");

data = MarketDataEntityInput("testProviderAuction", ...
    "testMarketDataAuction", ...
    "Day", ...
    "CET", ...
    AggregationRuleEnum.AverageAndReplicate, ...
    MarketDataTypeEnum.Auction ...
);

% md = mds.MarketData.GetByProviderName(id);

if(~isempty(md))
    mds.MarketData.Delete(md.MarketDataId);
end

mds.MarketData.Create(data);

md = mds.MarketData.GetByProviderName(id);

rows = [];
rows = [rows {{"2022-01-01T00:00:00", AuctionBid("2022-01-01T00:00:00", {{1 1}}, {{5 5}})}}];
rows = [rows {{"2022-01-02T00:00:00", AuctionBid("2022-01-02T00:00:00", {{2 2}}, {{6 6}})}}];
rows = [rows {{"2022-01-03T00:00:00", AuctionBid("2022-01-03T00:00:00", {{3 3}}, {{7 7}})}}];
rows = [rows {{"2022-01-04T00:00:00", AuctionBid("2022-01-04T00:00:00", {{4 5}}, {{8 8}})}}];

data = UpsertCurveDataAuction(id, "CET", "2022-01-01T00:00:00Z", rows);
mds.UpsertCurve.Upsert(data);

test1 = qs.CreateAuction() ...
    .ForMarketData([md.MarketDataId]) ...
    .InAbsoluteDateRange("2022-01-01","2022-01-06") ...
    .Execute();

assert(test1.D(1,1)==1, "Wrong value");
assert(test1.D(3,1)==2, "Wrong value");
assert(test1.D(5,1)==3, "Wrong value");
assert(test1.D(7,1)==4, "Wrong value");
assert(length(test1.D)==8, "Wrong value");

dataDelete = DeleteCurveDataAuction(id, "CET", "2022-01-04T00:00:00", "2022-01-05T00:00:00");
mds.DeleteCurve.Delete(dataDelete);

test2 = qs.CreateAuction() ...
    .ForMarketData([md.MarketDataId]) ...
    .InAbsoluteDateRange("2022-01-01","2022-01-06") ...
    .Execute();

assert(test2.D(1,1)==1, "Wrong value");
assert(test2.D(3,1)==2, "Wrong value");
assert(test2.D(5,1)==3, "Wrong value");
assert(length(test2.D)==6, "Wrong value");

dataDelete = DeleteCurveDataAuction(id, "CET");
mds.DeleteCurve.Delete(dataDelete);

test3 = qs.CreateAuction() ...
    .ForMarketData([md.MarketDataId]) ...
    .InAbsoluteDateRange("2022-01-01","2022-01-06") ...
    .Execute();

assert(isempty(test3), "Wrong value");
