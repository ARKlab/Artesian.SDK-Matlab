cfg = ArtesianServiceConfig("baseaddr","apikey");

mds = MarketDataService(cfg);
qs = QueryService(cfg);


id = MarketDataIdentifier("testProviderBidAsk","testMarketDataBidAsk");

data = MarketDataEntityInput("testProviderBidAsk", ...
    "testMarketDataBidAsk", ...
    "Day", ...
    "CET", ...
    AggregationRuleEnum.Undefined, ...
    MarketDataTypeEnum.BidAsk ...
);

% md = mds.MarketData.GetByProviderName(id);

if(~isempty(md))
    mds.MarketData.Delete(md.MarketDataId);
end

mds.MarketData.Create(data);

md = mds.MarketData.GetByProviderName(id);

rows = [];
rows = [rows {{"2022-01-01T00:00:00" {{"Jan-22" {{"bestBidPrice" 1}, {"bestBidQuantity" 5}}}}}}];
rows = [rows {{"2022-01-02T00:00:00" {{"Jan-22" {{"bestBidPrice" 2}, {"bestBidQuantity" 6}}}}}}];
rows = [rows {{"2022-01-03T00:00:00" {{"Jan-22" {{"bestBidPrice" 3}, {"bestBidQuantity" 7}}}}}}];
rows = [rows {{"2022-01-04T00:00:00" {{"Jan-22" {{"bestBidPrice" 4}, {"bestBidQuantity" 8}}}}}}];

data = UpsertCurveDataBidAsk(id, "CET", "2022-01-01T00:00:00Z", rows);
mds.UpsertCurve.Upsert(data);

test1 = qs.CreateBidAsk() ...
    .ForMarketData([md.MarketDataId]) ...
    .ForProducts(["Jan-22"]) ...
    .InAbsoluteDateRange("2022-01-01","2022-01-06") ...
    .Execute();

assert(cell2mat(test1.BBP(1,1))==1, "Wrong value");
assert(cell2mat(test1.BBP(2,1))==2, "Wrong value");
assert(cell2mat(test1.BBP(3,1))==3, "Wrong value");
assert(cell2mat(test1.BBP(4,1))==4, "Wrong value");
assert(isempty(cell2mat(test1.BBP(5,1))), "Wrong value");

dataDelete = DeleteCurveDataBidAsk(id, "CET", "Jan-22", "2022-01-04T00:00:00", "2022-01-05T00:00:00");
mds.DeleteCurve.Delete(dataDelete);

test2 = qs.CreateBidAsk() ...
    .ForMarketData([md.MarketDataId]) ...
    .ForProducts(["Jan-22"]) ...
    .InAbsoluteDateRange("2022-01-01","2022-01-06") ...
    .Execute();

assert(cell2mat(test2.BBP(1,1))==1, "Wrong value");
assert(cell2mat(test2.BBP(2,1))==2, "Wrong value");
assert(cell2mat(test2.BBP(3,1))==3, "Wrong value");
assert(isempty(cell2mat(test2.BBP(4,1))), "Wrong value");
assert(isempty(cell2mat(test2.BBP(5,1))), "Wrong value");

dataDelete = DeleteCurveDataBidAsk(id, "CET", "Jan-22");
mds.DeleteCurve.Delete(dataDelete);

test3 = qs.CreateBidAsk() ...
    .ForMarketData([md.MarketDataId]) ...
    .ForProducts(["Jan-22"]) ...
    .InAbsoluteDateRange("2022-01-01","2022-01-06") ...
    .Execute();

assert(isempty(cell2mat(test3.BBP(1,1))), "Wrong value");
assert(isempty(cell2mat(test3.BBP(2,1))), "Wrong value");
assert(isempty(cell2mat(test3.BBP(3,1))), "Wrong value");
assert(isempty(cell2mat(test3.BBP(4,1))), "Wrong value");
assert(isempty(cell2mat(test3.BBP(5,1))), "Wrong value");
