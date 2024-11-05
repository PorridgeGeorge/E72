% This function plays a chord composed of three frequencies
% E72 Spr 2024, Profs. Bassman, Nembhard, Yong

fs = 44000;     % sampling frequency - sets # of points and needs to be sufficiently high 
t = [0:1/fs:1]; % vector of times to use for playing the chord

% Components of the chord, which we refer to as x(t) in the problem statement.
freqC = 392; % Hz - G4, the G above middle C
freqE = 494; % Hz - B4, the B above middle C
freqG = 587; % Hz - D5

% Create sinusoids with chord frequencies and sum them
cos1 = cos(2*pi*freqC*t);
cos2 = cos(2*pi*freqE*t);
cos3 = cos(2*pi*freqG*t);
x = cos1 + cos2 + cos3;

y = x.*cos(2*pi*1000*t)

% Play the summed signal
soundsc(x,fs)
pause(2)
soundsc(y,fs)
