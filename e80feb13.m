T = [0.9 13.4 24 30 43 57 65 76.8] + 273; % The temperatures.
R = [156700 79000 46000 33600 19200 10500 8800 5700]; % The resistances.
confLev = 0.95;

xT = 273:1:353;
recipxT = 1./xT;

refR = 47000;
refT = 298;
B = 4101;
TC = (B.*T)./(refT*log(R./refR)+B);
%lnpredR = log(predR);

figure(1) 
plot(R,T, ".")
hold on
plot (R,TC,'x')
xlabel('Resistance (\Omega)')
ylabel('Temperature (K)')
title('Thermometer and Thermistor Temperatures')
legend('Thermometer Temperatures','Thermistor Temperatures')
hold off

%% Plot Linear Data

% Turn it linear
recipT = 1./T;
recipTC = 1./TC;
lnR = log(R);

figure(2) 
plot(lnR,recipT)
hold on
plot (lnR,recipTC,'x')
xlabel('ln[Resistance (\Omega)]')
ylabel('Reciprocal Temperature (1/K)')
title('Linear Thermometer and Thermistor Data')
legend('Digital Thermometer Temperatures','Thermistor Temperatures')
hold off

%% Hi

range = max(lnR) - min(lnR); % range for our xplot data
xplot = min(lnR):range/30:max(lnR); % Generate x data for some of our plots.

% Formating
[Xout,Yout] = prepareCurveData(lnR, recipT); 
[f1,stat1] = fit(Xout,Yout,'poly1'); % 1st-order fit with statistics.
[f2,stat2] = fit(Xout,Yout,'poly2'); % 2nd-order fit with statistics.
[f3,stat3] = fit(Xout,Yout,'poly3'); % 3rd-order fit with statistics.
[f4,stat4] = fit(Xout,Yout,'poly4'); % 4th-order fit with statistics.

%% Plot Residuals
figure(4)
subplot(3,1,1)
plot(f1,Xout,Yout,'residuals')
% xlabel('Ln[Resistance (\Omega)]')
ylabel('Residuals (1/K)')
title('1st Order Polynomial Fit')

subplot(3,1,2)
plot(f2,Xout,Yout,'residuals')
% xlabel('Ln[Resistance (\Omega)]')
ylabel('Residuals (1/K)')
title('2nd Order Polynomial Fit')

subplot(3,1,3)
plot(f3,Xout,Yout,'residuals')
xlabel('Ln[Resistance (\Omega)]')
ylabel('Residuals (1/K)')
title('3rd Order Polynomial Fit')

%% Plot Final Fit for Thermometer and Bounds
p11 = predint(f2,xplot,confLev,'observation','off');
p21 = predint(f2,xplot,confLev,'functional','off');
figure(5)
plot(f2,Xout,Yout)
hold on
plot(xplot, p21, '-.b') % Upper and lower functional confidence limits
plot(xplot, p11, '--m') % Upper and lower observational confidence limits
xlabel('Ln[Resistance (\Omega)]')
ylabel('Reciprocal Temperature (1/K)')
title('_____ Order Polynomial Fit, Thermometer Data')
legend('Data Points','Best Fit Line','Upper Func. Bound',...
    'Lower Func. Bound', 'Upper Obs. Bound', 'Lower Obs. Bound',...
    'Location', 'northwest')
hold off

%% Final Fit for Thermistor

[Xout,Yout] = prepareCurveData(lnR, recipTC); 
[refXout,refYout] = prepareCurveData(lnpredR, recipxT); 
[f2,stat1] = fit(Xout,Yout,'poly2') % 1st-order fit with statistics.
p11 = predint(f2,xplot,confLev,'observation','off'); % Gen conf bounds
p21 = predint(f2,xplot,confLev,'functional','off'); % Gen conf bounds
figure(6)
plot(f2,Xout,Yout)
hold on
plot(xplot, p21, '-.b') % Upper and lower functional confidence limits
plot(xplot, p11, '--m') % Upper and lower observational confidence limits
xlabel('Ln[Resistance (\Omega)]')
ylabel('Reciprocal Temperature (1/K)')
title('____ Order Polynomial Fit, Thermistor Data')
legend('Data Points','Best Fit Line','Upper Func. Bound',...
    'Lower Func. Bound', 'Upper Obs. Bound', 'Lower Obs. Bound',...
    'Location', 'northwest')
hold off
