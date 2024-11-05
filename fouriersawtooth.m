function ISE = fouriersawtooth(A, T, M,counter)
%   A: amplitude of pulse train
%   T: fundamental period
%   d: duty cycle
%   M: number of harmonics in the Fourier series approximation

% Based on a function written by E72 Spr 2024, Profs. Bassman, Nembhard, Yong



N0 = 1000;    % number of points within a period. Increase to capture variations for higher harmonics
dt = T/N0;    % time resolution
tau = T;    % duration of non-zero pulse
wo = 2*pi/T;     % fundamental frequency


% Calculate Fourier coefficients. k goes from -M to M, but the vector of 
% coefficients has to start with index 1
k = -M:1:M;
c = (A./(2*pi*k)).*(((-1)^0.5)-1./(2*pi*k));
%c_0
c(0+M+1) = A/2;

% Vector of times for the plots
t = 0:dt:2*tau; % two full periods plus a bit extra
%t = 0:dt:2*tau; % two full periods plus a bit extra
length(t)
% The approximated signal from the Fourier coefficients and basis functions

xhat = zeros(1,length(t));
for n = -M:1:M  % using n to avoid messing up k vector
    xhat = xhat + c(n+M+1).*exp(j*n*wo*t); 
end

% Generate a vector of zeros and ones corresponding to the pulse being off
% or on in the original signal. We are using logical AND (&) and OR (|) statements
% to calculate x without having to use a for loop and if statements.
%G = ((j*k*2*pi)+0.8)/(((-k*4*k^2*pi^2)/T)+(2*j*k*pi)+(0.8/T)


yhat = zeros(1,length(t));
for v = -M:1:M  % using n to avoid messing up k vector
    yhat = yhat + ((j*v*wo)+0.8)./(((-v^2*wo^2)+(j*v*wo)+0.8)) .* c(v+M+1) .* exp(j*v*wo*t); 
end


%Builds Sawtooth
x1 = [(A/tau)*(0:dt:tau) (A/tau)*(0:dt:tau)];
x = x1(1:2001);

%comment out if you want to run SawtoothISE


%plots y
figure(1)
%subplot(3,2,counter)

plot(t,yhat,'r')
axis tight
hold on


%plots x
plot(t,xhat,'b')
axis tight
hold on

%plots original sawtooth

plot(t,x,'k')
axis tight
hold on
xlabel('time (seconds)')
ylabel('Response')
%title(num2str(M))
title('Fourier series Approx 50 seconds')
%legend('Output y(t)','Input x(t)','Originial Sawtooth')

% Compute the ISE value within one period of the signal by adding squared error
% at each time (multiplied by time step dt). Show ISE as the title of the graph.

ISE=0;
for i = 1:N0+1   % can start anywhere and add one period's worth of points
    ISE = ISE + (x(i)-xhat(i)).^2*dt;
end

% The x and xhat values are real, but they are calculated from complex
% valued expressions they retain tiiiiiiny imaginary parts. This gets rid
% of them so we don't need to see an error message
ISE = abs(ISE);

end

