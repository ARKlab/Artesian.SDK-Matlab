cfg = ArtesianServiceConfig("baseaddr","apikey");
qs = QueryService(cfg);

%AbsoluteRange - TimeZone - MultiIds - MUV
test1 = qs.CreateVersioned() ...
    .ForMarketData([100042422,100042283,100042285,100042281,100042287,100042291,100042289]) ...
    .InAbsoluteDateRange("2018-01-01","2018-01-02") ...
    .InTimeZone("UTC") ...
    .InGranularity(GranularityEnum.Hour);


test1.ForMUV().Execute()
test1.ForLastNVersions(2).Execute()
test1.ForLastOfDays("2019-03-12","2019-03-16").Execute()
test1.ForLastOfDays("P0Y0M-2D","P0Y0M2D").Execute()
test1.ForLastOfDays("P0Y0M-2D").Execute()
test1.ForLastOfMonths("2019-03-12","2019-03-16").Execute()
test1.ForLastOfMonths("P0Y-1M0D","P0Y1M0D").Execute()
test1.ForLastOfMonths("P0Y-1M0D").Execute()
test1.ForVersion("2019-03-12T14:30:00").Execute()
test1.ForMostRecent("2021-09-14T20:00:00","2021-09-14T22:00:00").Execute()