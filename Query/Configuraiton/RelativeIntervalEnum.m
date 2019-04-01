classdef RelativeIntervalEnum < int32
    enumeration
        RollingWeek (1),
        RollingMonth (2),
        RollingQuarter (3),
        RollingYear (4),
        WeekToDate (5),
        MonthToDate (6),
        QuarterToDate (7),
        YearToDate (8)
    end
end