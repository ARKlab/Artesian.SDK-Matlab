cfg = ArtesianServiceConfig("baseaddr","apikey");

mds = MarketDataService(cfg);
qs = QueryService(cfg);


id = MarketDataIdentifier("testProviderVersioned","testMarketDataVersioned");

data = MarketDataEntityInput("testProviderVersioned", ...
    "testMarketDataVersioned", ...
    "Day", ...
    "CET", ...
    AggregationRuleEnum.AverageAndReplicate, ...
    MarketDataTypeEnum.VersionedTimeSerie ...
);

% md = mds.MarketData.GetByProviderName(id);

if(~isempty(md))
    mds.MarketData.Delete(md.MarketDataId);
end

mds.MarketData.Create(data);

md = mds.MarketData.GetByProviderName(id);

rows = [];
rows = [rows {{"2022-01-01T00:00:00", 1}}];
rows = [rows {{"2022-01-02T00:00:00", 2}}];
rows = [rows {{"2022-01-03T00:00:00", 3}}];
rows = [rows {{"2022-01-04T00:00:00", 4}}];

data = UpsertCurveDataVersioned(id, "2022-01-01T00:00:00", "CET", "2022-01-01T00:00:00Z", rows);
mds.UpsertCurve.Upsert(data);

query = qs.CreateVersioned() ...
    .ForMarketData([md.MarketDataId]) ...
    .InAbsoluteDateRange("2022-01-01","2022-01-06") ...
    .InTimeZone("CET") ...
    .InGranularity(GranularityEnum.Day);

test1 = query.ForLastNVersions(1).Execute();

assert(cell2mat(test1.D(1,1))==1, "Wrong value");
assert(cell2mat(test1.D(2,1))==2, "Wrong value");
assert(cell2mat(test1.D(3,1))==3, "Wrong value");
assert(cell2mat(test1.D(4,1))==4, "Wrong value");
assert(isempty(cell2mat(test1.D(5,1))), "Wrong value");

dataDelete = DeleteCurveDataVersioned(id, "2022-01-01T00:00:00", "CET", "2022-01-04T00:00:00", "2022-01-05T00:00:00");
mds.DeleteCurve.Delete(dataDelete);

test2 = query.ForLastNVersions(1).Execute();

assert(cell2mat(test2.D(1,1))==1, "Wrong value");
assert(cell2mat(test2.D(2,1))==2, "Wrong value");
assert(cell2mat(test2.D(3,1))==3, "Wrong value");
assert(isempty(cell2mat(test2.D(4,1))), "Wrong value");
assert(isempty(cell2mat(test2.D(5,1))), "Wrong value");

dataDelete = DeleteCurveDataVersioned(id, "2022-01-01T00:00:00", "CET");
mds.DeleteCurve.Delete(dataDelete);

test3 = query.ForLastNVersions(1).Execute();

assert(isempty(test3), "Wrong value");

