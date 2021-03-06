cfg = ArtesianServiceConfig("baseAddress", "apiKey");
qs = GMEPublicOfferService(cfg);

%AbsoluteRange - TimeZone - MultiIds
test1 = qs.CreateGMEPublicOfferQuery() ...
    .ForDate("2020-04-01") ...
    .ForPurpose(Purpose.BID) ...
    .ForStatus(Status.ACC) ...
    .Execute()
