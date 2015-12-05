function [Money,CPLongOpen,CPShortOpen,LongOpenSignal,ShortOpenSignal,OverTest,counter] = RBMOpenClose(j,CPmat,CP5std,LongOpenSignal,ShortOpenSignal,CeilingP,FloorP,Money,CPLongOpen,CPShortOpen)
counter = 0;
OverTest = 0;
if LongOpenSignal == 0 && CPmat(j-1) < CeilingP && CPmat(j) > CeilingP
    [Money,CPLongOpen] = LongOpen(Money,CPmat(j));
    LongOpenSignal = 1;
                 plot(j,CPmat(j),'.','Markersize',15,'color','r');
end
if ShortOpenSignal == 0 && CPmat(j-1) > FloorP && CPmat(j) < FloorP
    [Money,CPShortOpen] = ShortOpen(Money,CPmat(j));
    ShortOpenSignal = 1;
                 plot(j,CPmat(j),'.','Markersize',15,'color','r');

end
if LongOpenSignal == 1 && CPmat(j) < CeilingP
    [Money,OverTest] = LongClose(Money,CPmat(j),CPLongOpen);
    LongOpenSignal = 0;
    counter = 1;
                 plot(j,CPmat(j),'.','Markersize',15,'color','g');
end
if ShortOpenSignal == 1 && CPmat(j) > FloorP
    [Money,OverTest] = ShortClose(Money,CPmat(j),CPShortOpen);
    ShortOpenSignal = 0;
    counter = 1;
                 plot(j,CPmat(j),'.','Markersize',15,'color','g');
end
% if LongOpenSignal == 1 && CP5std < 2.5
%     [Money,OverTest] = LongClose(Money,CPmat(j),CPLongOpen);
%     LongOpenSignal = 0;
%     counter = 1;
% elseif ShortOpenSignal == 1 && CP5std < 2.5
%     [Money,OverTest] = ShortClose(Money,CPmat(j),CPShortOpen);
%     ShortOpenSignal = 0;
%     counter = 1;
% end