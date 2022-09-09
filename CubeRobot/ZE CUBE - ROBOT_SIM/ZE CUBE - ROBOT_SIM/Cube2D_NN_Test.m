% This script tests the Neural Network for Cube 2D
clc;
clear all;
%close all;
%% Generate a set of Yd = [u v r]'
Tsim = 300;
dt = 0.1;
Yd = zeros(3,Tsim);
Cmm = zeros(4,Tsim);
Y = zeros(3,Tsim);
for i=1:Tsim
    time(i) = dt*i;
    %------------------Step function--------------
%     if i<=100,
%         Yd(1,i) = 2;
%         Yd(2,i) = 0;
%         Yd(3,i) = 0;
%     else
%         if (i>100)&&(i<=200)
%             Yd(1,i) = 1.5;
%             Yd(2,i) = 0;
%             Yd(3,i) = 0;
%             
%         else
%             Yd(1,i) = 0.5;
%             Yd(2,i) = 0;
%             Yd(3,i) = 0;
%         end
%     end
    %-----------------------------------------------
    %----------------Sin function-------------------
    Yd(1,i)= 2*sin((2*pi/Tsim)*i);
    Yd(2,i)=0;
    Yd(3,i)=0;
    %-----------------------------------------------
    
end

%% Apply Yd to Neural Network to find Cm
for j=1:size(Yd,2)
    Cmm(:,j)= myNeuralNetworkFunction_30_BayesianR(Yd(:,j));
   % Cmm(:,j)= myNeuralNetworkFunction_41_sample(Yd(:,j));% 41 interval, 20
   % neurons for hidden layers, LM algorithm
end

%% Apply Cm to Cube simulation to find Y
for k = 1:size(Cmm,2)
    Y(:,k) = Cube_2D_PWM(Cmm(:,k));
end

%% Plot error/results
figure(5);
plot(time,Yd(1,:),'LineWidth',2);
hold on;
plot(time,Y(1,:),'LineWidth',2);
title('Surge speed(m/s)');
legend('ud','u');
xlabel('time(s)');
ylabel('u');
figure(6);
plot(time,Yd(2,:),'LineWidth',2);
hold on;
plot(time,Y(2,:),'LineWidth',2);
title('Sway speed(m/s)');
legend('vd','v');
xlabel('time(s)');
ylabel('v');
figure(7);
plot(time,Yd(3,:),'LineWidth',2);
hold on;
plot(time,Y(3,:),'LineWidth',2);
title('Yaw rate(degree/s)');
legend('rd','r');
xlabel('time(s)');
ylabel('r');
%% Plot in the same scale
figure(8);
plot(time,Yd(1,:),'LineWidth',2);
hold on;
plot(time,Y(1,:),'LineWidth',2);
plot(time,Yd(2,:),'LineWidth',2);
plot(time,Y(2,:),'LineWidth',2);
plot(time,Yd(3,:),'LineWidth',2);
plot(time,Y(3,:),'LineWidth',2);
legend('ud','u','vd','v','rd','r');
xlabel('time(s)');
ylabel('output');


