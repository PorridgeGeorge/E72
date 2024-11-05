clear
clc
T = 30000; % line tension (N)
l = 125;   % line length (m)
n = 1;     % harmonic #
m = 2.4;   % linear mass of wire (kg/m)
v = 9;     % wind speed (m/s)

% 1st column of powerline matrix is angle alpha
% 2nd column of powerline matrix is D(alpha)
% 3rd column of powerline matrix is L(alpha)

powerlinedata=[      0    0.84       0
                  pi/6    1.95   -1.67
                  pi/3    3.35   -0.84
                  pi/2    3.38    0.56
                2*pi/3    2.51    1.39
                5*pi/6    1.39   -0.69
                    pi    1.12       0
                7*pi/6    1.53    0.84
                4*pi/3    2.23   -1.12
                3*pi/2    3.77   -0.14
                5*pi/3    3.91    0.70
               11*pi/6    2.37    2.37
                  2*pi    0.84       0];

% Create spline objects for D and L functions

Dspline = spline(powerlinedata(:,1),powerlinedata(:,2)); % construct spline object
Lspline = spline(powerlinedata(:,1),powerlinedata(:,3)); % construct spline object

% For convenience, create functions that can be used to evaluate D and L at any angle, even ones outside the [0,2*pi] range.
% Since the D and L functions are supposed to be periodic, we use mod( ,2*pi) to make sure that the angle is always between
% 0 and 2*pi, even if the inputted angle is outside of that range. That way the spline object is only evaluated where we
% have data specified in powerlinedata.

Dfun = @(alpha) ppval(Dspline,mod(alpha,2*pi)); % the mod(alpha,2*pi) makes sure the angle is between 0 and 2*pi
Lfun = @(alpha) ppval(Lspline,mod(alpha,2*pi)); % the mod(alpha,2*pi) makes sure the angle is between 0 and 2*pi

%x = [y,x]

Diff_eq = @(t,x) [x(2);
                 (((-Dfun(-atan2(x(2)/v,x(2)/v))*x(2))+(Lfun(-atan2(x(2)/v,x(2)/v))*v))/(m*(x(2)^2+v^2)^0.5)-x(1)*(T/m)*(n*pi/l)^2)];

init = [0.1;0];
tfinal = 60;
ODE_sol = ode45(Diff_eq,[0,tfinal],init);

tplot = linspace(0,tfinal,5000);

v_pos = deval(ODE_sol,tplot,1);
v_rate = deval(ODE_sol,tplot,2);

clf

figure(1)

plot(tplot,v_pos)
ylabel('Vertical Position')
xlabel('Time (sec)')

%extra credit
alpha = -atan2(v_rate/v,v_rate/v);
rateofchangeLift = fnder(Lspline);
rate_Lfun= ppval(rateofchangeLift, alpha);

