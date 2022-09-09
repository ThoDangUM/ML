% This script generates data set for deep learning based inverse problem in
% 2D with 4 thrusters
% written by: Tho Dang
clc;
clear all;
% Generate set of PWM(cm): c1,c2....,c4, ci in [Cmin-Cmax](us)
n1 = 41; % the number of elements of c1 set
n2 = 41; % the number of elements of c2 set
n3 = 41; % the number of elements of c3 set
n4 = 41; % the number of elements of c4 set
Cmax = 100;
Cmin = -100;
C_store = [];
fileID = fopen('Cm_Data_30_05_22.txt','w');
for i1=1:n1
    c1 = Cmin + ((i1-1)/(n1-1))*(Cmax-Cmin);
    for i2=1:n2
        c2 = Cmin + ((i2-1)/(n2-1))*(Cmax-Cmin);
        for i3=1:n3
            c3 = Cmin + ((i3-1)/(n3-1))*(Cmax-Cmin);
            for i4=1:n4
                c4 = Cmin + ((i4-1)/(n4-1))*(Cmax-Cmin);
                c = [c1 c2 c3 c4];
                % save results
                %C_store = [C_store c];
                fprintf(fileID,'%8.2f',c);
                fprintf(fileID,'\n');
            end
        end
    end
end
fclose(fileID);