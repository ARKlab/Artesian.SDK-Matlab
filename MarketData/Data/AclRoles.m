classdef AclRoles

    properties
        role
        principal
    end

    methods

        function obj = AclRoles(role, principal)
            obj.role = role;
            obj.principal = principal;
        end

    end

end
