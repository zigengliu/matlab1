function [CeilingP,FloorP,bCeiling,bFloor,FloatSignal] = RBMFloatingB(j,CPmat,LongOpenSignal,ShortOpenSignal,bCeiling,bFloor,CeilingP,FloorP,bRange,NRange)
FloatSignal = 0;
if LongOpenSignal == 1 && CPmat(j-1) > bCeiling && CPmat(j-1) < CPmat(j) 
    CeilingP = CeilingP + (CPmat(j) - CPmat(j-1));
    bCeiling = CeilingP + bRange;
    FloorP = CeilingP - 2*NRange;
    FloatSignal = 1;
end
if ShortOpenSignal == 1 && CPmat(j-1) < bFloor && CPmat(j-1) > CPmat(j) 
    FloorP = FloorP - (CPmat(j-1) - CPmat(j));
    bFloor = FloorP - bRange;
    CeilingP = FloorP + 2*NRange;
    FloatSignal = 1;
end
if LongOpenSignal == 0
    bCeiling = CeilingP + bRange;
end
if ShortOpenSignal == 0
    bFloor = FloorP - bRange;
end