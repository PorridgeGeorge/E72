function ISE = calcISE_starter(ab,A,T,d,M,dt)
% Pulse width modulation signal centered around t = 0 (i.e., the function needs to be an even function)
%   A: amplitude of PWM pulse train
%   T: period of signal (in seconds)
%   d: duty cycle (fraction of period when pulse is "on")
%   M: number of harmonics (aka modes) in the approximation
%   dt: spacing between evaluation points (these are the red points in the HW file)

% tau is the product of the period of a signal and the fraction of period when the pulse is on. 
% omega0 is the inverse of the period T times 2pi to convert to radians
tau = d*T;    % Duration of time in one period when the pulse is "on". Define tau here in terms of d and T.
omega0 = (2*pi)/T; % Define the fundamental frequency omega_0 here (see HW file)

% Build the original PWM signal
% Make a vector of times for one period centered at t=0
t = -T/2:dt:T/2;  % vector of time values (the red dots in the HW file)

% Generate a vector of zeros and ones corresponding to the pulse being off
% or on in the original signal. We are using logical AND (&) 
% to calculate the signal without having to use a for loop and if statements.
pwm =  A*((t>=-tau/2)&(t<=tau/2));

% Build approx signal. Notice that we are defining the vector ab so that 
% ab = [a_0 a_1 a_2 ... a_M b_1 b_2 ... b_M]  where a_i and b_i refer to the
% the coefficients defined in equation (1) of the HW pdf file. Basically the "a" 
% coefficients come first, then the "b" coefficients next in a long vector.

%for loop defining approx for any M

approx = ab(1)*ones(1,length(t));

for i = 2:2*M+1
    if i < M+2  
        approx = approx + ab(i)*cos((i-1)*omega0*t);
    else
        approx = approx + ab(i)*sin((i-M-1)*omega0*t);
    end
end

%approx=ab(1)*ones(1,length(t)) ...
%   + ab(2)*cos(omega0*t) + ab(3)*cos(2*omega0*t) + ab(4)*cos(3*omega0*t) ...
%    + ab(5)*sin(omega0*t) + ab(6)*sin(2*omega0*t) + ab(7)*sin(3*omega0*t);

% TASK a) Complete this Riemann sum calculation of ISE
ISE = sum(dt*(pwm-approx).^2);

% These lines plot the approximate function on a graph. You can comment these out
% if you want your code to run faster.
%plot(t,approx,'LineWidth',0.5)
%pause(0.000001)   % This makes it show the iterations on the plot as it runs

end


