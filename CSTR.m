%problem 1 HW11

clear

%F_V = 50;
F_V = 0.5;
E_R = 2600;
k_0 = 1750;
%beta = -1530;
beta = -15.3;
%alpha = 3;
alpha = 0.14;
Cf = 1;
Tf = 298;
Tc = 298;

%x = [T,C]

diff_eq = @(x) [(F_V*(Cf-x(2)))-(x(2)^2)*k_0*exp(-E_R/x(1)), (F_V*(Tf-x(1)))-k_0*beta*(x(2)^2)*exp(-E_R/x(1))+alpha*(Tc-x(1))];

a1 = [301.648,0.6948];
%a2 = [494.774,0.8637];
%a3 = [1164.033,0.4];


equilib_pts1 = fsolve(diff_eq, a1)
%equilib_pts2 = fsolve(diff_eq, a2)
%equilib_pts3 = fsolve(diff_eq, a3)

jacob_1 = [(-F_V-((equilib_pts1(2)^2)*beta*k_0*E_R*exp(-E_R/equilib_pts1(1)))/equilib_pts1(1)^2-alpha) , (-2*equilib_pts1(2)*beta*k_0*exp(-E_R/equilib_pts1(1)));
           -(((equilib_pts1(2)^2)*k_0*E_R*exp(-E_R/equilib_pts1(1)))/equilib_pts1(1)^2)         , (-F_V-2*equilib_pts1(2)*k_0*exp(-E_R/equilib_pts1(1)))];
%{        
jacob_2 = [(-F_V-((equilib_pts2(2)^2)*beta*k_0*E_R*exp(-E_R/equilib_pts2(1)))/equilib_pts2(1)^2-alpha) , (-2*equilib_pts2(2)*beta*k_0*exp(-E_R/equilib_pts2(1)));
           -(((equilib_pts2(2)^2)*k_0*E_R*exp(-E_R/equilib_pts2(1)))/equilib_pts2(1)^2)         , (-F_V-2*equilib_pts2(2)*k_0*exp(-E_R/equilib_pts2(1)))];

jacob_3 = [(-F_V-((equilib_pts3(2)^2)*beta*k_0*E_R*exp(-E_R/equilib_pts3(1)))/equilib_pts3(1)^2-alpha) , (-2*equilib_pts3(2)*beta*k_0*exp(-E_R/equilib_pts3(1)));
           -(((equilib_pts3(2)^2)*k_0*E_R*exp(-E_R/equilib_pts3(1)))/equilib_pts3(1)^2)         , (-F_V-2*equilib_pts3(2)*k_0*exp(-E_R/equilib_pts3(1)))];
%}
eig_1 = eig(jacob_1)
%eig_2 = eig(jacob_2)
%eig_3 = eig(jacob_3)
