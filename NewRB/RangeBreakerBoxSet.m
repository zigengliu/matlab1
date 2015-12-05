function [CeilingP,FloorP,NRange,bCeiling,bFloor] = RangeBreakerBoxSet(CP5mat,CP5std,RangeMulti,RangeMin,RangeMax,BCstd,CeilingP,FloorP,NRange,bCeiling,bFloor,bRange)
[Center,Signal] = BoxCenterCalc(CP5mat,CP5std,BCstd);
if Signal == 1;
    NRange = RangeMulti*std(CP5mat);
    if NRange < RangeMin
        NRange = RangeMin;
    elseif NRange > RangeMax
        NRange = RangeMax;
    end
    CeilingP = Center + NRange;
    FloorP = Center - NRange;
    bCeiling = CeilingP + bRange;
    bFloor = FloorP - bRange;
end