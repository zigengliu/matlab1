function [LongOpenSignal,ShortOpenSignal,Ncount,Money] = RBMEndOfDay(j,CPmat,LongOpenSignal,ShortOpenSignal,CPLongOpen,CPShortOpen,Money,Ncount)
if LongOpenSignal == 1
    [Money,~] = LongClose(Money,CPmat(j),CPLongOpen);
    LongOpenSignal = 0;
    Ncount = Ncount + 1;
elseif ShortOpenSignal == 1
    [Money,~] = ShortClose(Money,CPmat(j),CPShortOpen);
    ShortOpenSignal = 0;
    Ncount = Ncount + 1;
end