counter = 1
output = []
m = [3 5 10 20 40 50];
for i = m
    output(end+1) = fouriersawtooth(1,86400,i,counter);
    counter = counter + 1
end

figure(2)
%Plot ISEs vs. Harmonics
plot(m,output)
xlabel('Harmonics k');
ylabel('ISE')
title('ISE as a function of M')
