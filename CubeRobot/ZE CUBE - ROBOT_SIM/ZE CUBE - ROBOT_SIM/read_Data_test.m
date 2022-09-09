% read a partial of a text file
clc
clear all;
fileID = fopen('Cm_Data.txt','r');
%formatSpec = '%f';
%sizeA = [3 Inf];
%A = fscanf(fileID,formatSpec);
for k=1:10
    line = fgetl(fileID);
    ldata = sscanf(line,'%f');
    A(k,:) = ldata';
end
%fclose(fileID);