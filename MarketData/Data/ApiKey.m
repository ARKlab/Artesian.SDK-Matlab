classdef ApiKey

    properties
        id
        eTag
        usagePerDay
        expiresAt
        description
    end

    methods

        function output = ApiKey(expiresAt, description)
            output.expiresAt = expiresAt;
            output.description = description;
            output.id = 0;
            output.eTag = "null";
            output.usagePerDay = -1;
        end

    end

end
