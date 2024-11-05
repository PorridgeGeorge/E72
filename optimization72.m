baby_b1 = repmat(0.08,1,101);
baby_b2 = repmat(0.025,1,101);
baby_b3 = repmat(0.005,1,101);

b = transpose([baby_b1 baby_b1 baby_b2 baby_b2 baby_b3 baby_b3]);

L = 100

x = 1:101;
e = 5*sin((3*pi*x)/L) + sin((10*pi*x)/L);

A = zeros(606,101);
countA = 0;
countB = 0;
countC = 0;
countD = 0;
countE = 0;
countF = 0;

% my plan: create a for loop that moves through the matrix A
% filling in the constraints for each position
L = 101;
d = 1;
A1 = zeros(101);
A2 = zeros(101);
A3 = zeros(101);
A4 = zeros(101);
A5 = zeros(101);
A6 = zeros(101);

%constraint 1.1 (101x101)
for i = 1:100
    A1(i,i) = -1/d;
    A1(i,i+1) = 1/d;
end

%constraint 1.2 (101x101)
for i = 1:100
    A2(i,i) = 1/d;
    A2(i,i+1) = -1/d;
end

%constraint 2.1 (101x101)
for i = 1:99
    A3(i,i+1) = -2/d^2;
    A3(i,i+2) = 1/d^2;
    A3(i,i) = 1/d^2;
end

%constraint 2.2 (101x101)
for i = 1:99
    A4(i,i+1) = 2/d^2;
    A4(i,i+2) = -1/d^2;
    A4(i,i) = -1/d^2;
end

%constraint 3.1 (101x101)
for i = 1:98
    A5(i,i+2) = -3/d^3;
    A5(i,i+3) = 1/d^3;
    A5(i,i+1) = 3/d^3;
    A5(i,i) = -1/d^3;
end

%constraint 3.2 (101x101)
for i = 1:98
    A6(i,i+2) = 3/d^3;
    A6(i,i+3) = -1/d^3;
    A6(i,i+1) = -3/d^3;
    A6(i,i) = 1/d^3;
end

A = [A1;A2;A3;A4;A5;A6];

z = fmincon(@cost72,1.0603.*ones(1,101),A,b)

plot(x,z,'red')
hold on
plot(x,e,'blue')

title('Cost Optimized Road Plan')
ylabel('Verticle Elevation')
xlabel('Horizontal')

legend('Optimized Road','Original Path')

