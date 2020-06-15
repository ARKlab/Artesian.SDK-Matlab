classdef QueryService
    %QUERYSERVICE Contains query types to be created
    
    properties (Access = private)
        cfg
        client ClientArtesian
        partitionStrategy IPartitionStrategy = DefaultPartitionStrategy()
        policy PolicyConfig = PolicyConfig()
    end
    
    methods (Access = public)
        function obj = QueryService(cfg)
            
            obj.cfg = cfg;
            obj.client = ClientArtesian(cfg, ArtesianConstants.QueryRoute + "/" + ArtesianConstants.QueryVersion);
        end
        
        function actualQuery = CreateActual(obj,partitionStrategy)
            if (nargin == 1)
                partitionStrategy=DefaultPartitionStrategy();
            end
            actualQuery=ActualQuery(obj.client, partitionStrategy, obj.policy);
        end
        function versionedQuery = CreateVersioned(obj,partitionStrategy)
             if (nargin == 1)
                partitionStrategy=DefaultPartitionStrategy();
            end
            versionedQuery = VersionedQuery(obj.client, partitionStrategy, obj.policy);
        end
        function marketAssessmentQuery = CreateMarketAssessment(obj,partitionStrategy)
             if (nargin == 1)
                partitionStrategy=DefaultPartitionStrategy();
            end
            marketAssessmentQuery = MasQuery(obj.client, partitionStrategy, obj.policy);
        end
        function auctionQuery = CreateAuction(obj,partitionStrategy)
             if (nargin == 1)
                partitionStrategy=DefaultPartitionStrategy();
            end
            auctionQuery = AuctionQuery(obj.client, partitionStrategy, obj.policy);
        end
    end
end

