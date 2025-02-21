classdef GMEPublicOfferQuery

    properties (Access = private)
        client ClientArtesian
        policy PolicyConfig
        date string
        purpose Purpose
        status Status
        operator string
        unit string
        market Market
        scope Scope
        baType BAType
        zone Zone
        unitType UnitType
        generationType GenerationType
        page uint32
        pageSize uint32
        granularity string
        offerType string
        blockId string
        period uint32
        minimumAcceptanteRatio double
    end

    methods

        function obj = GMEPublicOfferQuery(client, policy)
            obj.client = client;
            obj.policy = policy;
        end

        function obj = ForDate(obj, date)
            obj.date = date;
        end

        function obj = ForPurpose(obj, purpose)
            obj.purpose = purpose;
        end

        function obj = ForStatus(obj, status)
            obj.status = status;
        end

        function obj = ForOperator(obj, operator)
            obj.operator = operator;
        end

        function obj = ForUnit(obj, unit)
            obj.unit = unit;
        end

        function obj = ForMarket(obj, market)
            obj.market = market;
        end

        function obj = ForScope(obj, scope)
            obj.scope = scope;
        end

        function obj = ForBAType(obj, baType)
            obj.baType = baType;
        end

        function obj = ForZone(obj, zone)
            obj.zone = zone;
        end

        function obj = ForUnitType(obj, unitType)
            obj.unitType = unitType;
        end

        function obj = ForGenerationType(obj, generationType)
            obj.generationType = generationType;
        end

        function obj = WithPagination(obj, page, pageSize)
            obj.page = page;
            obj.pageSize = pageSize;
        end

        function res = Execute(obj)
            url = obj.buildRequest();
            res = retry(obj.client, url, obj.policy.RetryWaitTimeMilliSec / 1000, obj.policy.RetryCount);
        end

    end

    methods (Access = private)

        function url = buildRequest(obj)
            obj.validateQuery();

            url = "/extract/" + char(obj.date) + "/" + char(obj.purpose) + "/" + char(obj.status) + "?_=1";

            if (~isempty(obj.operator))
                url = url + "&operators=" + urlencode(strjoin(string(obj.operator), ','));
            end

            if (~isempty(obj.unit))
                url = url + "&unit=" + urlencode(strjoin(string(obj.unit), ','));
            end

            if (~isempty(obj.market))
                url = url + "&market=" + urlencode(strjoin(string(obj.market), ','));
            end

            if (~isempty(obj.scope))
                url = url + "&scope=" + urlencode(strjoin(string(obj.scope), ','));
            end

            if (~isempty(obj.baType))
                url = url + "&baType=" + urlencode(strjoin(string(obj.baType), ','));
            end

            if (~isempty(obj.zone))
                url = url + "&zone=" + urlencode(strjoin(string(obj.zone), ','));
            end

            if (~isempty(obj.unitType))
                url = url + "&unitType=" + urlencode(strjoin(string(obj.unitType), ','));
            end

            if (~isempty(obj.generationType))
                url = url + "&generationType=" + urlencode(strjoin(string(obj.generationType), ','));
            end

            if (~isempty(obj.page))
                url = url + "&page=" + urlencode(string(obj.page));
            end

            if (~isempty(obj.pageSize))
                url = url + "&pageSize=" + urlencode(string(obj.pageSize));
            end

        end

        function validateQuery(obj)

            if (isempty(obj.date))
                error("Extraction date must be provided. Use .ForDate()")
            end

            if (isempty(obj.purpose))
                error("Extraction purpose must be provided. Use .ForPurpose()")
            end

            if (isempty(obj.status))
                error("Extraction status must be provided. Use .ForStatus()")
            end

        end

    end

end

function out = retry(client, url, wait, retries)

    try
        out = client.Exec("get", url);
    catch ex

        if (retries <= 0)
            rethrow(ex);
        else
            pause(obj.policy.RetryWaitTimeMilliSec / 1000);
            out = retry(obj, url, wait, retries -1);
        end

    end

end
