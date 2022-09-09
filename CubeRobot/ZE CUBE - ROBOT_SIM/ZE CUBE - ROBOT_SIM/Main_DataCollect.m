clear all
clc
close all

load PARAM_Moteurs_CUBE_REEL
load PARAM_Dyn_CUBE_REEL
Concentrateur = Calcul_Concentrateur(Moteur);
%Initialisations
X = [0 0 0];% x y z % POSITION ITINITALE
%Eta = [rand rand rand];%phi theta psi % ATTITUDE ITINITALE
Eta = [0 0 0];
V_B = 0*[0 3 0];% u v w % VITESSES LINEAIRES ITINITALES
W_B = 0*[0 0 3];% p q r% VITESSES ROTATIONELLES ITINITALES

Q_B_0 = angle2quat(Eta(3),Eta(2),Eta(1)); % why eta(3), eta(2), eta(1)? not other orders???
Q_Temp = quatmultiply(quatmultiply(Q_B_0,[0 V_B]),quatconj(Q_B_0));
V_0 =  Q_Temp(2:4);
dt =0.1;
Q0_ZAP = Q_B_0;

tic
INIT_GRAPH_Pos_Moteurs
%
hold on
count = 0;
%pause(10);
%
fileRobot = fopen('Robot_data.txt','w');
fileID = fopen('Cm_Data.txt','r');
% read PWM value
% load PWM from text file: 10 first line
for k=1:2,
   line = fgetl(fileID);
   ldata = sscanf(line,'%f');
%   PWM(k,:) = ldata';
    PWM = ldata';


% apply to the robot in t time
    for j = 1:20
    % toc; tic
    time = j*dt;
    Q_Temp = quatmultiply(quatmultiply(quatconj(Q_B_0),[0 V_0]),Q_B_0);
    V_B = Q_Temp(2:4);
    dot_Q_B_0 = 0.5*quatmultiply(Q_B_0,[0 W_B]);

    
    %% Application du modele dynamique pour estimer les accelerations resultantes
    ETAT = [Q_B_0,dot_Q_B_0,X,V_0];
    [ETAT_NEW,F_B_Effective,F_M_Effective]=Modele_Dynamique_Integration(ETAT,Concentrateur,PWM,Dyn_Robot,Moteur,dt);
    Q_B_0 = ETAT_NEW(1:4);
    dot_Q_B_0 = ETAT_NEW(5:8);
    X = ETAT_NEW(9:11);
    V_0 = ETAT_NEW(12:14);
    
    [Q_Temp]=2*quatmultiply(quatinv(Q_B_0),dot_Q_B_0);
    W_B = Q_Temp(2:4);
    
%     %Stockage des donnees
%     X_Stock(j)=X(1);
%     Y_Stock(j)=X(2);
%     Z_Stock(j)=X(3);
%     W_B_STOCK(:,j) = W_B;
%     TIME(j) = time;
%     PWM_STOCK(:,j) = PWM;
%     V_B_STOCK(:,j) = V_B;
%     [PSI_STOCK(j),ROLL_STOCK(j),PHI_STOCK(j)] = quat2angle(Q_B_0);
    
    % write data to a text file
    fprintf(fileRobot,'%8.2f',ETAT_NEW);
    fprintf(fileRobot,'\n');
    
    %Mise a jour graphique
    count = count + 1;
    MISE_A_JOUR_GRAPHIQUE
%     if count>10,
%         MISE_A_JOUR_GRAPHIQUE
%         count = 0;
%     end
    
%    M(j)=getframe(gcf); % for making the video
  %   i = i+1;
    end
end
fclose(fileID);
fclose(fileRobot);

%% plot the results
% figure()
% plot(TIME,PWM_STOCK);title('PWM')
% figure()
% plot(TIME,W_B_STOCK);title('W_B (rad/s')
% figure()
% plot(TIME,V_B_STOCK);title('V_B')
% figure()
% plot(TIME,PHI_STOCK,'r');title('\phi (r), \theta (g), \psi (b)')
% hold on
% plot(TIME,ROLL_STOCK,'g')
% plot(TIME,PSI_STOCK,'b')
% figure()
% plot3(X_Stock,Y_Stock,Z_Stock);title('trajectoire');grid
% figure()
% plot(TIME,X_Stock,'r');title('X (r), Y (g), Z (b)')
% hold on
% plot(TIME,Y_Stock,'g')
% plot(TIME,Z_Stock,'b')


