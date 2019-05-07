function Diff()

Step = 'Reading the data...'

T=xlsread('Dataset_mafic.xlsx','I2:Y55108');

AGE=T(:,1);
SiO2=T(:,3);
MgO=T(:,10);
Element=T(:,4);

sampleN=length(AGE);

for i = 1:1: sampleN;
    if MgO(i)>18
        Element(i)=nan;
    end
end

OutlierH=quantile(Element,0.9985);
OutlierL=quantile(Element,0.0015);

for i = 1:1: sampleN;
    if Element(i)>OutlierH | Element(i)<OutlierL
        Element(i)=nan;
    end
end
Status = 'Outliers value removed.'

X1 = 3000;
X2 = 3500;
step = 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

low = X1;
high = X2;
AA = Element;

for i = 1:1:sampleN
    if SiO2(i) >= 45 & SiO2(i) <= 49;     
        AA(i)=AA(i);
    else
        AA(i)=nan;
    end
end
Status = 'Confine samples with SiO2 in specfic range.'

nA=[];


for j = 1:1:(X1/step+2)
    
    Status = j
    dataAA=[];
    BinAA=[];
    
    for i = 1:1:sampleN   %constrain value in specific age range.
        if AGE(i) >= low & AGE(i) <= high
            BinAA(i)=AA(i);
        else
            BinAA(i)=nan;
        end
    end
    
%     remove the outliers
    OutlierH=quantile(BinAA,0.95);
    OutlierL=quantile(BinAA,0.05);
    
    for i = 1:1: sampleN;
        if BinAA(i)>OutlierH | BinAA(i)<OutlierL
            BinAA(i)=nan;
        end
    end
    
    dataAA=BinAA(~isnan(BinAA));
    nA(j)=length(dataAA);
    
    if nA(j)>=4       % less than 4 samples will not be calculated.
        BSmean_AA = bootstrp(10000, @mean, dataAA);
    else
        BSmean_AA = [];
    end
    
    result(j,1)=(low+high)/2;    %age
    result(j,2)=mean(BSmean_AA);       %mean
    result(j,3)=std(BSmean_AA);      %standard error
    result(j,4)=nA(j);
    
    low = low - step;      %define the bin size (step width)
    high = high - step;    %define the bin size (step width)
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AA = [];
AA = Element;
low = X1;
high = X2;

for i = 1:1:sampleN
    if SiO2(i) >= 49 & SiO2(i) <= 52;    
        AA(i)=AA(i);
    else
        AA(i)=nan;
    end
end
Status = 'Confine samples with SiO2 in specfic range.'

nA=[];

for j = 1:1:(X1/step+2)
    
    Status = j
    dataAA=[];
    BinAA=[];
    
    for i = 1:1:sampleN   %constrain value in specific age range.
        if AGE(i) >= low & AGE(i) <= high
            BinAA(i)=AA(i);
        else
            BinAA(i)=nan;
        end
    end
    
%     remove the outliers
    OutlierH=quantile(BinAA,0.95);
    OutlierL=quantile(BinAA,0.05);
    
    for i = 1:1: sampleN;
        if BinAA(i)>OutlierH | BinAA(i)<OutlierL
            BinAA(i)=nan;
        end
    end
    
    dataAA=BinAA(~isnan(BinAA));
    nA(j)=length(dataAA);
    
    if nA(j)>=4       % less than 4 samples will not be calculated.
        BSmean_AA = bootstrp(10000, @mean, dataAA);
    else
        BSmean_AA = [];
    end
    
    result(j,5)=mean(BSmean_AA);       %mean
    result(j,6)=std(BSmean_AA);      %standard deviation/sqrt(n)
    result(j,7)=nA(j);
    
    % Monte Carlo simulation for errors
    
    SimuLSi = [];
    SimuHSi = [];

    SimuLSi = normrnd(result(j,2),result(j,3),10000,1);
    SimuHSi = normrnd(result(j,5),result(j,6),10000,1);
    
    Diff = SimuLSi - SimuHSi;
    
    result(j,8) = mean(Diff);
    result(j,9) = std(Diff);
   
    low = low - step;      %define the bin size (step width)
    high = high - step;    %define the bin size (step width)
    
end

figure(1)
eb1=errorbar(result(:,1),result(:,2),(2*result(:,3)));
figure(2)
eb2=errorbar(result(:,1),result(:,5),(2*result(:,6)));
figure(3)
eb3=errorbar(result(:,1),result(:,8),(result(:,9)));

csvwrite('Diff_Ti_500.csv',result);

end