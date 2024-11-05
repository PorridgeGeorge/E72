function outputj = tildeZP(X,Y,gamma,f)
X = 500; %Horizontal Span

%rho = 1.2; %Density of Air
%C_d = 1; %Coefficient of Drag
w_factor = 15; %Weight per Length
f = linspace(0,1,10); %Fractional postion of rider

%finding Gamma
riderlessZL(T,Y); %Shape of the Riderless Caternary
L = outputi(3); %Length of the Zipline
m = L*w_factor; %Total weight of the Zipline
gamma = M/m;
w_factor = 15; %Weight per Length

f = linspace(0,1,10); %Fractional postion of rider

% j = [a, b]

funj = @(j) [log((j(1)+sqrt(1+j(1)^2))/(j(1)-j(2)*f+sqrt(1+(j(1)-j(2)*f)^2)))/j(2) + (1/j(2))*log((j(a)-j(2)*f-j(2)*gamma+sqrt(1+(j(1)-j(2)*f-j(2)*gamma)^2))/(j(1)-j(2)*gamma-j(2)+sqrt(1+(j(1)-j(2)*gamma-j(2))^2))) - X;
            (sqrt(1+j(1)^2)-sqrt(1+(j(1)-j(2)*f)^2))/j(2) + (sqrt(1+(j(1)-j(2)*f-j(2)*gamma)^2)-sqrt(1+(j(1)-j(2)*gamma-j(2))^2))/j(2) - Y]
             
j_0 = [0.2,0.2];

j_ans = fsolve(fun2,j_0)

a = j_ans(1)
b = j_ans(2)

xtilde = log((a+sqrt(1+a^2))/(a-b*f+sqrt(1+(a-b*f)^2)))/b;
ytilde = (sqrt(1+a^2)-sqrt(1+(a-b*f)^2))/b;



outputj = [xtilde,ytilde]
