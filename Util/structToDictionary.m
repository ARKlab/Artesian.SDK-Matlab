function output = structToDictionary(struct)
    fields = fieldnames(struct);
    row = {};
    row.Key = "";
    row.Value = "";
    
    output={};
    % output(1, numel(fields)) = row;

    for i = 1:numel(fields)
        key = fields{i};

        row = {};
        row.Key = key;
        row.Value = struct.(key);

        output=[output row];
        % output(i) = row;
    end

end
