cfg = ArtesianServiceConfig("baseaddr","apikey");

mds = MarketDataService(cfg);
qs = QueryService(cfg);


id = MarketDataIdentifier("testProviderMarketAssessment","testMarketDataMarketAssessment");

data = MarketDataEntityInput("testProviderMarketAssessment", ...
    "testMarketDataMarketAssessment", ...
    "Day", ...
    "CET", ...
    AggregationRuleEnum.Undefined, ...
    MarketDataTypeEnum.MarketAssessment ...
);

% md = mds.MarketData.GetByProviderName(id);

if(~isempty(md))
    mds.MarketData.Delete(md.MarketDataId);
end

mds.MarketData.Create(data);

md = mds.MarketData.GetByProviderName(id);

rows = [];
rows = [rows {{"2022-01-01T00:00:00" {{"Jan-22" {{"open" 1}, {"close" 5}}}}}}];
rows = [rows {{"2022-01-02T00:00:00" {{"Jan-22" {{"open" 2}, {"close" 6}}}}}}];
rows = [rows {{"2022-01-03T00:00:00" {{"Jan-22" {{"open" 3}, {"close" 7}}}}}}];
rows = [rows {{"2022-01-04T00:00:00" {{"Jan-22" {{"open" 4}, {"close" 8}}}}}}];

data = UpsertCurveDataMarketAssessment(id, "CET", "2022-01-01T00:00:00Z", rows);
mds.UpsertCurve.Upsert(data);

test1 = qs.CreateMarketAssessment() ...
    .ForMarketData([md.MarketDataId]) ...
    .ForProducts(["Jan-22"]) ...
    .InAbsoluteDateRange("2022-01-01","2022-01-06") ...
    .Execute();

assert(cell2mat(test1.O(1,1))==1, "Wrong value");
assert(cell2mat(test1.O(2,1))==2, "Wrong value");
assert(cell2mat(test1.O(3,1))==3, "Wrong value");
assert(cell2mat(test1.O(4,1))==4, "Wrong value");
assert(isempty(cell2mat(test1.O(5,1))), "Wrong value");

dataDelete = DeleteCurveDataMarketAssessment(id, "CET", "Jan-22", "2022-01-04T00:00:00", "2022-01-05T00:00:00");
mds.DeleteCurve.Delete(dataDelete);

test2 = qs.CreateMarketAssessment() ...
    .ForMarketData([md.MarketDataId]) ...
    .ForProducts(["Jan-22"]) ...
    .InAbsoluteDateRange("2022-01-01","2022-01-06") ...
    .Execute();

assert(cell2mat(test2.O(1,1))==1, "Wrong value");
assert(cell2mat(test2.O(2,1))==2, "Wrong value");
assert(cell2mat(test2.O(3,1))==3, "Wrong value");
assert(isempty(cell2mat(test2.O(4,1))), "Wrong value");
assert(isempty(cell2mat(test2.O(5,1))), "Wrong value");

dataDelete = DeleteCurveDataMarketAssessment(id, "CET", "Jan-22");
mds.DeleteCurve.Delete(dataDelete);

test3 = qs.CreateMarketAssessment() ...
    .ForMarketData([md.MarketDataId]) ...
    .ForProducts(["Jan-22"]) ...
    .InAbsoluteDateRange("2022-01-01","2022-01-06") ...
    .Execute();

assert(isempty(cell2mat(test3.O(1,1))), "Wrong value");
assert(isempty(cell2mat(test3.O(2,1))), "Wrong value");
assert(isempty(cell2mat(test3.O(3,1))), "Wrong value");
assert(isempty(cell2mat(test3.O(4,1))), "Wrong value");
assert(isempty(cell2mat(test3.O(5,1))), "Wrong value");
