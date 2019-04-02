classdef MarketDataService
    %MarketDataService MarketDataService
    
    properties (Access = private)
        cfg
        client ClientArtesian
        policy PolicyConfig = PolicyConfig()
    end
    
    methods (Access = public)
        function obj = MarketDataService(cfg)
            obj.cfg = cfg;
            obj.client = ClientArtesian(cfg, ArtesianConstants.MetadataVersion);
        end
        
        function curveRange = ReadCurveRange(obj, id, page, pageSize, product, versionFrom, versionTo)
            url= "/marketdata/entity";
            if (nargin < 4)
                error("id, page, pageSize are needed");
            else
                url = url + "/" + string(id) + "/" + "curves" + "?page=" + string(page) + "&pagesize=" + string(pageSize);
            end
            if (nargin >= 5 && ~isempty(product))
                url = url + "&product=" + product;
            end
            if (nargin >= 7)
                url = url + "&versionFrom=" + versionFrom;
                url = url + "&versionTo=" + versionTo;
            end
            
            curveRange=obj.client.Exec("GET",url);
        end
       
    end
end

