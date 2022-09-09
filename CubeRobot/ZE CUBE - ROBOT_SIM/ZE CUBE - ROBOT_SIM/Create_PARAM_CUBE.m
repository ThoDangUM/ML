%PARAMETRES DU CUBE
clear all
d=0.27;
%%%% MOTEURS %%%%
Moteur(1).position=[d -d -d];
Moteur(2).position=[d d -d];
Moteur(3).position=[d d d];
Moteur(4).position=[d -d d];
Moteur(5).position=[-d -d -d];
Moteur(6).position=[-d d -d];
Moteur(7).position=[-d d d];
Moteur(8).position=[-d -d d];

Moteur(1).orientation=[0    0    pi/2];
Moteur(2).orientation=[0    0    0];
Moteur(3).orientation=[0    pi/2    0];
Moteur(4).orientation=[0    0    -pi/2];
Moteur(5).orientation=[0    0    pi/2];
Moteur(6).orientation=[0    -pi/2    0];
Moteur(7).orientation=[0    0    pi];
Moteur(8).orientation=[0    pi/2    0];

Moteur(1).Max_pos=40;
Moteur(2).Max_pos=42;
Moteur(3).Max_pos=38;
Moteur(4).Max_pos=37;
Moteur(5).Max_pos=39;
Moteur(6).Max_pos=35;
Moteur(7).Max_pos=40;
Moteur(8).Max_pos=37;

Moteur(1).Max_neg=-20;
Moteur(2).Max_neg=-22;
Moteur(3).Max_neg=-18;
Moteur(4).Max_neg=-17;
Moteur(5).Max_neg=-22;
Moteur(6).Max_neg=-21;
Moteur(7).Max_neg=-17;
Moteur(8).Max_neg=-20;

Moteur(1).DZ_pos=12;
Moteur(2).DZ_pos=11;
Moteur(3).DZ_pos=10;
Moteur(4).DZ_pos=9;
Moteur(5).DZ_pos=8;
Moteur(6).DZ_pos=13;
Moteur(7).DZ_pos=12;
Moteur(8).DZ_pos=9;

Moteur(1).DZ_neg=-10;
Moteur(2).DZ_neg=-9;
Moteur(3).DZ_neg=-11;
Moteur(4).DZ_neg=-7;
Moteur(5).DZ_neg=-8;
Moteur(6).DZ_neg=-11;
Moteur(7).DZ_neg=-12;
Moteur(8).DZ_neg=-10;

Moteur(1).Color=[0.5 0 0];
Moteur(2).Color=[ 1 0 0];
Moteur(3).Color=[0 0.5  0];
Moteur(4).Color=[0 1 0];
Moteur(5).Color=[0 0 0.5];
Moteur(6).Color=[0 0 1];
Moteur(7).Color=[0.5 0.5 0];
Moteur(8).Color=[0.5 1 0];

Moteur_EST = Moteur;

for i = 1:length(Moteur)
    Moteur_EST(i).orientation = [Moteur(i).orientation(1)*(1 +(rand-0.5)/10),...
        Moteur(i).orientation(2)*(1 +(rand-0.5)/10),...
        Moteur(i).orientation(3)*(1 +(rand-0.5)/10)];
end

for i = 1:length(Moteur)
    Moteur_EST(i).Max_pos=40;
    Moteur_EST(i).Max_neg=-20;
    %Moteur_EST(i).DZ_pos=15;
    %Moteur_EST(i).DZ_neg=-15;
end


save PARAM_Moteurs_CUBE_REEL Moteur Moteur_EST


%%%% MODELE DYNAMIQUE

%% Parametres dynamiques du JAck
% m_u=10;m_v=11;m_w = 15;m_p=3;m_q=3;m_r=1;
% d_u=1;d_v=1;d_w=2;d_p=1;d_q=1;d_r=1;
Dyn_Robot.m_u=10;Dyn_Robot.m_v=10;Dyn_Robot.m_w=10;Dyn_Robot.m_p=1;Dyn_Robot.m_q=1;Dyn_Robot.m_r=1;
Dyn_Robot.d_u=1;Dyn_Robot.d_v=1;Dyn_Robot.d_w=1;Dyn_Robot.d_p=1;Dyn_Robot.d_q=1;Dyn_Robot.d_r=1;

Dyn_Robot_EST = Dyn_Robot;

save PARAM_Dyn_CUBE_REEL Dyn_Robot Dyn_Robot_EST






