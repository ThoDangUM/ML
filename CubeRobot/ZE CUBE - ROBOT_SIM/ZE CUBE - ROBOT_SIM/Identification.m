close all
%clear all


%identification
load PARAM_Moteurs_CUBE.mat
load Cm_inf_CUBE

%VErif de colinearité entre Cm_inf_1 et Cm_inf_2
a=Cm_inf_2/norm(Cm_inf_2);b=Cm_inf_1/norm(Cm_inf_1);
dot(a,b)


Concentrateur = Calcul_Concentrateur(Moteur);
KER_A = null(Concentrateur);
P1 = KER_A(:,1);
P2 = KER_A(:,2);



for i = 1: length(Moteur)
pente_Moteur(i) =(Moteur(i).Max_pos/(100-Moteur(i).DZ_pos));
beta(i) = (Moteur(i).Max_pos/(100-Moteur(i).DZ_pos))*(-Moteur(i).DZ_pos);
end

beta=beta';
pente_Moteur = pente_Moteur';


D1 = diag(Cm_inf_1-[Moteur.DZ_pos]);
D2 = eye(8,4)
D3 = zeros(8,2);

D4 = diag(Cm_inf_2-[Moteur.DZ_pos]);

Midd = [D1,-P1,-P2,D3;...
        D4,D3,-P1,-P2];
    

M2 = Midd(1:11,:);
K_M2 = null(M2);

disp('comparaison des pentes')
[pente_Moteur.\K_M2(1:8)]

Coeff_CORR = K_M2(1:8);
save Coeff_CORR_CUBE Coeff_CORR

