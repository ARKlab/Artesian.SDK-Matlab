classdef ClientArtesian
    %CLIENTARTESIAN ClientArtesian
    properties (Access = private)
        baseurl
        apiKey
        sdkVersion 
    end
    
    methods
        function obj = ClientArtesian(config,url)
            obj.baseurl = config.BaseAddress + "/" + url;
            obj.apiKey = config.ApiKey;
            obj.sdkVersion = ArtesianConstants.SDKVersion;
        end

        
        function results = ExecCellVelues(obj, method, url)
            
            headers = {'Accept' 'application/x-msgpack'; 'X-Api-Key' char(obj.apiKey); 'Accept-Encoding' 'gzip'};

            option  = weboptions('ContentType','binary','Timeout',60, 'RequestMethod', method, 'ArrayFormat', 'csv', 'UserAgent', 'Matlab Artesian.SDK/vSuk', ...
                'HeaderFields',headers);
            query = obj.baseurl + url;
            data= webread(query,option);
            results = parsemsgpack(data);
           
        end
        function data = Exec(obj, method, url)
            
            headers = {'Accept' 'application/json'; 'X-Api-Key' char(obj.apiKey); 'Accept-Encoding' 'gzip'; 'X-Artesian-Agent' strcat('Matlab:',char(obj.sdkVersion))};
            
            option  = weboptions('ContentType','auto','Timeout',60, 'RequestMethod', method, 'ArrayFormat', 'csv', 'UserAgent', 'Matlab Artesian.SDK/vSuk', ...
                'HeaderFields',headers);

            query = obj.baseurl + url
            data= webread(query,option);
            
           
        end

        function data = ExecWrite(obj, method, url, input)
            headers = {'Accept' 'application/json'; 'X-Api-Key' char(obj.apiKey); 'Accept-Encoding' 'gzip'};

            option = weboptions('MediaType','application/json', 'ContentType', 'auto', 'Timeout', 60, 'RequestMethod', method, 'ArrayFormat', 'csv', 'UserAgent', 'Matlab Artesian.SDK/vSuk', ...
                'HeaderFields', headers);

            query = obj.baseurl + url;
            data = webwrite(query, jsonencode(input), option);

        end
       
    end
end

