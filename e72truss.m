% This program takes the x- and y-coordinates of joint B as input
% (in a vector) and outputs some desired property of the truss.

function output = e72truss(B)

% These are the locations of the joints.
A=[5 0];
C=[2 2];
D=[0 0];
E=[0 2];

% Calculate unit vectors from one joint to another.
% "norm" calculates the length of a vector
unitAB = (B-A)/norm(B-A);
unitAC = (C-A)/norm(C-A);
unitBC = (C-B)/norm(C-B);
unitBD = (D-B)/norm(D-B);
unitCD = (D-C)/norm(D-C);
unitCE = (E-C)/norm(E-C);
unitDE = (E-D)/norm(E-D);
matrix = [unitAB(1)   unitAC(1)   0           0            0           0           0           0 0 0;
          unitAB(2)   unitAC(2)   0           0            0           0           0           0 0 0;
          -unitAB(1)  0           unitBC(1)   unitBD(1)    0           0           0           0 0 0;
          -unitAB(2)  0           unitBC(2)   unitBD(2)    0           0           0           0 0 0;
          0           -unitAC(1)  -unitBC(1)  0            unitCD(1)   unitCE(1)   0           0 0 0;
          0           -unitAC(2)  -unitBC(2)  0            unitCD(2)   unitCE(2)   0           0 0 0;
          0           0           0           -unitBD(1)   -unitCD(1)  0           unitDE(1)   0 0 1;
          0           0           0           -unitBD(2)   -unitCD(2)  0           unitDE(2)   0 0 0;
          0           0           0           0            0           -unitCE(1)  -unitDE(1)  1 0 0;
          0           0           0           0            0           -unitCE(2)  -unitDE(2)  0 1 0];

% Define the vector representing the right-hand side of the system
% of equations.

F = 1;

RHS = [0; F; 0; 0; 0; 0; 0; 0; 0; 0];

% Solve the system of equations for the forces.

forces = matrix\RHS;

% Calculate the total length of the truss.

L = [norm(B-A) norm(C-A) norm(C-B) norm(D-B) norm(D-C) norm(E-C) norm(E-D)];
Lin = L*12;

totalLengthft = sum(L);
totalLengthin = totalLengthft*12;

% Calculate the load limit on each point
fLim  = [];

for i = 1:7
    if forces(i) >= 0
        fLim(end+1) = (40000);
    else
        fLim(end+1) = ((pi^2)*(8.75*10^5))/(Lin(i))^2;
    end
end

%fraction of maximum safe load on each bar
Q = abs(forces(1:7)./fLim');

%Density 0.1 lb/in^3
weight = (totalLengthin)*(1^2)*(0.1);

%Maximum applied load on point A
maxLoad = 1/(max(Q));

%The max load per weight of the truss
phi = -1*(maxLoad/weight);

% Set the output to be whatever we want to observe.
output = maxLoad


end

%fminsearch(@e72truss,[2 1])

%fmincon(@e72truss,[3 1],[-1 0],-3)

