function [ETAT_NEW,F_B,F_M]=Modele_Dynamique_Integration_2D(ETAT,Concentrateur,PWM,Dyn_Robot,Moteur,dt)

Q_B_0 = ETAT(1:4);
dot_Q_B_0 = ETAT(5:8);
X = ETAT(9:11);% x y z
V_0 = ETAT(12:14);% phi theta psi
Q_Temp = quatmultiply(quatmultiply(quatconj(Q_B_0),[0 V_0]),Q_B_0);
V_B = Q_Temp(2:4);
[Q_Temp]=2*quatmultiply(quatinv(Q_B_0),dot_Q_B_0);
W_B = Q_Temp(2:4);

F_M =  Carract_Moteurs(Moteur,PWM);
F_B = Concentrateur*F_M;

dot_u = (1/Dyn_Robot.m_u)*(F_B(1) - Dyn_Robot.d_u*V_B(1));
dot_v = (1/Dyn_Robot.m_v)*(F_B(2) - Dyn_Robot.d_v*V_B(2));
%dot_w = (1/Dyn_Robot.m_w)*(F_B(3) - Dyn_Robot.d_w*V_B(3));
dot_w = 0;
%dot_p = (1/Dyn_Robot.m_p)*(F_B(4) - Dyn_Robot.d_p*W_B(1));
dot_p = 0;
%dot_q = (1/Dyn_Robot.m_q)*(F_B(5) - Dyn_Robot.d_q*W_B(2));
dot_q = 0;
dot_r = (1/Dyn_Robot.m_r)*(F_B(3) - Dyn_Robot.d_r*W_B(3));

dot_V_B = [dot_u dot_v dot_w];
dot_W_B = [dot_p dot_q dot_r];

Q_Temp = quatmultiply(quatmultiply(Q_B_0,[0 dot_V_B]),quatconj(Q_B_0));

dot_V_0 = Q_Temp(2:4);

ddot_Q_B_0 = 0.5*quatmultiply(dot_Q_B_0,[0,W_B]) + 0.5*quatmultiply(Q_B_0,[0,dot_W_B]);

%[t45,x45]=ode45(@(t,x) modele3(x,A,b),[0 dt],x);

%% Integration du mouvement lineaire
X=X+V_0*dt;
V_0=V_0+dot_V_0*dt;

%% Integration du mouvement rotationnel
dot_Q_B_0=dot_Q_B_0+ddot_Q_B_0*dt;
Q_B_0 = quatnormalize(Q_B_0+dot_Q_B_0*dt);
[Eta(3),Eta(2),Eta(1)] = quat2angle(Q_B_0);
ETAT_NEW = [Q_B_0,dot_Q_B_0,X,V_0];
