%problem 3 HW 11
clear
x = 0.06;
y = 0.099;
z = 0.101;
c = 100;

eqp1 = [c 0 0];
eqp2 = [0 c 0];
eqp3 = [0 0 c];

jacobian = @(w) [0,              -w(3)*(x-z)/y, -w(2)*(y-x)/z;
                 -w(3)*(z-y)/x, 0,             -w(1)*(y-x)/z;
                 -w(2)*(z-y)/x,  -x(1)*(x-z)/y, 0];
eigen1 = eig(jacobian(eqp1))
eigen2 = eig(jacobian(eqp2))
eigen3 = eig(jacobian(eqp3))
