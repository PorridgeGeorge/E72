Square_Errors = [];
m = 1:50;
%Generates ISEs
for i = m
    Square_Errors(end+1) = fourierplotter(1,1,0.25,i);
end

%Plots ISE vs. Harmonics
plot(m,Square_Errors)
xlabel('Harmonics k');
ylabel('ISE')
title('ISE as a function of M')