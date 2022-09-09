% This script plots the robot's data
clc
clear all
close all
% open the file and read data
fileID = fopen('Robot_data.txt','r');
for k=1:7,
   line = fgetl(fileID);
   ldata = sscanf(line,'%f');
%   PWM(k,:) = ldata';
    ETAT(k,:) = ldata';
end
fclose(fileID);
% plot data X
plot(ETAT(:,18));
hold on;
plot(ETAT(:,19));
plot(ETAT(:,20));
legend('p','q','r');
xlabel('Time(s)');
ylabel('angular rate(m/s)');
