%PARAMETRES ICOSADEDRE

dx = 0.21;
dy = 0.14;
dz = 0.2;
alpha = 30*pi/180;

%% ISOCAEDRE
% Un moteur sur chacun des 12 sommets.
Nbr_OR = (1 + sqrt(5))/2;

%Etage d'actionnement sup?rieur
%(1) AVG
Moteur(1).position = [Nbr_OR 1 0];
Moteur(2).position = [Nbr_OR -1 0];
Moteur(3).position = [-Nbr_OR 1 0];
Moteur(4).position = [-Nbr_OR -1 0];
Moteur(6).position = [1, 0, -Nbr_OR];
Moteur(5).position = [1, 0, Nbr_OR];
Moteur(7).position = [-1, 0, Nbr_OR];
Moteur(8).position = [-1, 0, -Nbr_OR];
Moteur(9).position = [0, Nbr_OR, 1];
Moteur(10).position = [0, Nbr_OR, -1];
Moteur(12).position = [0, -Nbr_OR, -1];
Moteur(11).position = [0, -Nbr_OR, 1];

Moteur(1).orientation = [0 0 alpha];
Moteur(2).orientation = [0 0 -alpha];
Moteur(3).orientation = [0 0 (alpha+pi)];
Moteur(4).orientation = [0 0 (-alpha-pi)];
Moteur(5).orientation = [0 -pi/2 0];
Moteur(6).orientation = [0 -pi/2 0];
Moteur(7).orientation = [0 0 alpha];
Moteur(8).orientation = [0 0 -alpha];
Moteur(9).orientation = [0 0 (alpha+pi)];
Moteur(10).orientation = [0 0 (-alpha-pi)];
Moteur(11).orientation = [0 -pi/2 0];
Moteur(12).orientation = [0 -pi/2 0];

Moteur(1).Max_pos=1;
Moteur(2).Max_pos=1;
Moteur(3).Max_pos=1;
Moteur(4).Max_pos=1;
Moteur(5).Max_pos=1;
Moteur(6).Max_pos=1;
Moteur(7).Max_pos=1;
Moteur(8).Max_pos=1;
Moteur(9).Max_pos=1;
Moteur(10).Max_pos=1;
Moteur(11).Max_pos=1;
Moteur(12).Max_pos=1;

Moteur(1).Max_neg=-0.5;
Moteur(2).Max_neg=-0.5;
Moteur(3).Max_neg=-0.5;
Moteur(4).Max_neg=-0.5;
Moteur(5).Max_neg=-0.5;
Moteur(6).Max_neg=-0.5;
Moteur(7).Max_neg=-0.5;
Moteur(8).Max_neg=-0.5;
Moteur(9).Max_neg=-0.5;
Moteur(10).Max_neg=-0.5;
Moteur(11).Max_neg=-0.5;
Moteur(12).Max_neg=-0.5;

Moteur(1).DZ_pos=0;
Moteur(2).DZ_pos=0;
Moteur(3).DZ_pos=0;
Moteur(4).DZ_pos=0;
Moteur(5).DZ_pos=0;
Moteur(6).DZ_pos=0;
Moteur(7).DZ_pos=0;
Moteur(8).DZ_pos=0;
Moteur(9).DZ_pos=0;
Moteur(10).DZ_pos=0;
Moteur(11).DZ_pos=0;
Moteur(12).DZ_pos=0;

Moteur(1).DZ_neg=0;
Moteur(2).DZ_neg=0;
Moteur(3).DZ_neg=0;
Moteur(4).DZ_neg=0;
Moteur(5).DZ_neg=0;
Moteur(6).DZ_neg=0;
Moteur(7).DZ_neg=0;
Moteur(8).DZ_neg=0;
Moteur(9).DZ_neg=0;
Moteur(10).DZ_neg=0;
Moteur(11).DZ_neg=0;
Moteur(12).DZ_neg=0;

Moteur(1).Color = [0.5 0 0];
Moteur(2).Color = [1 0 0];
Moteur(3).Color = [0 0.5 0];
Moteur(4).Color = [0 1 0];
Moteur(5).Color = [0 0 0.5];
Moteur(6).Color = [0 0 1];
Moteur(7).Color = [0.5 0.5 0];
Moteur(8).Color = [0.5 1 0];
Moteur(9).Color = [0.5 0.5 0.5];
Moteur(10).Color = [0.5 0.5 1];
Moteur(11).Color = [1 0.5 0];
Moteur(12).Color = [1 0.5 0.5];


Moteur_EST = Moteur;

for i = 1:length(Moteur)
    Moteur_EST(i).orientation = [Moteur(i).orientation(1)*(1 +(rand-0.5)/10),...
        Moteur(i).orientation(2)*(1 +(rand-0.5)/10),...
        Moteur(i).orientation(3)*(1 +(rand-0.5)/10)];
end

save PARAM_Moteurs_ICOSAEDRE Moteur Moteur_EST


%%%% MODELE DYNAMIQUE

%% Parametres dynamiques du JAck
% m_u=10;m_v=11;m_w = 15;m_p=3;m_q=3;m_r=1;
% d_u=1;d_v=1;d_w=2;d_p=1;d_q=1;d_r=1;
Dyn_Robot.m_u=10;Dyn_Robot.m_v=10;Dyn_Robot.m_w=10;Dyn_Robot.m_p=1;Dyn_Robot.m_q=1;Dyn_Robot.m_r=1;
vd_u=1;Dyn_Robot.d_v=1;Dyn_Robot.d_w=1;Dyn_Robot.d_p=1;Dyn_Robot.d_q=1;Dyn_Robot.d_r=1;

Dyn_Robot_EST = Dyn_Robot;

save PARAM_Dyn_ICOSAEDRE Dyn_Robot Dyn_Robot_EST






