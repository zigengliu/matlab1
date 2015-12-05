function [Center,Signal] = BoxCenterCalc(CP5mat,CP5std,BCstd)
Center = 0;
if CP5std < BCstd
    Center = mean(CP5mat);
    Signal = 1;
else
    Signal = 0;
end