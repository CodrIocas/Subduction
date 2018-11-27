function secular()

Step = 'Reading the data...'

    T=xlsread('E_Asia.xlsx','I2:Y1566');
%     T=xlsread('E_Asia_arc.xlsx','I2:Y927');
%     T=xlsread('E_Asia_continent.xlsx','I2:Y640');
%     T=xlsread('S_America.xlsx','I2:Y508');
%     T=xlsread('S_American_arc.xlsx','I2:Y162');
%     T=xlsread('S_American_continent.xlsx','I2:Y347');

SiO2=T(:,3);
Element=T(:,4);
sampleN=length(SiO2);

OutlierH=quantile(Element,0.995);
OutlierL=quantile(Element,0.005);

for i = 1:1:sampleN   %constrain value in specific lithology.
    if SiO2(i) >= 45 & SiO2(i) <= 52;     %confine samples with SiO2 in 45-52%.
        Element(i)=Element(i);
    else
        Element(i)=nan;
    end
end

for i = 1:1: sampleN;   % remove the very high or very low value
    if Element(i)>OutlierH | Element(i)<OutlierL
        Element(i)=nan;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AA=Element;

low = 51;
high = 53;

nA=[];

for j = 1:1:8
    
    Step = j
    dataAA=[];
    BinAA=[];
    BSmean_AA=[];
    
    for i = 1:1:sampleN   %constrain value in specific SiO2 range.
        
        if SiO2(i) >= low & SiO2(i) <= high
            BinAA(i)=AA(i);
        else
            BinAA(i)=nan;
        end
    end
    
    dataAA=BinAA(~isnan(BinAA));
    nA(j)=length(dataAA);
    
    % Bootstrap estimation for mean and standard error
    
    if nA(j)>1       % less than 1 samples will not be calculated.
        BSmean_AA = bootstrp(5000, @mean, dataAA);
    else
        BSmean_AA = [];
    end    
    
    result1(j,1)=(low+high)/2;    %age
    result1(j,2)=mean(BSmean_AA);       %mean
    result1(j,3)=2*std(BSmean_AA);      %standard deviation/sqrt(n)
    result1(j,4)=nA(j);
    
    low = low-1;      %define the bin size (step width)
    high = high-1;    %define the bin size (step width)
    
end

figure(1)
eb1=errorbar(result1(:,1),result1(:,2),result1(:,3));  % AA

result=[result1];

csvwrite('E_Asia_Nb_vs_SiO2.csv',result);

end

