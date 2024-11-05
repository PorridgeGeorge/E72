%Matrix representing the system of equations relating each of the 10
%unknown temperatures to each other
M = [-1 0.5 0.5 0 0 0 0 0 0 0;
    0.25 -1 0 0.5 0 0 0 0 0 0;
    0.25 0 -1 0.5 0.25 0 0 0 0 0;
    0 0.25 0.25 -1 0 0.25 0 0 0 0;
    0 0 0.25 0 -1 0.5 0.25 0 0 0;
    0 0 0 0.25 0.25 -1 0 0.25 0 0;
    0 0 0 0 0.25 0 -1 0.5 0 0;
    0 0 0 0 0 0.25 0.25 -1 0.25 0;
    0 0 0 0 0 0 0 0.25 -1 0.25;
    0 0 0 0 0 0 0 0 0.5 -1];

%The set of known temperatures corresponding to their equations in matrix M
B = [0; -25/4; 0; -25/4; 0; -25/4; -75/4; -75/4; -25; -25];

%The set of unknown temperatures that solve the system of equations above
X = M\B;

%Matrix with the position of each temperature in the verticle cross section
Z = [X(1) X(2) 25 25;
    X(3) X(4) 25 25;
    X(5) X(6) 25 25;
    X(7) X(8) X(9) X(10);
    75 75 75 75];

%Countour plot displaying the temperatures in a heat map
contourf(Z)
title('2D Steady State Temperature Distribution [deg C]')

%Calculate the Qtop with a 300 micro meter 1D portion of the chip 
k = 400;
q = (k/2)*((57.22-75)+2*(55.69-75)+2*(51.66-75)+(50.81-75));

x = (-25454*(0.0003^2))/(0.01^2)