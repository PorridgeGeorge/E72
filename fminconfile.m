%X = [Y T]
clear
clc


x0 = [40 40000];
A = [];
b =[];
Aeq = [];
beq = [];
lb = [35 35000];
ub = [40 50000];
%opts = optimset('Algorithm','interior-point','DiffMinChange',1e-2);
fmincon(@ziplineOBJ,x0,A,b,Aeq,beq,lb,ub,@nonlcon)
%ans = 1.0e+04 * [0.0040 3.9571]