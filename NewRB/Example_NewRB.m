clc;
clear;

load 'IH0521to0620.mat';
load 'IHHIPLOP0521to0620.mat';
load 'IHOBP0521to0620.mat';
    
method = 2;

%Divide the tick data(data in every second) to other period based(eg. data in every 10, 30 60 second)
[CPmat,HIPmat,LOPmat,TCPmat,THIPmat,t] = DataDiv(IH0521to0620,IHHIPLOP0521to0620,method);

%Perform the analysis
%   The open signals and upper bound are marked red, the close signals and lower bound are marked green
%   The new bounds after floating profit limits are marked yellow
[MoneyMat,TotalN] = RrangeBreakerTest(CPmat,HIPmat,LOPmat,TCPmat,THIPmat);