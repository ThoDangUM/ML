% This script chooses decoupling data for training
% idea: 
clc;
clear all;
close all;
%% For velocity
% % INPUT: Y = [u v r]';
% % OUTPUT: Y_dc = [u_dc v_dc r_dc]';
% load Cube2D_Dataset.mat;
% u_dc = [];
% v_dc = [];
% r_dc = [];
% Cm_dc = [];
% for i=1:size(u,1)
%     if ((u(i)~=0)&(v(i)==0)&(r(i)==0))|((u(i)==0)&(v(i)~=0)&(r(i)==0))|((u(i)==0)&(v(i)==0)&(r(i)~=0)),
%         u_dc = [u_dc u(i)];
%         v_dc = [v_dc v(i)];
%         r_dc = [r_dc r(i)];
%         Cm_dc = [Cm_dc Cm(:,i)];
%     end
%         
% end
% Y_dc = [u_dc;v_dc;r_dc];
%%----------------------------------------
%% For acceleration
% INPUT: Y = [u v r]';
% OUTPUT: Y_dc = [u_dc v_dc r_dc]';
load Cube2D_Dataset_accel_01_06_22.mat;
u_dot_dc = [];
v_dot_dc = [];
r_dot_dc = [];
Cm_dc = [];
for i=1:size(u_dot,1)
    if ((u_dot(i)~=0)&(v_dot(i)==0)&(r_dot(i)==0))|((u_dot(i)==0)&(v_dot(i)~=0)&(r_dot(i)==0))|((u_dot(i)==0)&(v_dot(i)==0)&(r_dot(i)~=0)),
        u_dot_dc = [u_dot_dc u_dot(i)];
        v_dot_dc = [v_dot_dc v_dot(i)];
        r_dot_dc = [r_dot_dc r_dot(i)];
        Cm_dc = [Cm_dc Cm(:,i)];
    end
        
end
Y_dc = [u_dot_dc;v_dot_dc;r_dot_dc];
%