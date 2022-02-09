function output = dataRowToDictionary(input)
    row = {};
    row.Key = "";
    row.Value = 0;
    % output(1, numel(input)) = row;

    output = {};

    for i = 1:numel(input)
        row = {};
        row.Key = input{i}{1};
        row.Value = input{i}{2};

        output = [output, row];
    end

end
