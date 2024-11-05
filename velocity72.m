%Zipline 72 objective function
function ansp = velocity72(V)
% ans = [max_VELO, exit_VELO]

Y = V(1); %Vertical Drop
T = V(2); %Tension w/o Rider
M = V(3); %Mass of the Rider
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

bigX = zeros(1,length(f));
bigY = zeros(1,length(f));

lilx = zeros(1,length(f));
lily = zeros(1,length(f));

for r = 1:length(f)
bigX(r) = (log((a_0+sqrt(1+a_0^2))./(a_0-b_0*f(r)+sqrt(1+(a_0-b_0*f(r)).^2)))/b_0)*L;
bigY(r) = ((sqrt(1+a_0^2)-sqrt(1+(a_0-b_0*f(r)).^2))/b_0)*L;

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

lilx(r) = (log((a+sqrt(1+a^2))./(a-b*f(r)+sqrt(1+(a-b*f(r)).^2)))/b)*L;
lily(r) = ((sqrt(1+a^2)-sqrt(1+(a-b*f(r)).^2))/b)*L;
end


plot(lilx,-lily,'r')
hold on

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
%velo = sqrt(velo_square);
%plot(tplot,velo)

max_velo_square = max(velo_square);
exit_velo_square = velo_square(end);

%max_velo = max(velo);
%exit_velo = velo(end)

%Attempt at a penalty confining the exit velocity between 0 and 5 m/s 
%if exit_velo_square >= 25
%    exit_velo_square = (exit_velo_square)^2 + 100;
%if exit_velo_square <= 0
%    exit_velo_square = (exit_velo_square)^2 + 100;

%max_VELO = -max_velo_square;
%exit_VELO = exit_velo_square;

ansp = [sqrt(max_velo_square), sqrt(exit_velo_square)];

end
