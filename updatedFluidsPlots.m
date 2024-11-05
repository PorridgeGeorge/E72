clf
clear
clc

%COMSOL

sn1_Force = [0.022175 0.19861 0.55117 1.0799 1.7847];
sn2_Force = [0.016459 0.14724 0.40852 0.80027 1.3225];
sn3_Force = [0.011616 0.10355 0.28707 0.56218 0.92886];

sn1_Coef = [0.7530989981 0.7494575574 0.748745118 0.7484725933 0.7482877682];
sn2_Coef = [0.558974359 0.5556121583 0.5549600951 0.554662619 0.5544968753];
sn3_Coef = [0.394498217 0.3907473444 0.3899745288 0.3896437842 0.3894517714];


sim_reynolds = [49723.75691 149171.2707 248618.7845 348066.2983 447513.8122];

%Wind Tunnel

wn1_Force = [0.06867 0.11772 0.18639 0.27468 0.3924 0.50031 0.66708 0.81423 0.96138];
wn2_Force = [0.02943 0.04905 0.07848 0.10791 0.15696 0.20601 0.25506 0.2943 0.37278];
wn3_Force = [0.02943 0.05886 0.07848 0.10791 0.16677 0.20601 0.27468 0.33354 0.38259];

wn1_Coef = [1.033853956 0.9940167649 1.005504919 0.9969181633 0.9940702683 0.988261695 1.007189828 0.9941201762 0.9759982453];
wn2_Coef = [0.4757725972 0.4004860356 0.4081544836 0.3755476151 0.3916570624 0.3910399739 0.3876228617 0.3597418748 0.3685398999];
wn3_Coef = [0.5032773755 0.4540697168 0.4212929906 0.4182433867 0.422479864 0.4081467751 0.4109687998 0.4058024547 0.3834757531];

wn1_Reyn = [91753.2376 122516.8277 153280.4178 186875.0131 223678.0809 253309.2689 289734.8695 322197.0627 353338.1201];
wn2_Reyn = [88544.76501 124592.8982 156111.423 190838.4204 225376.6841 258405.0783 288791.201 322008.329 358056.4621];
wn3_Reyn = [97264.26893 144814.0698 173599.8238 204304.6279 252707.3401 285757.6501 328829.6671 364651.9386 401753.577];

%Difference Calculations

%Forces
xq = 100000 : 100 : 350000;         %define the discrete x values

vqS1 = interp1(sim_reynolds,sn1_Force,xq); %compute new y values
vqT1 = interp1(wn1_Reyn,wn1_Force,xq); %compute new y values
Fx1 = mean(abs(vqS1 - vqT1))

vqS2 = interp1(sim_reynolds,sn2_Force,xq); %compute new y values
vqT2 = interp1(wn2_Reyn,wn2_Force,xq); %compute new y values
Fx2 = mean(abs(vqS2 - vqT2))

vqS3 = interp1(sim_reynolds,sn3_Force,xq); %compute new y values
vqT3 = interp1(wn3_Reyn,wn3_Force,xq); %compute new y values
Fx3 = mean(abs(vqS3 - vqT3))

%Coefficients
vqSa = interp1(sim_reynolds,sn1_Coef,xq); %compute new y values
vqTa = interp1(wn1_Reyn,wn1_Coef,xq); %compute new y values
Cx1 = mean(abs(vqSa - vqTa))

vqSb = interp1(sim_reynolds,sn2_Coef,xq); %compute new y values
vqTb = interp1(wn2_Reyn,wn2_Coef,xq); %compute new y values
Cx2 = mean(abs(vqSb - vqTb))

vqSc = interp1(sim_reynolds,sn3_Coef,xq); %compute new y values
vqTc = interp1(wn3_Reyn,wn3_Coef,xq); %compute new y values
Cx3 = mean(abs(vqSc - vqTc))
% df_1 = (abs(sn1_Force - wn1_Force))
% df_2 = sn1_Force - wn1_Force
% df_3 = sn1_Force - wn1_Force
% 
% dc_1 = sn1_Coef - wn1_Coef
% dc_1 = sn1_Coef - wn1_Coef
% dc_1 = sn1_Coef - wn1_Coef
figure(1)
plot(sim_reynolds,sn1_Force,'LineWidth',3)
hold on
plot(wn1_Reyn,wn1_Force,'LineWidth',3,'LineStyle','-.')
hold on

plot(sim_reynolds,sn2_Force,'LineWidth',3)
hold on
plot(wn2_Reyn,wn2_Force,'LineWidth',3,'LineStyle','-.')
hold on

plot(sim_reynolds,sn3_Force','LineWidth',3)
hold on
plot(wn3_Reyn,wn3_Force,'LineWidth',3,'LineStyle','-.')

xlabel('Reynolds Number','FontSize',30)
ylabel('Drag Force [N]','FontSize',30)
title('COMSOL and Wind Tunnel Drag Forces','FontSize',35)
legend('SIM Cone #1','WIND TUNNEL Cone #1','SIM Cone #2','WIND TUNNEL Cone #2','SIM Cone #3','WIND TUNNEL Cone #3','FontSize',20)
mycolors = [1 0 0; 0.8500 0.3250 0.0980; 0 1 0; 0.4660 0.6740 0.1880; 0 0 1;0.3010 0.7450 0.9330];
ax = gca;
ax.ColorOrder = mycolors;
ax.FontSize = 25;
xlim([50000 450000])


figure(2)
plot(sim_reynolds,sn1_Coef,'LineWidth',3)
hold on
plot(wn1_Reyn,wn1_Coef,'LineWidth',3,'LineStyle','-.')
hold on

plot(sim_reynolds,sn2_Coef,'LineWidth',3)
hold on
plot(wn2_Reyn,wn2_Coef,'LineWidth',3,'LineStyle','-.')
hold on

plot(sim_reynolds,sn3_Coef,'LineWidth',3)
hold on
plot(wn3_Reyn,wn3_Coef,'LineWidth',3,'LineStyle','-.')

xlabel('Reynolds Number','FontSize',30)
ylabel('Coefficient of Drag','FontSize',30)
title('COMSOL and Wind Tunnel Coefficients of Drag','FontSize',35)
legend('SIM Cone #1','WIND TUNNEL Cone #1','SIM Cone #2','WIND TUNNEL Cone #2','SIM Cone #3','WIND TUNNEL Cone #3','FontSize',20)
mycolors2 = [1 0 0; 0.8500 0.3250 0.0980; 0 1 0; 0.4660 0.6740 0.1880; 0 0 1;0.3010 0.7450 0.9330];
ax = gca;
ax.ColorOrder = mycolors2;
ax.FontSize = 25;
xlim([50000 450000])









