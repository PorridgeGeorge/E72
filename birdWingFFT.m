%Problem 2
% Compute X[k] for the signal x[n]
%fft([200/4 50/4 -150/4 50/4]);

% Create a vector of DFT coefficients X[k]
x = [200 50 -150 50];
N = 4;
T0 = 0.5
k = [0:N-1];
f = [-4 -2 0 2]


xN = fft(x/N)
plotX = [xN(3:4) xN(1:2)]
stem(f,plotX)

xlabel('Frequency [Hz]')
ylabel('X[k]')             
title('Coeffiecients X[k] computed from formula')