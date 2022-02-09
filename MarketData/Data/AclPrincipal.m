classdef AclPrincipal

    properties
        principalType
        principalId
    end

    methods

        function obj = AclPrincipal(principalType, principalId)
            obj.principalType = principalType;
            obj.principalId = principalId;
        end

    end

end
