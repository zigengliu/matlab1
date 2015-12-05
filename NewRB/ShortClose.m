function [MoneyTemp,OverTest] = ShortClose(Money,CPmat,CPShortOpen)
OverTest = 0;
MoneyTemp = Money + (CPShortOpen - CPmat)*300;
if MoneyTemp <= 0
    OverTest = 1;
end