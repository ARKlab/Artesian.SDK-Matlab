classdef GranularityEnum < int32
    enumeration
        Hour  (60),
        Day  (60*24),
        Week (60*24*7),
        Month (60*24*30),
        Quarter (60*24*30*3),
        Year (60*24*30*12),
        TenMinute (10),
        FifteenMinute (15),
        Minute (1),
        ThirtyMinute(30)
    end
end