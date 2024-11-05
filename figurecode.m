% File name: figurecode.m
% Authors: Joseph, Natalie, Erin, George
% Author emails: jabdelmalek@hmc.edu, narce@hmc.edu, erinwang@hmc.edu,
% gdavis@hmc.edu
% Date Created: January 21, 2024


% This script reads data from our SD Card and plots acceleration of x y and
% z vs sample number onto one graph

clear;
%clf;

filenum = '036'; % file number for the data you want to read
infofile = strcat('INF', filenum, '.TXT');
datafile = strcat('LOG', filenum, '.BIN');

%% map from datatype to length in bytes
dataSizes.('float') = 4;
dataSizes.('ulong') = 4;
dataSizes.('int') = 4;
dataSizes.('int32') = 4;
dataSizes.('uint8') = 1;
dataSizes.('uint16') = 2;
dataSizes.('char') = 1;
dataSizes.('bool') = 1;

%% read from info file to get log file structure
fileID = fopen(infofile);
items = textscan(fileID,'%s','Delimiter',',','EndOfLine','\r\n');
fclose(fileID);
[ncols,~] = size(items{1});
ncols = ncols/2;
varNames = items{1}(1:ncols)';
varTypes = items{1}(ncols+1:end)';
varLengths = zeros(size(varTypes));
colLength = 256;
for i = 1:numel(varTypes)
    varLengths(i) = dataSizes.(varTypes{i});
end
R = cell(1,numel(varNames));

%% read column-by-column from datafile
fid = fopen(datafile,'rb');
for i=1:numel(varTypes)
    %# seek to the first field of the first record
    fseek(fid, sum(varLengths(1:i-1)), 'bof');
    
    %# % read column with specified format, skipping required number of bytes
    R{i} = fread(fid, Inf, ['*' varTypes{i}], colLength-varLengths(i));
    eval(strcat(varNames{i},'=','R{',num2str(i),'};'));
end
fclose(fid);

%% Process your data here

% Make acceleration plot
figure

% Plot all the accelerations on the same figure
hold on

% Plot x acceleration
plot((1000:2347), accelX(1000:2347))

% Plot y acceleration
plot((1000:2347), accelY(1000:2347))

% Plot z acceleration
plot((1000:2347), accelZ(1000:2347))

% Create label for axes and figure title
xlabel("Sample Number", 'FontSize', 17)
ylabel("Acceleration [cm/s^2] ", 'FontSize', 17)
title("Acceleration in X, Y, Z", 'FontSize', 20)

% Create legend distinguishing the different graphs
legend("accel_X", "accel_Y", "accel_Z", 'FontSize', 15)

% Turn on grid
grid on

hold off

