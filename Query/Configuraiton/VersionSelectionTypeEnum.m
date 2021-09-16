classdef VersionSelectionTypeEnum < int32
    enumeration
        LastN (1),
        MUV (2),
        LastOfDays (3),
        LastOfMonths (4),
        Version (5),
        MostRecent (6)
    end
end