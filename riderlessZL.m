function output = riderlessZL(T,Y)
%x = [a_0, b_0, L]

funi = @(i) [T*cos(atan(i(1)))-w_factor*i(3)/i(2);
            log((i(1)+sqrt(1+i(1)^2))/(i(1)-i(2)+sqrt(1+(i(1)-i(2))^2)))/i(2)-X/i(3);
            (sqrt(1+i(1)^2)-sqrt(1+(i(1)-i(2))^2))/i(2)-Y/i(3)];

x_0 = [0.2,0.2,500];
i_ans = fsolve(funi,x_0)
a_0 = i_ans(1)
b_0 = i_ans(2)

%plot the caternary
f = linspace(0,1,1000);
Xtilde = log((a_0+sqrt(1+a_0^2))./(a_0-b_0*f+sqrt(1+(a_0-b_0*f).^2)))/b_0;
Ytilde = (sqrt(1+a_0^2)-sqrt(1+(a_0-b_0*f).^2))/b_0;

outputi = [Xtilde,Ytilde,L]

%plot(Xtilde,-Ytilde)
%ylabel('Y')
%xlabel('X')
%title('Zipline Plot Without a Rider')
