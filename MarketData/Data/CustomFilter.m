classdef CustomFilter

    properties
        id
        name
        searchText
        filters
        eTag
    end

    methods

        function obj = CustomFilter(name, searchText, filters)
            obj.name = name;
            obj.searchText = searchText;
            obj.filters = structToDictionary(filters);
            obj.id = 0;
            obj.eTag = "";

        end

    end

end
