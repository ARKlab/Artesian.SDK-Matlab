function output = productDataRowToDictionary(input)
    row = {};
    row.Key = "";
    row.Value = 0;
    output = {};

    for i = 1:numel(input)
        row = {};
        row.Key = input{i}{1};
        row.Value = productToDictionary(input{i}{2});

        output = [output row];
    end

end

function output = productToDictionary(input)
    row = {};
    row.Key = "";
    row.Value = 0;
    output = {};

    for i = 1:numel(input)
        row = {};
        input{i}
        row.Key = input{i}{1};
        row.Value = productValueToStruct(input{i}{2});

        output = [output row];
        % output(i) = row;
    end

end

function output = productValueToStruct(input)
    output = {};

    for i = 1:numel(input)
        output.(input{i}{1}) = input{i}{2};
    end

end
