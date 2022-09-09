clear all
clc
close all

load PARAM_Moteurs_CUBE_REEL
load PARAM_Dyn_CUBE_REEL

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
pause(10);
for j = 1:200
    % toc; tic
    time = j*dt;
    Q_Temp = quatmultiply(quatmultiply(quatconj(Q_B_0),[0 V_0]),Q_B_0);
    V_B = Q_Temp(2:4);
    dot_Q_B_0 = 0.5*quatmultiply(Q_B_0,[0 W_B]);

    %% CALCUL DES REFERENCES
    if j==1,%Initialisation
        a1 = atan2(1/sqrt(2),1);
        Q1 = [cos(a1/2) sin(a1/2) 0 0];
        a2 = -pi/4;
        Q2 = [cos(a2/2) 0 sin(a2/2) 0];
        Q_D = quatmultiply(Q1,Q2);
        INT_ERREUR_V_B = [0 0 0]'; INT_DPHI=0; INT_DTHETA=0; INT_DPSI=0;Qe_INT=[0 0 0 0];INT_Q = [0 0 0 0];
        Concentrateur = Calcul_Concentrateur(Moteur);
        %     NOYAU = null(Concentrateur);
        %     F_M_0_1 = NOYAU(:,1);
        %     F_M_0_2 = NOYAU(:,2);
    end
    W_D = [0 1 1 1];
    dot_W_D = [0 0 0 0];
    X_D = [0 0 1]';
    V_B_DES = [0 0 0]';
    dot_V_B_DES = [0 0 0]';
    dot_Q_D = .5*quatmultiply(Q_D,W_D);
    W_D = 2*quatmultiply(quatconj(Q_D),dot_Q_D);
    ddot_Q_D = .5*( quatmultiply(dot_Q_D,W_D) + quatmultiply(Q_D,dot_W_D));
    dot_W_D = quatmultiply(quatconj(Q_D),(ddot_Q_D - .5*(quatmultiply(dot_Q_D,W_D))));
    Q_D = quatnormalize(Q_D + dot_Q_D*dt);
    
    %% CALCUL DES ACCELERATIONS ROTATIONELLES DE CONTROLE
    [dot_W_B_CONTROL]=Control_Acc_Rot(Q_B_0,W_B,Q_D,dot_Q_D,ddot_Q_D);
    %% CALCUL DES ACCELERATIONS LINEAIRES DE CONTROLE
    [dot_V_B_CONTROL]=Control_Acc_Lin(Q_B_0,X,V_B,X_D,dot_V_B_DES);
    %% CALCUL DES FORCES DESIREES BODY_FRAME
    [F_B_DES]=Robot_Dyn_Model(W_B,dot_W_B_CONTROL,V_B,dot_V_B_CONTROL,Dyn_Robot);
    %% CALCUL DES FORCES MOTEURS
    F_M_CONTROL = pinv(Concentrateur)*F_B_DES;
    %% CALCUL DES ENTREES MOTEURS
    PWM =Carract_INV_Moteurs(Moteur,F_M_CONTROL);%Moteur_EST
    
    
    
    %% Application du modele dynamique pour estimer les accelerations resultantes
    ETAT = [Q_B_0,dot_Q_B_0,X,V_0];
    [ETAT_NEW,F_B_Effective,F_M_Effective]=Modele_Dynamique_Integration(ETAT,Concentrateur,PWM,Dyn_Robot,Moteur,dt);
    Q_B_0 = ETAT_NEW(1:4);
    dot_Q_B_0 = ETAT_NEW(5:8);
    X = ETAT_NEW(9:11);
    V_0 = ETAT_NEW(12:14);
    
    [Q_Temp]=2*quatmultiply(quatinv(Q_B_0),dot_Q_B_0);
    W_B = Q_Temp(2:4);
    
    %Stockage des donnees
    X_Stock(j)=X(1);
    Y_Stock(j)=X(2);
    Z_Stock(j)=X(3);
    W_B_STOCK(:,j) = W_B;
    TIME(j) = time;
    PWM_STOCK(:,j) = PWM;
    V_B_STOCK(:,j) = V_B;
    [PSI_STOCK(j),ROLL_STOCK(j),PHI_STOCK(j)] = quat2angle(Q_B_0);
    
    %Mise a jour graphique
    count = count + 1;
    MISE_A_JOUR_GRAPHIQUE
%     if count>10,
%         MISE_A_JOUR_GRAPHIQUE
%         count = 0;
%     end
    
    M(j)=getframe(gcf); % for making the video
  %   i = i+1;
end


figure()
plot(TIME,PWM_STOCK);title('PWM')
figure()
plot(TIME,W_B_STOCK);title('W_B (rad/s')
figure()
plot(TIME,V_B_STOCK);title('V_B')
figure()
plot(TIME,PHI_STOCK,'r');title('\phi (r), \theta (g), \psi (b)')
hold on
plot(TIME,ROLL_STOCK,'g')
plot(TIME,PSI_STOCK,'b')
figure()
plot3(X_Stock,Y_Stock,Z_Stock);title('trajectoire');grid
figure()
plot(TIME,X_Stock,'r');title('X (r), Y (g), Z (b)')
hold on
plot(TIME,Y_Stock,'g')
plot(TIME,Z_Stock,'b')

% %% Create video does not run in Matlab Ubuntu, check again by adding folder in Matlab path
% %% to watch again the movie
% movie(gcf,M) % this command avoids the appearance of two coordinate systems in video
% %% to create a video
% %video = VideoWriter('UmRobotfixedConfig.avi','Uncompressed AVI');
% video = VideoWriter('CubeRobotsimulation.avi','MPEG-4');
% video.FrameRate = 10;
% open(video);
% writeVideo(video,M);
% close(video);

