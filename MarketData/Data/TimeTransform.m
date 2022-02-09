classdef TimeTransform

    properties
        id
        name
        eTag
        definedBy
        type
        period
        positiveShift
        negativeShift
    end

    methods

        function obj = TimeTransform(name, type, period, positiveShift, negativeShift)
            obj.id = 0;
            obj.eTag = "";
            obj.definedBy = TransformDefinitionTypeEnum.User;
            obj.name = name;
            obj.type = type;
            obj.period = period;
            obj.positiveShift = positiveShift;
            obj.negativeShift = negativeShift;
        end

    end

end
