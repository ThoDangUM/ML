function Concentrateur = Calcul_Concentrateur_2D(Moteur)


%clear all
%close all
%load PARAM_Moteurs_ULYSSE.mat
%load PARAM_Moteurs_ICOSAEDRE.mat

%Matricialisation du concentrateur
for i = 1:length(Moteur)
    Concentrateur(1,i) = cos(Moteur(i).orientation(1));
    Concentrateur(2,i) = sin(Moteur(i).orientation(1));
    %Concentrateur(1,i) = cos(Moteur(i).orientation(2))*cos(Moteur(i).orientation(3));
    %Concentrateur(2,i) = cos(Moteur(i).orientation(2))*sin(Moteur(i).orientation(3));
    %Concentrateur(3,i) = -sin(Moteur(i).orientation(2))*cos(Moteur(i).orientation(3));
    %Concentrateur(4,i) = Concentrateur(3,i)*Moteur(i).position(2) - Concentrateur(2,i)*Moteur(i).position(3);
    %Concentrateur(5,i) = Concentrateur(1,i)*Moteur(i).position(3) - Concentrateur(3,i)*Moteur(i).position(1);
    %Concentrateur(6,i) = Concentrateur(2,i)*Moteur(i).position(1) - Concentrateur(1,i)*Moteur(i).position(2);
end

A = [];
for i = 1:length(Moteur)
B = cross([Moteur(i).position 0],[Concentrateur(1,i),Concentrateur(2,i) 0]);
A = [A,B'];
end

Concentrateur = [Concentrateur;A];
Concentrateur = [Concentrateur(1,:);Concentrateur(2,:); Concentrateur(5,:)];