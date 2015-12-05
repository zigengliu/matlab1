function [MoneyTemp,OverTest] = LongClose(Money,CPmat,CPLongOpen)
OverTest = 0;
MoneyTemp = Money + (CPmat - CPLongOpen)*300;
if MoneyTemp <= 0
    OverTest = 1;
end