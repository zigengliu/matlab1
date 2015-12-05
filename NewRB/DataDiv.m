function [CPmat,HIPmat,LOPmat,TCPmat,THIPmat,t] = DataDiv(dataCell,HipLop,method)
CPcell = dataCell{1,1};
HIPcell = HipLop{1,1};
LOPcell = HipLop{1,2};

DataMat = CPcell(1,:);
HIPmat = HIPcell(1,2:end);
LOPmat = LOPcell(1,2:end);
Tmat = CPcell(4,:);
THIPmat = HIPcell(4,2:end);
[m,n] = size(HIPmat);
[p,q] = size(DataMat);
j = 1;

if method == 1
    t = 1;
elseif method == 2
    t = 10;
elseif method == 3
    t = 60;
elseif method == 4
    t = 300;
end
Jmax = (q-1)/t;
CPmat = zeros(1,Jmax);
TCPmat = zeros(1,Jmax);

for i = 2:t:q
    CPmat(1,j) = DataMat(1,i);
    TCPmat(1,j) = Tmat(1,i);
    j = j + 1;
end

        
        