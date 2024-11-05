function output = building_Constraint(A)
%A = fmincon(@envelopeDecay,[2,2])
k_d = A(1);
b_d = A(2);
k = 9;
b = 0.1;
m = 1.2;
m_d = m/10;

penalty = 0;

A = [0         1          0        0;
    -(k_d+k)/m -(b_d+b)/m k_d/m    b_d/m;
    0          0          0        1;
    k_d/m_d    b_d/m_d    -k_d/m_d -b_d/m_d];

Constrained_mass_Position = @(t) [1,0,0,0]*expm(A*t)*[0;1/m;0;0];
Constrained_massdamp_Position = @(t) [0,0,1,0]*expm(A*t)*[0;1/m;0;0];

Constrained_position_Vector = [];
Constrained_position_massdampVector = [];

for i = linspace(0,10,1000)
    position_Vector(end+1) = mass_Position(i);
end

for i = linspace(0,10,1000)
    Constrained_position_massdampVector(end+1) = Constrained_position_massdampVector(i);
end

diff = abs(Constrained_position_Vector-Constrained_position_massdampVector)
for i = length(diff)
    if diff(i) >= 0.3
        penalty = penalty +1000;
    else
    end
end

output = penalty;
%fmincon(@building_Constraint(@envelopeDecay,[2,2]),[2,2])