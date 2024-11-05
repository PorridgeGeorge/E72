%problem 2 HW 11
clear
m = 0.5;
r = 0.1;
L = 0.2;
g = 9.81;

% x = (theta, x, phi, y, omega_r)

%x
%omega_r

tfinal = 10;
init_data = [0; 0; 20*pi/180; 0; 800/60*2*pi];%

Diff_eq = @(t,x) [x(2);
                  -2*x(4)*(((r^2*x(5)+4*L^2*x(2)*cos(x(3))))/((r^2+4*L^2)*sin(x(3))));
                  x(4);
                  sin(x(3))*((4*L^2-r^2)*x(2)^2*cos(x(3))+2*r^2*x(5)*x(2)+4*g*L)/(4*L^2+r^2);
                  -x(4)*(x(2)*sin(x(3))+(2*(r^2*x(5)+4*L^2*x(2)*cos(x(3)))/((r^2+4*L^2)*tan(x(3)))))];

gyro_sol = ode45(Diff_eq,[0,tfinal], init_data);

plott=linspace(0,tfinal,1000);

theta   = deval(gyro_sol,plott,1);
x       = deval(gyro_sol,plott,2);
phi     = deval(gyro_sol,plott,3);
y       = deval(gyro_sol,plott,4);
omega_r = deval(gyro_sol,plott,5);

pot_E = m*g*L*cos(phi);

ken_E = 0.5*m*(0.5*r^2*omega_r.^2+(0.25*r^2+L^2)*y.^2+(0.5*r^2+(L^2-0.25*r^2)*sin(phi).^2).*x.^2-r^2*omega_r.*x.*cos(phi));

Energy = pot_E + ken_E;

clf
figure(1)

subplot(3,1,1)
plot(plott,theta,'r')
ylabel('Procession Angle')
xlabel('Time (sec)')
hold on

subplot(3,1,2)
plot(plott,phi,'g')
ylabel('Nutation Angle')
xlabel('Time (sec)')
hold on

subplot(3,1,3)
plot(plott,Energy,'b')
ylabel('Total Energy (Joules)')
xlabel('Time (sec)')

cart_x = L*sin(phi).*cos(theta);
cart_y = L*sin(phi).*sin(theta);
cart_z = L*cos(phi);
figure(2)
plot3(cart_x,cart_y,cart_z)
