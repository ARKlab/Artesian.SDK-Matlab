classdef AuthGroup

    properties
        id
        name

        etag
        users
    end

    methods

        function obj = AuthGroup(name, users)
            obj.id = 0;
            obj.etag = "";
            obj.name = name;
            obj.users = users;
        end

    end

end
