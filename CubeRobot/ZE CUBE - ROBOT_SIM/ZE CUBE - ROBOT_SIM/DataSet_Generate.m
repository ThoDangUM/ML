% This script generates data set for deep learning based inverse problem
% written by: Tho Dang
clc;
clear all;
% Generate set of PWM(cm): c1,c2....,c8, ci in [Cmin-Cmax](us)
n1 = 5; % the number of elements of c1 set
n2 = 5; % the number of elements of c2 set
n3 = 5; % the number of elements of c3 set
n4 = 5; % the number of elements of c4 set
n5 = 5; % the number of elements of c5 set
n6 = 5; % the number of elements of c6 set
n7 = 5; % the number of elements of c7 set
n8 = 5; % the number of elements of c8 set
Cmax = 100;
Cmin = -100;
C_store = [];
fileID = fopen('Cm_Data_19_05_22.txt','w');
for i1=1:n1
    c1 = Cmin + ((i1-1)/(n1-1))*(Cmax-Cmin);
    for i2=1:n2
        c2 = Cmin + ((i2-1)/(n2-1))*(Cmax-Cmin);
        for i3=1:n3
            c3 = Cmin + ((i3-1)/(n3-1))*(Cmax-Cmin);
            for i4=1:n4
                c4 = Cmin + ((i4-1)/(n4-1))*(Cmax-Cmin);
                for i5=1:n5
                    c5 = Cmin + ((i5-1)/(n5-1))*(Cmax-Cmin);
                    for i6=1:n6
                        c6 = Cmin + ((i6-1)/(n6-1))*(Cmax-Cmin);
                        for i7=1:n7
                            c7 = Cmin + ((i7-1)/(n7-1))*(Cmax-Cmin);
                            for i8=1:n8
                                c8 = Cmin + ((i8-1)/(n8-1))*(Cmax-Cmin);
                                c = [c1 c2 c3 c4 c5 c6 c7 c8];
                                % save results
                                %C_store = [C_store c];
                                fprintf(fileID,'%8.2f',c);
                                fprintf(fileID,'\n');
                            end
                        end
                    end
                end
            end
        end
    end
end
fclose(fileID);