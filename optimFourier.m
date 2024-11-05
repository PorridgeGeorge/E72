% E72 Homework 2 Spring 2024 - Approximate PWM signal with sum of sinusoids
% Set parameters for a pulse width modulation signal centered around t = 0 
% (a pulse is centered there), specify a number of cosines/sines to use to 
% build an approximation, find the optimal amplitudes and phases of the 
% component sinusoids, and plot the results for one period.

function output = optimFourier(M)

% These parameters may be modified
%M = 3;       % number of harmonics (aka modes) in the approximation
A = 1;       % amplitude of PWM pulse train
T = 1;       % period of signal (in seconds)
d = 0.5;     % duty cycle (fraction of period when pulse is "on"), feel free to play with this number.
dt = T/5000; % spacing between evaluation points (these are the red points in the HW file)
% This value of dt produces 10001 points in the vector "t" below. 
% This should be accurate enough for this problem. No need to change.

%% 
% These lines repeat some of the quantities calculated in calcISE.m for the
% sake of plotting. That's not ideal but it's done here to look
% straightforward. Importantly, the parameters set above are only set in one
% place to avoid inconsistency errors

% Refer to calcISE.m for explanation of these quantities
tau = d*T;    % Duration of time in one period when the pulse is "on". Define tau here in terms of d and T.
omega0 = (2*pi)/T; % Define the fundamental frequency omega_0 here (see HW file)
t = -T/2:dt:T/2;  % vector of time values (the red dots in the HW file)
pwm =  A*((t>=-tau/2)&(t<=tau/2)); 

figure(M)
clf  % clear the figure

subplot(2,1,1) % Make a plot that has two panels stacked vertically
plot(t,pwm,'k-','LineWidth',2)  % Plot the desired PWM signal
hold on
title(strcat('PWM signal and optimization for M=',num2str(M)))
xlabel('Time')
ylabel('Signal magnitude')


%% In this section, expressions are written for the specific case of M=3
% Initial guess for the decision variables, which are entries are amplitudes 
% of the constant term, then the cosines, then the sines.
ab0 = A/2*ones(1,2*M+1); 

% If, as you move to larger M values, you get an error about exceeding
% MaxFunEvals, uncomment this line, and look at the help for fminsearch and 
% learn how to have it use specified options and understand what it is doing.
options = optimset('MaxFunEvals',10000);

% TASK b) 
% To understand why we need "f" below, refer to Problem 3 from SKills 1 and
% read the "Minimize with Extra Parameters" section of the fminsearch Matlab documentation.
% Write a clear explanation of what these two lines are doing in your homework writeup.
f = @(ab) calcISE(ab,A,T,d,M,dt);
[ab,ISE] = fminsearch(f,ab0);

% Final approximate signal 
%approx=ab(1)*ones(1,length(t)) ...
%    + ab(2)*cos(omega0*t) + ab(3)*cos(2*omega0*t) + ab(4)*cos(3*omega0*t) ...
%    + ab(5)*sin(omega0*t) + ab(6)*sin(2*omega0*t) + ab(7)*sin(3*omega0*t);

approx = ab(1)*ones(1,length(t));

for i = 2:2*M+1
    if i < M+2  
        approx = approx + ab(i)*cos((i-1)*omega0*t);
    else
        approx = approx + ab(i)*sin((i-M-1)*omega0*t);
    end
end


plot(t,pwm,'k-','LineWidth',2)
plot(t,approx,'r-','LineWidth',3)
axis([-T/2 T/2 -A/2 A*1.5]);

subplot(2,1,2) % show all of the individual components of the final approximation
hold on
plot(t,ab(1)*ones(1,length(t)),'LineWidth',2,'DisplayName','constant');
for k=1:M
   plot(t,ab(k+1)*cos(k*omega0*t),  'LineWidth',2,'DisplayName',strcat('cos(',num2str(k),'*omega0*t)'));
   plot(t,ab(k+M+1)*sin(k*omega0*t),'LineWidth',2,'DisplayName',strcat('sin(',num2str(k),'*omega0*t)'));
end

legend
title(strcat('Component cos/sinusoids in optimal solution for M=',num2str(M)))
xlabel('Time')
ylabel('Component cos/sinusoid magnitude')


ISE
ab

end