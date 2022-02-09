classdef AclPath

    properties
        path
        roles
    end

    methods

        function obj = AclPath(path, roles)
            obj.path = path;
            obj.roles = roles;
        end

    end

end
