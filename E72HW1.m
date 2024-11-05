%Code from previous problems 
%A = [1 0 1 0 0;-3 1 0 1 1; 0 0 0 -2 -1]

%B = [1 0 1 1 0 0;1 1 -3 -1 1 0;-2 0 0 -1 -1 -1]

%M = null(B,"rational")

%nullB = B*M(:,1)

%Problem 4 b
format short
clear
clc
W = [];
B = [];
for w = logspace(6,8)
%w = 2*pi*1e6
Za = 50;
Zb = i*2*pi*w*620*10^-9;
Zc = i*2*pi*w*995*10^-9;
Zd = i*2*pi*w*620*10^-9;
Ze = (i*2*pi*w*90*10^-12)^-1;
Zf = (i*2*pi*w*360*10^-12)^-1;
Zx = (i*2*pi*w*360*10^-12)^-1;
Zy = (i*2*pi*w*90*10^-12)^-1;
Zz = 50;

Z = [((Za^-1)+(Zb^-1)+(Ze^-1))   (-Zb^-1)                    0                           0;
    (-Zb^-1)                     ((Zb^-1)+(Zc^-1)+(Zf^-1))   (-Zc^-1)                    0;
    0                            (-Zc^-1)                    ((Zc^-1)+(Zd^-1)+(Zx^-1))   (-Zd^-1);
    0                            0                           (-Zd^-1)                    ((Zd^-1)+(Zy^-1)+(Zz^-1))]

b = [5/Za; 0; 0; 0];

nodeV = Z\b;
lm = 20*log10(abs(nodeV(4)/5));

W(end+1) = w;
B(end+1) = lm;
end

semilogx(W,B,'-')
title('Low Pass Butterworth Filter Bode Plot')
xlabel('Frequency [rad/sec]')
ylabel('Magnitude [dB]')

