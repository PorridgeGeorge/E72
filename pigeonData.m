%problem 2
clear
clf
clc

%adapted from class code fdomain

x = load("pigeonY.txt")
Fs = 250

N=length(x);

if mod(N,2)==0
    k=-N/2:N/2-1; % N even
else
    k=-(N-1)/2:(N-1)/2; % N odd
end

T0=N/Fs;    % Duration of signal
f=k/T0;     % wavenumbers (k) divided by T0 = frequencies
X=fft(x)/N; % Matlab's FFT uses a different convention without the 1/N so we put it in here.
X=fftshift(X);

plot((1:N),x)

% stem(k,abs(X))
% xlabel('Wave Number k')
% ylabel('X[k]')             
% title('Coeffiecients X[k] computed from formula')