![image](http://www.ark-energy.eu/wp-content/uploads/ark-dark.png)

# Artesian.SDK

This Library provides read access to the Artesian API

## Getting Started

### Installation

You can install the toolbox directly from the [![Matlab File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/71098-artesian-sdk).

Alternatively, to install this package go to the [release page](https://github.com/ARKlab/Artesian.SDK-Matlab/releases) and download the **Artesian.SDK.mltbx** file and double click on it to
install in Matlab.

## How to use

The Artesian.SDK instance can be configured using API-Key authentication

```MATLAB
cfg = ArtesianServiceConfig("https://fake-artesian-env/", "{api-key}");
```

## QueryService

Using the ArtesianServiceConfig we create an instance of the QueryService which is used to create Actual, Versioned and Market Assessment time series queries

### Actual Time Series

```MATLAB
qs = QueryService(cfg);
data = qs.CreateActual() ...
       .ForMarketData([100000001,100000002,100000003]) ...
       .InAbsoluteDateRange("2018-01-01","2018-01-02") ...
       .InTimeZone("UTC") ...
       .InGranularity(GranularityEnum.Hour) ...
       .Execute()

```

To construct an Actual Time Series the following must be provided.

<table>
  <tr><th>Actual Query</th><th>Description</th></tr>
  <tr><td>Market Data ID</td><td>Provide a market data id or set of market data id's to query</td></tr>
  <tr><td>Time Granularity</td><td>Specify the granularity type</td></tr>
  <tr><td>Time Extraction Window</td><td>An extraction time window for data to be queried</td></tr>
</table>

[Go to Time Extraction window section](#artesian-sdk-extraction-windows)

### Versioned Time Series

```MATLAB

qs = QueryService(cfg);
q = qs.CreateVersioned() ...
       .ForMarketData([100000004,100000005,100000006]) ...
       .InAbsoluteDateRange("2018-01-01","2018-01-02") ...
       .InTimeZone("UTC") ...
       .InGranularity(GranularityEnum.Hour);


q.ForMUV().Execute()
q.ForLastNVersions(2).Execute()
q.ForLastOfDays("2019-03-12","2019-03-16").Execute()
q.ForLastOfDays("P0Y0M-2D","P0Y0M2D").Execute()
q.ForLastOfDays("P0Y0M-2D").Execute()
q.ForLastOfMonths("2019-03-12","2019-03-16").Execute()
q.ForLastOfMonths("P0Y-1M0D","P0Y1M0D").Execute()
q.ForLastOfMonths("P0Y-1M0D").Execute()
q.ForVersion("2019-03-12T14:30:00").Execute()
```

To construct a Versioned Time Series the following must be provided.

<table>
  <tr><th>Versioned Query</th><th>Description</th></tr>
  <tr><td>Market Data ID</td><td>Provide a market data id or set of market data id's to query</td></tr>
  <tr><td>Time Granularity</td><td>Specify the granularity type</td></tr>
  <tr><td>Versioned Time Extraction Window</td><td>Versioned extraction time window</td></tr>
  <tr><td>Time Extraction Window</td><td>An extraction time window for data to be queried</td></tr>
</table>

[Go to Time Extraction window section](#artesian-sdk-extraction-windows)

### Market Assessment Time Series

```MATLAB
qs = QueryService(cfg);
data = qs.CreateMarketAssessment() ...
       .ForMarketData([100000007,100000008]) ...
       .ForProducts(["D+1","Feb-18"]) ...
       .InAbsoluteDateRange("2018-01-01","2018-01-02") ...
       .Execute()
```

To construct a Market Assessment Time Series the following must be provided.

<table>
  <tr><th>Mas Query</th><th>Description</th></tr>
  <tr><td>Market Data ID</td><td>Provide a market data id or set of market data id's to query</td></tr>
  <tr><td>Product</td><td>Provide a product or set of products</td></tr>
  <tr><td>Time Extraction Window</td><td>An extraction time window for data to be queried </td></tr>
</table>

[Go to Time Extraction window section](#artesian-sdk-extraction-windows)

## Auction Time Series

```matlab
qs = QueryService(cfg);

data = qs.CreateAuction() ...
  .ForMarketData([100000001]) ...
  .InAbsoluteDateRange("2020-03-01", "2020-04-01") ...
  .Execute();
```

To construct an Auction Time Series the following must be provided.

| Auction Query          | Description                                                  |
| ---------------------- | ------------------------------------------------------------ |
| Market Data ID         | Provide a market data id or set of market data id's to query |
| Time Extraction Window | An extraction time window for data to be queried             |

### Artesian SDK Extraction Windows

Extraction window types for queries.

Date Range

```MATLAB
 .InAbsoluteDateRange("2018-08-01", "2018-08-10")
```

Relative Interval

```MATLAB
 .InRelativeInterval(RelativeIntervalEnum.RollingMonth)
```

Period

```MATLAB
 .InRelativePeriod("P5D")
```

Period Range

```MATLAB
 .InRelativePeriodRange("P-3D", "P10D")
```

## MarketData Service

Using the ArtesianServiceConfig `cfg` we create an instance of the MarketDataService which is used to retrieve MarketData infos.

```MATLAB

mds = MarketDataService(cfg);

```

### MarketData Acl

#### AddRoles

```MATLAB
user = AclPrincipal(PrincipalTypeEnum.User, "test@ark-energy.eu");
mds.Acl.AddRoles(Acl("/system/marketdata/", {AclRoles("Reader", user)}))
```

#### RemoveRoles

```MATLAB
user = AclPrincipal(PrincipalTypeEnum.User, "test@ark-energy.eu");
mds.Acl.RemoveRoles(Acl("/system/marketdata/", {AclRoles("Reader", user)}))
```

#### Get

```MATLAB
mds.Acl.GetRoles(
  1, % page
  10, % pageSize
  {"test@ark-energy.eu"} % principalIds
);

mds.Acl.ReadRolesByPath(
  "/system/marketdata/", % path
);
```

### MarketData Admin

#### Create

```MATLAB
mds.Admin.Create(
  AuthGroup("Test group", {"test@ark-energy.eu", "test2@ark-energy.eu"})
);
```

#### Update

```MATLAB
mds.Admin.Update(
  1000, % groupId
  AuthGroup("Test group", {"test@ark-energy.eu", "test2@ark-energy.eu"})
);
```

#### Remove

```MATLAB
mds.Admin.Remove(
  1000 % groupId
);
```

#### Get

```MATLAB
mds.Admin.GetById(
  1000 % groupId
);

mds.Admin.Get(
  1, % page
  10 % pageSize
);

mds.Admin.ReadUserPrincipals(
  "test@ark-energy.eu"
);
```

### MarketData ApiKey

#### Create

```MATLAB
mds.ApiKey.Create(
  ApiKey("2020-02-10T00:00:00Z", "Api key Description")
);
```

#### Delete

```MATLAB
mds.ApiKey.Delete(
  1000 % apiKeyId
);
```

#### Get

```MATLAB
mds.ApiKey.GetById(
  1000 % apiKeyId
);

mds.ApiKey.GetByUserId(
  1, % page
  10, % pageSize
  "test@ark-energy.eu"
);

```

### MarketData CustomFilter

#### Create

```MATLAB

filter = {};
filter.test = {"1"};
filter.test2 = {"2"};
mds.CustomFilter.Create(CustomFilter("test filter2","search test", filter))
```

#### Update

```MATLAB
filter = {};
filter.type = {"VersionedTimeSerie"};
filter.providerName = {"JAO"};

mds.CustomFilter.Update(
  1000, % filterId
  CustomFilter("filter name", "search text", filter)
);
```

#### Delete

```MATLAB
mds.CustomFilter.Delete(
  1000 % filterId
);
```

#### Get

```MATLAB
mds.CustomFilter.GetById(
  1000 % filterId
);

mds.CustomFilter.Get(
  1, % page
  10 % pageSize
);
```

### MarketData SearchFacet

```MATLAB
filter = {};
filter.page = 1;
filter.pageSize = 10;
filter.searchText = "Search";
filter.sorts = "MarketDataName asc";
innerFilter = {}
innerFilter.ProviderName = "JAO"
filter.filters = innerFilter;

mds.SearchFacet.Search(
  filter
);
```

### MarketData TimeTransform

#### Create

```MATLAB
mds.TimeTransform.Create(TimeTransform("MatTest", TransformTypeEnum.SimpleShift, "1D", "1D","3D"))
```

#### Update

```MATLAB
mds.TimeTransform.Update(
  1000, % timeTransformId
  TimeTransform("MatTest", TransformTypeEnum.SimpleShift, "1D", "1D","3D")
);
```

#### Delete

```MATLAB
mds.TimeTransform.Delete(
  1000 % timeTransformId
);
```

#### Get

```MATLAB
mds.TimeTransform.GetById(
  1000 % timeTransformId
);

mds.TimeTransform.Get(
  1, % page
  10, % pageSize
  true % userDefined
);
```

### MarketData MarketDataRegistry

#### Create

```MATLAB
data = MarketDataEntityInput("testMatlab", ...
    "testmatlabcurveVer", ...
    "Day", ...
    "CET", ...
    AggregationRuleEnum.Undefined, ...
    MarketDataTypeEnum.ActualTimeSerie ...
);

mds.MarketData.Create(data);
```

#### Update

```MATLAB
data = MarketDataEntityInput("testMatlab", ...
    "testmatlabcurveVer", ...
    "Day", ...
    "CET", ...
    AggregationRuleEnum.Undefined, ...
    MarketDataTypeEnum.ActualTimeSerie ...
);
data.MarketDataId = "100000001";

mds.MarketData.Update(data);
```

#### Delete

```MATLAB
mds.MarketData.Delete(
  100000001 % marketDataId
);
```

#### Get

```MATLAB
mds.MarketData.GetById(
  100000001 % marketDataId
);

mds.MarketData.GetByProviderName(
  MarketDataIdentifier("Provider","CurveName")
);

page = 1;
pageSize = 100;
res = mds.MarketData.ReadCurveRange(100000004, page, pageSize);
```

### MarketData UpsertCurve

#### Upsert Actual

```MATLAB
rows = [];
rows = [rows {{"2022-01-01T00:00:00", 1}}];
rows = [rows {{"2022-01-02T00:00:00", 2}}];

id = MarketDataIdentifier("ArkLab","ActualCurve");
data = UpsertCurveDataActual(id, "CET", "2022-01-01T00:00:00Z", rows);
mds.UpsertCurve.Upsert(data);
```

#### Upsert Versioned

```MATLAB
rows = [];
rows = [rows {{"2022-01-01T00:00:00", 1}}];
rows = [rows {{"2022-01-02T00:00:00", 2}}];

id = MarketDataIdentifier("ArkLab","VersionedCurve");
data = UpsertCurveDataVersioned(id, "2022-01-01T00:00:00","CET", "2022-01-01T00:00:00Z", rows);
mds.UpsertCurve.Upsert(data);
```

#### Upsert MarketAssessment

Market assessment product fields:

- settlement
- open
- close
- high
- low
- volumePaid
- volumeGiven
- volume

```MATLAB
rows = [];
rows = [rows {{"2022-01-01T00:00:00" {{"Jan-22" {{"open" 6}, {"close" 7}}}}}}];

id = MarketDataIdentifier("ArkLab","MarketAssessmentCurve");
data = UpsertCurveDataMarketAssessment(id, "CET", "2022-01-01T00:00:00Z", rows);
mds.UpsertCurve.Upsert(data);
```

#### Upsert BidAsk

BidAsk product fields:

- bestBidPrice
- bestAskPrice
- bestBidQuantity
- bestAskQuantity
- lastPrice
- lastQuantity

```MATLAB
rows = [];
rows = [rows {{"2022-01-01T00:00:00" {{"Jan-22" {{"bestBidPrice" 6}, {"bestBidQuantity" 7}}}}}}];

id = MarketDataIdentifier("ArkLab","BidAskCurve");
data = UpsertCurveDataBidAsk(id, "CET", "2022-01-01T00:00:00Z", rows);
mds.UpsertCurve.Upsert(data);
```

#### Upsert Auction

```MATLAB
rows = [];
rows = [rows {{"2022-01-01T00:00:00", AuctionBid("2022-01-01T00:00:00", {{1 1}}, {{2 2}})}}];

id = MarketDataIdentifier("ArkLab", "AuctionCurve");
data = UpsertCurveDataAuction(id, "CET", "2022-01-01T00:00:00Z", rows);
```

### MarketData DeleteCurve

#### Delete Actual

```MATLAB
id = MarketDataIdentifier("ArkLab","ActualCurve");
data = DeleteCurveDataActual(id, "CET", "2022-01-01T00:00:00", "2022-01-02T00:00:00");
mds.DeleteCurve.Delete(data);
```
To delete the whole range, just call the `DeleteCurveDataActual`, without date range

```MATLAB
id = MarketDataIdentifier("ArkLab","ActualCurve");
data = DeleteCurveDataActual(id, "CET");
mds.DeleteCurve.Delete(data);
```

#### Delete Versioned

```MATLAB
id = MarketDataIdentifier("ArkLab","VersionedCurve");
data = DeleteCurveDataVersioned(id, "2022-01-01T00:00:00", "CET", "2022-01-01T00:00:00", "2022-01-02T00:00:00");
mds.DeleteCurve.Delete(data);
```
To delete the whole range, just call the `DeleteCurveDataVersioned`, without date range

```MATLAB
id = MarketDataIdentifier("ArkLab","VersionedCurve");
data = DeleteCurveDataVersioned(id, "2022-01-01T00:00:00", "CET");
mds.DeleteCurve.Delete(data);
```

#### Delete MarketAssessment

```MATLAB
id = MarketDataIdentifier("ArkLab","MarketAssessmentCurve");
product = {"Jan-22"};

data = DeleteCurveDataMarketAssessment(id, "CET", product, "2022-01-01T00:00:00", "2022-01-02T00:00:00");
mds.DeleteCurve.Delete(data);
```
To delete the whole range, just call the `DeleteCurveDataMarketAssessment`, without date range

```MATLAB
id = MarketDataIdentifier("ArkLab","MarketAssessmentCurve");
data = DeleteCurveDataMarketAssessment(id, "CET", product);
mds.DeleteCurve.Delete(data);
```

#### Delete BidAsk

```MATLAB
id = MarketDataIdentifier("ArkLab","BidAskCurve");
product = {"Jan-22"};

data = DeleteCurveDataBidAsk(id, "CET", product, "2022-01-01T00:00:00", "2022-01-02T00:00:00");
mds.DeleteCurve.Delete(data);
```
To delete the whole range, just call the `DeleteCurveDataBidAsk`, without date range

```MATLAB
id = MarketDataIdentifier("ArkLab","BidAskCurve");
data = DeleteCurveDataBidAsk(id, "CET", product);
mds.DeleteCurve.Delete(data);
```

#### Delete Auction

```MATLAB
id = MarketDataIdentifier("ArkLab", "AuctionCurve");
data = DeleteCurveDataAuction(id, "CET", "2022-01-01T00:00:00", "2022-01-02T00:00:00");
```
To delete the whole range, just call the `DeleteCurveDataAuction`, without date range

```MATLAB
id = MarketDataIdentifier("ArkLab","AuctionCurve");
data = DeleteCurveDataAuction(id, "CET");
mds.DeleteCurve.Delete(data);
```

## GMEPublicOffer Service

Using the ArtesianServiceConfig `cfg` we create an instance of the GMEPublicOfferService which is used to retrieve MarketData infos.

```MATLAB

gme = GMEPublicOfferService(cfg);

```

### GMEPublicOfferQuery

Create a GMEPublicOfferQuery using the GMEPublicOfferService.

```matlab
gme.CreateGMEPublicOfferQuery() ...
   .ForDate("2020-04-01") ...
   .ForPurpose(Purpose.BID) ...
   .ForStatus(Status.ACC) ...
   .Execute()
```

#### GME Public Offer Required Filters

| GME Public Offer Query | Description                                   |
| ---------------------- | --------------------------------------------- |
| ForDate                | Provide a date for extraction                 |
| ForPurpose             | Provide a purpose (BID or OFF) for extraction |
| ForStatus              | Provide a status for extraction               |

#### GME Public Offer Optional Filters

| GME Public Offer Query | Description                                          |
| ---------------------- | ---------------------------------------------------- |
| ForOperator            | Provide a list of Operators (string[])               |
| ForUnit                | Provide a list of Units (string[])                   |
| ForMarket              | Provide a list of Markets (Market[])                 |
| ForScope               | Provide a list of Scopes (Scope[])                   |
| ForBAType              | Provide a list of BATypes (BAType[])                 |
| ForZone                | Provide a list of Zones (Zone[])                     |
| ForUnitType            | Provide a list of UnitTypes (UnitType[])             |
| ForGenerationType      | Provide a list of GenerationTypes (GenerationType[]) |
| WithPagination         | Provide paging info (uint32 page, uint32 pageSize)   |

## Links

- [Github](https://github.com/ARKlab/Artesian.SDK-Matlab)
- [Ark Energy](http://www.ark-energy.eu/)
- [Artesian Portal](https://portal.artesian.cloud)
