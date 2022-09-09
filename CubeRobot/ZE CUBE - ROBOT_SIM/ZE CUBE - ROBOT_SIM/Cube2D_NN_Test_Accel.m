% This script tests the Neural Network for Cube 2D: test acceleration
clc;
clear all;
close all;
%% Generate a set of Yd = [u_dot v_dot r_dot]'
Tsample = 300;
dt = 0.1;
Yd = zeros(3,Tsample);
Cmm = zeros(4,Tsample);
Y = zeros(3,Tsample);
for i=1:Tsample
    time(i) = dt*i;
%    sample(i) = i;
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
%     Yd(1,i)= 2*sin((2*pi/Tsample)*i);
%     Yd(2,i)=0;
%     Yd(3,i)=0;
    %-----------------------------------------------
    %---------------------triangle function------------------
    if i<=100,
        Yd(1,i) = (2/100)*i;
        Yd(2,i) = 0;
        Yd(3,i) = 0;
    else 
        if (i>100)&&(i<=200),
            Yd(1,i) = (3-i/100);
            Yd(2,i) = 0;
            Yd(3,i) = 0;
        else
            Yd(1,i) = 1;
            Yd(2,i) = 0;
            Yd(3,i) = 0;
        end
        
    end
    %-----------------------------------------------
end

%% Apply Yd to Neural Network to find Cm
for j=1:size(Yd,2)
    Cmm(:,j)= myNeuralNetworkFunction_30_Bayesian_accel(Yd(:,j));
   % Cmm(:,j)= myNeuralNetworkFunction_41_sample(Yd(:,j));% 41 interval, 20
   % neurons for hidden layers, LM algorithm
end

%% Apply Cm to Cube simulation to find Y
for k = 1:size(Cmm,2)
    Y(:,k) = Cube_2D_PWM_Accel(Cmm(:,k));
end

%% Plot error/results
figure(5);
plot(time,Yd(1,:),'LineWidth',2);
hold on;
plot(time,Y(1,:),'LineWidth',2);
title('Surge accel(m/s^2)');
legend('ud-dot','u-dot');
xlabel('time(s)');
ylabel('u-dot');
figure(6);
plot(time,Yd(2,:),'LineWidth',2);
hold on;
plot(time,Y(2,:),'LineWidth',2);
title('Sway accel(m/s^2)');
legend('vd-dot','v-dot');
xlabel('time(s)');
ylabel('v-dot');
figure(7);
plot(time,Yd(3,:),'LineWidth',2);
hold on;
plot(time,Y(3,:),'LineWidth',2);
title('Yaw accel(degree/s^2)');
legend('rd-dot','r-dot');
xlabel('time(s)');
ylabel('r-dot');
%% Plot in the same scale
figure(8);
plot(time,Yd(1,:),'LineWidth',2);
hold on;
plot(time,Y(1,:),'LineWidth',2);
plot(time,Yd(2,:),'LineWidth',2);
plot(time,Y(2,:),'LineWidth',2);
plot(time,Yd(3,:),'LineWidth',2);
plot(time,Y(3,:),'LineWidth',2);
legend('ud-dot','u-dot','vd-dot','v-dot','rd-dot','r-dot');
xlabel('time(s)');
ylabel('output');


