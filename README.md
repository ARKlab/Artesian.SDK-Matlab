![image](http://www.ark-energy.eu/wp-content/uploads/ark-dark.png)
# Artesian.SDK

This Library provides read access to the Artesian API

## Getting Started
### Installation
You can install the toolbox directly from the MatLab community [add-ons](https://www.mathworks.com/matlabcentral/fileexchange/71098-artesian-sdk).

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
Extraction window types  for queries.

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

To list MarketData curves
```MATLAB
page = 1;
pageSize = 100;
res = mds.ReadCurveRange(100000004, page, pageSize);
```


## Links
* [Github](https://github.com/ARKlab/Artesian.SDK-Matlab)
* [Ark Energy](http://www.ark-energy.eu/)
* [Artesian Portal](https://portal.artesian.cloud)
