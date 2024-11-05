%%Objective Function Need to achieve exactly 1500kW over an hour with lowest cost

% 1,2,3 Production units
%Fixed ($/hour) 250,100,450
%Variable ($/kWh) 0.25 0.5 0.15
%Production min (kW) 150, 250, 200
%Production max (kW) 1300, 1200, 1400

%Determine which production units should be on and how much energy each should
%produce and the total cost

%values
A = [-1300 0     0       1  0  0;
    150    0     0       -1 0  0;
    0      -1200 0       0  1  0;
    0      250   0       0  -1 0;
    0      0     -1400   0  0  1;
    0      0     200     0  0  -1];

f = [250 100 450 0.25 0.5 0.15];

intcon = [1:3];

%Limits the sum of each of the power plants energy to 1500
Aeq = [0 0 0 1 1 1];
beq = 1500;

%zero vector
b = zeros(6,1);


x = intlinprog(f,intcon,A,b,Aeq,beq)
