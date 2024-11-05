clear
clc
%my set of a values 
anot = 2/pi;
aone = 4/(pi-pi*4*(1)^2);
atwo = 4/(pi*(1-4*(2)^2));
athree = 4/(pi*(1-4*(3)^2));
afour = 4/(pi*(1-4*(4)^2));
afive = 4/(pi*(1-4*(5)^2));
asix = 4/(pi*(1-4*(6)^2));
aseven = 4/(pi*(1-4*(7)^2));

%range of two periods
t = linspace(0,2);

%fourier #1
f1 = anot + aone*cos(1*4*pi*t);

%fourier #2
f2 = f1 + atwo*cos(2*4*pi*t) + athree*cos(3*4*pi*t);

%fourier #3
f3 = f2 + afour*cos(4*4*pi*t) + afive*cos(5*4*pi*t) + asix*cos(6*4*pi*t) + aseven*cos(7*4*pi*t);

f = abs(sin(2*pi*t))
plot(t,f,'black')
hold on
plot(t,f1,'red')
hold on
plot(t,f2,'blue')
hold on
plot(t,f3,'green')
hold off
title('Fourier Series Partial Sum')
ylabel('Vout [Voltage]')
xlabel('Time [sec]')
legend('Original','k=1','k=3','k=7')
