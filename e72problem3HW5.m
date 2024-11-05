%Problem 3
clear
clf
clc

%adapted from class code fdomain
load damAccel.mat

time = data(:,1);
accel = data(:,2);
N = length(accel)
T0 = 1.5
Fs = N/T0;

[X,f] = fdomain(accel,Fs);

filtered_X = X;

for i = 1:length(f)
    if abs(f(i))<100 || abs(f(i))>250
        filtered_X(i) = 0 + 0i;
    end
end

[x,t] = tdomain(filtered_X,Fs);

PSD = (N/Fs)*filtered_X.*conj(filtered_X)

way1_Power = (Fs/N)*sum(PSD)
way2_Power = sum(x.^2)/length(x)

figure(1)

subplot(3,1,1)
plot(time,accel,'b')
hold on
plot(time,x,'r')

xlabel('Time (sec)')
ylabel('Acceleration (g)')
title('Original and Filtered Time Series Data')
legend('Original Signal','Filtered Signal')

subplot(3,1,2)
plot(f,abs(X),'b')
hold on
plot(f,abs(filtered_X),'r')

xlabel('Frequency [Hz]')
ylabel('X[k]')             
title('Coeffiecients X[k] computed from formula')
legend('Original Signal','Filtered Signal')
hold on

subplot(3,1,3)
plot(f,PSD,'b')
xlabel('Frequency [Hz]')
ylabel('Power Spectrum Density')             

hold off

