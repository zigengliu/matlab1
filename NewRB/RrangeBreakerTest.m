function [MoneyMat,TotalN] = RrangeBreakerTest(CPmat,HIPmat,~,TCPmat,THIPmat)
%%%%%%%%%%
%Initialized variables and pre-alocating memory
[m,n] = size(HIPmat);
[p,q] = size(CPmat);

%MoneyCell = {1,1};
%Asset = zeros(1,q);

CP5mat = zeros(1,5);
MoneyMat = zeros(1,q);
CeilingMat = zeros(1,q);
FloorMat = zeros(1,q);
bCeilingMat = zeros(1,q);
bFloorMat = zeros(1,q);
TotalN = zeros(1,n);
CPLongOpen = 0;
CPShortOpen = 0;
LongOpenSignal = 0;
ShortOpenSignal = 0;
Ncount = 0;
Money = 200000;
%%%%%%%%%%%%
%Initializing coefficients after some elimentary optimizations
j = 5;
%k = 20;
s = 0.5;
BCstd = 0.50;
RangeMulti = 80;
RangeMin = 3;
RangeMax = 6;

q = 16000;

hold on;
plot(j:q,CPmat(j:q),'color','b');

%%%%%%%%
%the for loop for day
for i = 1:(n-1)
%    RangeCoeff = 0.001*k;
%    Range = RangeCoeff*(HIPmat(i)-LOPmat(i));
    BoxCenter = CPmat(j);
    NRange = RangeMax;
    CeilingP = BoxCenter + NRange;
    FloorP = BoxCenter + NRange;
    

    bRange = 0.00036*s*CPmat(j);
    bCeiling = CeilingP + bRange;
    bFloor = FloorP - bRange;

    while j <= q && TCPmat(j) < THIPmat(i+1)
        for g = 1:5
            CP5mat(1,g) = CPmat(j-5+g);
        end
        CP5std = std(CP5mat);
        %Long and short condition set up
        [Money,CPLongOpen,CPShortOpen,LongOpenSignal,ShortOpenSignal,OverTest,counter] = RBMOpenClose(j,CPmat,CP5std,LongOpenSignal,ShortOpenSignal,CeilingP,FloorP,Money,CPLongOpen,CPShortOpen);
%         if LongOpenSignal == 1 || ShortOpenSignal == 1
%             plot(j,CPmat(j),'.','Markersize',10,'color','r');
%         elseif LongOpenSignal == 0 || ShortOpenSignal == 0
%             plot(j,CPmat(j),'.','Markersize',10,'color','g');
%         end
        if OverTest == 1;
            j = q;
        end
        Ncount = Ncount + counter;
        %fitting RangeBreaker box
        [CeilingP,FloorP,NRange,bCeiling,bFloor] = RangeBreakerBoxSet(CP5mat,CP5std,RangeMulti,RangeMin,RangeMax,BCstd,CeilingP,FloorP,NRange,bCeiling,bFloor,bRange);        
        
        %floating profit limit
        [CeilingP,FloorP,bCeiling,bFloor,FloatSignal] = RBMFloatingB(j,CPmat,LongOpenSignal,ShortOpenSignal,bCeiling,bFloor,CeilingP,FloorP,bRange,NRange);

        %end of day close
        if TCPmat(j+1) >= THIPmat(i+1)
           [LongOpenSignal,ShortOpenSignal,Ncount,Money] = RBMEndOfDay(j,CPmat,LongOpenSignal,ShortOpenSignal,CPLongOpen,CPShortOpen,Money,Ncount);
        end
         
        %money data matrix accumulation
        MoneyMat(1,j) = Money;
        
        %end of day recording
        CeilingMat(1,j) = CeilingP;
        FloorMat(1,j) = FloorP;
        bCeilingMat(1,j) = bCeiling;
        bFloorMat(1,j) = bFloor;
        
%         if FloatSignal == 1;
%             plot(j,CPmat(j),'.','Markersize',10,'color','y');
%         end
        j = j + 1;            
    end
    TotalN(1,i) = Ncount;
end
j = 5;
plot(j:q,CeilingMat(j:q),'color','r');
plot(j:q,FloorMat(j:q),'color','g');
plot(j:q,bCeilingMat(j:q),'color','y');
plot(j:q,bFloorMat(j:q),'color','y');

hold off;
