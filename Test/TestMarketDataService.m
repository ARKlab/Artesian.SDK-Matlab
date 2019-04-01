cfg = ArtesianServiceConfig("baseaddr","apikey");
qs = MarketDataService(cfg);

res=qs.ReadCurveRange(100042422, 1, 1000);
struct2table(res.Data)


res=qs.ReadCurveRange(100042422, 1, 1000, [],"2016-12-20" ,"2019-03-12");
struct2table(res.Data)