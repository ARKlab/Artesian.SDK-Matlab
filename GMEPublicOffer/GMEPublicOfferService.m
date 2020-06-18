classdef GMEPublicOfferService

    properties (Access = private)
        cfg
        client ClientArtesian
        policy PolicyConfig = PolicyConfig()
    end

    methods (Access = public)

        function obj = GMEPublicOfferService(cfg)
            obj.cfg = cfg;
            obj.client = ClientArtesian(cfg, ArtesianConstants.GMEPublicOfferRoute + "/" + ArtesianConstants.GMEPublicOfferVersion);
        end

        function query = CreateGMEPublicOfferQuery(obj)
            query = GMEPublicOfferQuery(obj.client, obj.policy);
        end

    end

end
