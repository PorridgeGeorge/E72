%Zipline 72 objective function
function output = maxvelo(V)

Y = V(1); %Verticle Drop
T = V(2); %Tension w/o Rider
M = 70; %Mass of the Rider
X = 500; %Horizontal Span
w_factor = 15; %Weight per Length
g = 9.8; %Gravity
f = [0:0.001:1]; %Fractional postion of rider along the x axis


%finding Gamma

%x = [a_0, b_0, L]

funi = @(i) [T*cos(atan(i(1)))-w_factor*i(3)/i(2);
            log((i(1)+sqrt(1+i(1)^2))/(i(1)-i(2)+sqrt(1+(i(1)-i(2))^2)))/i(2)-X/i(3);
            (sqrt(1+i(1)^2)-sqrt(1+(i(1)-i(2))^2))/i(2)-Y/i(3)];

i_0 = [0.1435,0.1268,X];
i_ans = fsolve(funi,i_0,optimset('MaxFunEvals',1000,'TolFun',1E-12,'MaxIter',1000,'Display','Off'));
a_0 = i_ans(1);
b_0 = i_ans(2);
L = i_ans(3); %Length of the Zipline

bigX = [];
bigY = [];

lilx = [];
lily = [];

for r = 1:length(f)
bigX(end+1) = (log((a_0+sqrt(1+a_0^2))./(a_0-b_0*f(r)+sqrt(1+(a_0-b_0*f(r)).^2)))/b_0)*L;
bigY(end+1) = ((sqrt(1+a_0^2)-sqrt(1+(a_0-b_0*f(r)).^2))/b_0)*L;

m = L*w_factor/g; %Total mass of the Zipline
gamma = M/m;

%Rider Position

% j = [a, b]

funj = @(j) [log((j(1)+sqrt(1+j(1)^2))./(j(1)-j(2)*f(r)+sqrt(1+(j(1)-j(2)*f(r)).^2)))/j(2) + (1/j(2))*log((j(1)-j(2)*f(r)-j(2)*gamma+sqrt(1+(j(1)-j(2)*f(r)-j(2)*gamma).^2))/(j(1)-j(2)*gamma-j(2)+sqrt(1+(j(1)-j(2)*gamma-j(2))^2))) - X/L;
            (sqrt(1+j(1)^2)-sqrt(1+(j(1)-j(2)*f(r)).^2))/j(2) + (sqrt(1+(j(1)-j(2)*f(r)-j(2)*gamma).^2)-sqrt(1+(j(1)-j(2)*gamma-j(2))^2))/j(2) - Y/L];
 

j_0 = [0.1435,0.1268];

j_ans = fsolve(funj,j_0,optimset('MaxFunEvals',1000,'TolFun',1E-12,'MaxIter',1000,'Display','Off'));

a = j_ans(1);
b = j_ans(2);

lilx(end+1) = (log((a+sqrt(1+a^2))./(a-b*f(r)+sqrt(1+(a-b*f(r)).^2)))/b)*L;
lily(end+1) = ((sqrt(1+a^2)-sqrt(1+(a-b*f(r)).^2))/b)*L;
end

%plot(bigX,-bigY,'b')
%hold on
%plot(lilx,-lily,'r')

%Rider velocity 

rider_spline = spline(lilx,-lily);

rateofchangespline = fnder(rider_spline);

rho = 1.2; %Density of Air
C_d = 1; %Coefficient of Drag
A = 0.05*M^(2/3); %Frontal Area

diff_eq = @(x,v) [2*(g*sin(-atan(ppval(rateofchangespline,x)))-(0.5*rho*C_d*A*v(1))/M)*sqrt(1+(ppval(rateofchangespline,x))^2)];

init_data = [0];
velo_sol = ode45(diff_eq,[0 X], init_data);

tplot = f*500;

velo_square = deval(velo_sol,tplot,1);
velo = sqrt(velo_square);
%plot(tplot,velo)

max_velo_square = max(velo_square);
max_velo = max(velo);

exit_velo = velo(end)

%penalty confining the exit velocity between 0 and 5 m/s 
if exit_velo >= 5
    exit_velo = (exit_velo)^2 + 100;
if exit_velo <= 0
    exit_velo = (exit_velo)^2 + 100;

output = [-max_velo];
end

% maximize exit velocity of 30kg:
%fmincon(ziplineOBJ,[20 40000 30])

% maximize exit velocity of 70kg:
%fmincon(ziplineOBJ,[20 40000 70])

% maximize exit velocity of 140kg:
%fmincon(ziplineOBJ,[20 40000 140])

%m = 30;
%m = 70;
%m = 140;
%fmincon(ziplineOBJ, [20 40000 30])