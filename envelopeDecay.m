function output = envelopeDecay(B)

k_d = B(1);
b_d = B(2);
k = 9;
b = 0.1;
m = 1.2;
m_d = m/10;

A = [0         1          0        0;
    -(k_d+k)/m -(b_d+b)/m k_d/m    b_d/m;
    0          0          0        1;
    k_d/m_d    b_d/m_d    -k_d/m_d -b_d/m_d];

mass_Position = @(t) [1,0,0,0]*expm(A*t)*[0;1/m;0;0];
%mass_Velocity = @(t) [0,1,0,0]*expm(A*t)*[0;1/m;0;0];

position_Vector = [];
%velocity_Vector = [];

for i = linspace(0,10,1000)
    position_Vector(end+1) = mass_Position(i);
end

%for i = linspace(0,10,1000)
%    velocity_Vector(end+1) = mass_Velocity(i);
%end

peak_pValue = max(position_Vector);
%peak_vValue = max(velocity_Vector);
output = peak_pValue;


%pos_sum = sum(abs(position_Vector));
%ken_E = sum(m*velocity_Vector.^2);
%output = pos_sum;

%lambda = real(eig(A));
%output = max(lambda);


%the eigenvalues should be negative (if the system remains stable)

end


%fmincon(@envelopeDecay,[2,2])

