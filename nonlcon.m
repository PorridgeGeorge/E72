% exit_velo > 0 & < 5
% 70kg rider is going as fast as possible
% 1
% T < 500000 < Vertical drop < 40

% 30kg rider exit velo squared > 0
% 140kg rider exit velo squared < 25
% 10 < Vertical drop < 40
% T < 50000

function [c, ceq] = nonlcon(K)
Y = K(1); %Vertical Drop
T = K(2); %Tension w/o Rider

%Troubleshooting notes: This file tracks with the canvas hints

EV_lb = velocity72([Y T 30]);
EV_lb = EV_lb(2);

EV_ub = velocity72([Y T 140]);
EV_ub = EV_ub(2);

c = [-EV_lb; EV_ub-25];
ceq = [];
end




