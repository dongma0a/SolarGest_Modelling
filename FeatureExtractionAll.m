function [Faxis]=FeatureExtractionAll(axiss, numberOfSamples)
sr=500; %sampling frequency
%%%%%%%%%%%%%%%Nofiltering%%%%%%%%%%%%%%%%%
axis=axiss;

%% Bandpass filter
buttorder = 3; % low pass filter order
fcutoff_low = 0.1; % cutoff frequence
fcutoff_high = 5; % cutoff frequence

bcutoff = [fcutoff_low /(sr / 2) fcutoff_high /(sr / 2)];
[filtB,filtA] = butter(buttorder, bcutoff, 'bandpass');
filteredSignal = filtfilt(filtB, filtA, axis);

axis = filteredSignal;

X=numberOfSamples;
k=1;
if (length(axis)<X)
    A{1}=axis;
else
    for i=1:X/2:length(axis)
        ii=i+X-1;
        if (ii<=length(axis))
            A{k}=axis(i:ii);
            %tt{k}=t(i:ii);
            k=k+1;
        end
    end
end

for i=1:length(A)
    window=A{i};
    %time=tt{i};
    
    %Time Domain Features
    MEAN(i)=mean(window);
    STD(i)=std(window);
    MAX(i)=max(window);
    MIN(i)=min(window);
    RANG(i)=MAX(i)-MIN(i);
    Q1(i) = median(window(find(window<median(window))));
    MED(i)=median(window);%Q2
    Q3(i) = median(window(find(window>median(window))));
    IQR(i)=iqr(window);
    ABSMEAN(i)=mean(abs(window));
    CV(i)=(STD(i)/MEAN(i))*100;
    SKEW(i)=skewness(window);
    KURT(i)=kurtosis(window);
    
   abovemean = window > MEAN(i);
   meanCrossing = diff(abovemean) == 1;
   meanCrossingIndex = find(meanCrossing);
   numberOfStepsM(i) = numel(meanCrossingIndex);
    
    AbsArea(i)=sum(abs(window));
    RMS(i)=rms(window);
    MAD(i)=mad(window,0);   %Mean Absolute Deviation
    
%Frequency Domain Features
    m=length(window);
    FD=fft(window);
    [num,den]=butter(3,0.1,'high');
    [H,w]=freqz(num,den,m);
    y=H.*FD;  %Filtering from the gravity component
    yy=ifft(y);
    aa=real(yy);
    
    F=fft(aa);
    L=length(F);
    f= (0:L-1)*(sr/L);%frequency Range
    ff=f(1:length(f)/2);%half of the frequency Range
    FF=F(1:length(f)/2);%half of the frequency frequency
    [B,index]=sort(abs(FF),'descend');
    dominant(i) = ff(index(1)); %Dominant Frequency
     
    FFTcoeffMag=abs(FF);
    
    FDMean(i)=mean(FFTcoeffMag.^2);  %the mean value of the magnitude of FFT coefficients (power spectrum mean)
    FDMax(i)=max(FFTcoeffMag.^2); %the maximum value of the magnitude of FFT coefficients
    %FDMin(i)=min(FFTcoeffMag.^2);  %the minimum value of the magnitude of FFT coefficients(power spectrum min)
    
    FDEnergy(i)=sum(FFTcoeffMag.^2); %the sum of the magnitude of FFT coefficients (Total Energy)

    FFTcoeffMagNorm=FFTcoeffMag/sum(FFTcoeffMag);
    for j=1:length(FFTcoeffMagNorm)
        En(j)=FFTcoeffMagNorm(j)*log2(FFTcoeffMagNorm(j));
    end
    
    Entropy(i)=-sum(En); %Entropy
    
    DomFreqRatio(i)=max(FFTcoeffMag)/sum(FFTcoeffMag);
    
   %[Average_Peaks(i),AverageDistance_Peaks(i),MaxDistance_Peaks(i),Max_Peaks(i),peaktopeak(i),peaktopeakdiff(i)]=peaks(window);
                 
end

Faxis=[MEAN',STD',MAX',MIN',RANG',Q1',MED',Q3',IQR',ABSMEAN',CV',SKEW',KURT',AbsArea',RMS',MAD',dominant',FDMean',FDMax',...
FDEnergy',Entropy',DomFreqRatio'];%,Average_Peaks',AverageDistance_Peaks',MaxDistance_Peaks',Max_Peaks',peaktopeak',peaktopeakdiff'];

%Faxis=[MEAN',STD',VAR',MAX',MIN',RANG',Q1',MED',Q3',IQR',ABSMEAN',CV',SKEW',KURT',numberOfStepsM',AbsArea',FDEnergy',Entropy',DomFreqRatio'];

% Faxis=[MEAN',STD',VAR',MAX',MIN',RANG',Q1',MED',Q3',IQR',ABSMEAN',CV',SKEW',KURT',numberOfStepsM',AbsArea',dominant',FDMean',FDMax',FDMin',...
% FDEnergy',Entropy',DomFreqRatio',Average_Peaks',AverageDistance_Peaks',MaxDistance_Peaks',Max_Peaks',peaktopeak',peaktopeakdiff'];
%  
% %  
% Faxis=[MEAN',STD',VAR',MAX',MIN',RANG',Q1',MED',Q3',IQR',ABSMEAN',CV',SKEW',KURT',numberOfStepsM',AbsArea',...
% FDEnergy',Entropy',DomFreqRatio',];