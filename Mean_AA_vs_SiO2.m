function secular()

Step = 'Reading the data...'

T=xlsread('Dataset_mafic.xlsx','I2:Y55108');

AGE=T(:,1);
SiO2=T(:,3);
Element=T(:,4);
sampleN=length(SiO2);

OutlierH=quantile(Element,0.9985);
OutlierL=quantile(Element,0.0015);

for i = 1:1: sampleN;   % remove the outliers
    if Element(i)>OutlierH | Element(i)<OutlierL
        Element(i)=nan;
    end
end

X1= 51;
X2 = 53;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AA=Element;

low = X1;
high = X2;

for i = 1:1: sampleN;   
    if AGE(i)>=0 & AGE(i)<=541         % Phanerozoic
        AA(i)=AA(i);
    else
        AA(i)=nan;
    end
end

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
    
    BSmean_AA = bootstrp(10000, @mean, dataAA);
    
    result1(j,1)=(low+high)/2;    %age
    result1(j,2)=mean(BSmean_AA);       %mean
    result1(j,3)=2*std(BSmean_AA);      %standard error
    result1(j,4)=nA(j);
    
    low = low-1;      %define the bin size (step width)
    high = high-1;    %define the bin size (step width)
    
end

figure(1)
eb1=errorbar(result1(:,1),result1(:,2),result1(:,3));  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AA=Element;

low = X1;
high = X2;

for i = 1:1: sampleN;  
    if AGE(i)>=541 & AGE(i)<=2500         % Proterozoic
        AA(i)=AA(i);
    else
        AA(i)=nan;
    end
end

nA=[];

for j = 1:1:8
    
    Step = j
    dataAA=[];
    BinAA=[];
    BSmean_AA=[];
    
    for i = 1:1:sampleN  
        
        if SiO2(i) >= low & SiO2(i) <= high
            BinAA(i)=AA(i);
        else
            BinAA(i)=nan;
        end
    end
    
    dataAA=BinAA(~isnan(BinAA));
    nA(j)=length(dataAA);
    
    % Bootstrap estimation for mean and standard error
    
    BSmean_AA = bootstrp(10000, @mean, dataAA);
    
    result2(j,1)=(low+high)/2;    %age
    result2(j,2)=mean(BSmean_AA);       %mean
    result2(j,3)=2*std(BSmean_AA);      %standard error
    result2(j,4)=nA(j);
    
    low = low-1;      %define the bin size (step width)
    high = high-1;    %define the bin size (step width)
    
end

figure(2)
eb2=errorbar(result2(:,1),result2(:,2),result2(:,3));  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AA=Element;

low = X1;
high = X2;

for i = 1:1: sampleN;   
    if AGE(i)>=2500 & AGE(i)<=3500         % Archean
        AA(i)=AA(i);
    else
        AA(i)=nan;
    end
end

nA=[];

for j = 1:1:8
    
    Step = j
    dataAA=[];
    BinAA=[];
    BSmean_AA=[];
    
    for i = 1:1:sampleN   
        
        if SiO2(i) >= low & SiO2(i) <= high
            BinAA(i)=AA(i);
        else
            BinAA(i)=nan;
        end
    end
    
    dataAA=BinAA(~isnan(BinAA));
    nA(j)=length(dataAA);
    
    % Bootstrap estimation for mean and standard error
    
    BSmean_AA = bootstrp(10000, @mean, dataAA);
    
    result3(j,1)=(low+high)/2;    %age
    result3(j,2)=mean(BSmean_AA);       %mean
    result3(j,3)=2*std(BSmean_AA);      %standard error
    result3(j,4)=nA(j);
    
    low = low-1;      %define the bin size (step width)
    high = high-1;    %define the bin size (step width)
    
end

figure(3)
eb3=errorbar(result3(:,1),result3(:,2),result3(:,3));  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


result=[result1,result2,result3];

csvwrite('Mean_Ti_vs_SiO2.csv',result);

end

