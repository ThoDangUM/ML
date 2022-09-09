function [Fm,Cqqdot]=GLOB(etat,Mat_moteurs2body,Cm,Parametres,ParametresMot)
Rcond1=NaN;
Rcond2=NaN;
vitesses_Quat_Vol=etat(8:11);  
vitesses_G=etat(12:14);
Quat=etat(1:4);   
m=Parametres(11);
g=Parametres(12);
Coeff_frottement=Parametres(13);
%vitesse_robot=quatmultiply(quatmultiply(q(4:7)',[0 qdot(1:3)']),quatconj(q(4:7)'));  % dans le repere robot
%omega= 2*quatmultiply(q(1:4)',quatconj(qdot(1:4)')); 
V=[Quat(1)  Quat(2) Quat(3) Quat(4);Quat(2) -Quat(1) Quat(4) -Quat(3);Quat(3) -Quat(4) -Quat(1) Quat(2);Quat(4) Quat(3) -Quat(2) -Quat(1)];    

% Forces_repere_absolu=quatmultiply(quatmultiply(quatconj(q(4:7)'),Forces_repere_robot-Coeff_frottement*vitesse_robot),q(4:7)') ;
% Forces_repere_absolu(4)=Forces_repere_absolu(4)-0*m*g;
%  Couples_Quaternions=2*V'*CouplesFAUX;
%  Couples_resultants=Couples-Coeff_frottement*qdot(5:7);

% Gamma_total=Mat_moteurs2body*MatAction*Cm;
% Z_Commande=1*[0 ;Gamma_total]; % 0 et 3 couples moteurs
     
     
     



% FBODY=Mat_moteurs2body*MatAction*Cm;
% FBODY=[0 FBODY']*0;
% ForcesG=quatmultiply(quatconj(Quat'),quatmultiply(FBODY,Quat'));


%Force_Rappel=Parametres(14)*(0-etat(7))-10*etat(14);
% FG=Mat_moteurs2body*MatAction*Cm;
% ForcesG=FG(1:3)+[0;0;Parametres(14)*(0-etat(7))-Parametres(15)*etat(14)];


Fm=(ParametresMot.aPlus*Cm+ParametresMot.bPlus).*(Cm>=(ParametresMot.mid+ParametresMot.Seuils))+...
    (ParametresMot.aMoins*Cm+ParametresMot.bMoins).*(Cm<=(ParametresMot.mid-ParametresMot.Seuils));

FG=Mat_moteurs2body*Fm;
ForcesG_Body=FG(1:3)+[0;0;Parametres(14)*(0-etat(7))-Parametres(15)*etat(14)];

ForcesG=quatmultiply(quatconj(Quat'),quatmultiply([0 ForcesG_Body'],Quat'));
ForcesG=ForcesG(2:4)';


Gamma_total=FG(4:6);
Z_Commande=1*[0 ;Gamma_total]; % 0 et 3 couples moteurs
Couples_Quaternions=2*V'*Z_Commande(1:4)-Coeff_frottement*vitesses_Quat_Vol(1:4);



Forces_Generalisees=[Couples_Quaternions;ForcesG]; 
%Forces_Generalisees=[Couples_Quaternions;ForcesG(2:4)']; 
%_______________________________________________________________________ 
% Calcul Z(q) et de la matrice non contrainte et Cqqdot
%_______________________________________________________________________ 
%[Z,dZ_dt,Cqqdot]=CalculZ([etat(1:7);vitesses_Quat_Vol],Parametres);
[Z,dZ_dt,Cqqdot]=CalculZ(etat,Parametres);
Q0=Quat(1);
Q1=Quat(2);
Q2=Quat(3);
Q3=Quat(4);
dU_dz=m*g;
%dU_dQuat=-[0    0    0    0 0 0 0 0 0 -dU_dz]';
dU_dQuat=-[0    0    0    0  0 0 -dU_dz]';

Z=[Z zeros(4,3);zeros(3,4) 1/2*m*eye(3)];
Cqqdot=[Cqqdot;0;0;0]+dU_dQuat;
Mq=Z+Z';

% 
% %dU_dq=[0 0 0 0 0 0 0 0 0 m*g]';
% Z=[Z zeros(7,3);zeros(3,7) 1/2*m*eye(3)];
% Cqqdot=[Cqqdot;0;0;0]+dU_dQuat; 
% Mq=Z+Z';   
%_______________________________________________________________________ 
% Introduction de la contrainte de normalisation du quaternion alpha 
%_______________________________________________________________________
A=[etat(1:4)'  0 0 0]; 
B=-etat(8:11)'*etat(8:11); 
Mq_contraint=[Mq -A';A zeros(1)]; 

% A=[etat(1:4)' 0 0 0 0 0 0];  
% B=-etat(11:14)'*etat(11:14); 
% Mq_contraint=[Mq -A';A zeros(1)]; 
%_______________________________________________________________________
% Inversion
%_______________________________________________________________________
Q=Forces_Generalisees;

     Verif=0;
 %   qdotdot_lambda_in=Mq_contraint\([Q-Cqqdot;0]+[zeros(10,1);B]);
    qdotdot_lambda_in=Mq_contraint\([Q-Cqqdot;0]+[zeros(7,1);B]);
    lambda=qdotdot_lambda_in(8:end);
%qdotdot_lambda=[etat(11:20);qdotdot_lambda_in(1:10);lambda];
qdotdot_lambda=[etat(8:14);qdotdot_lambda_in(1:7);lambda];

