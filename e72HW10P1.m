%e72 Homework 10 problem 1
clear
clc
L = 0.01;
C = 0.000001;
R = 50;
times = linspace(0,0.01,2000);
V = [];

A = [-R/L R/L          0;
    0     0            1/C;
    1/L   (-1/L)-(1/L) 0];

%calculate the matrix exponential of A
V = @(times) ((0.001)/L)*[1,0,0]*(expm(A*times)*[0;0;1]);

V_R = arrayfun(V, times);

figure(1)
clf
plot(times,V_R)
ylabel('Voltage across the Resitor')
xlabel('Time (sec)')