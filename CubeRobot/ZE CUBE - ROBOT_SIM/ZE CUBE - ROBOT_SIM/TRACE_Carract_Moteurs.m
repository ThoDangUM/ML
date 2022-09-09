%TRACE DES CARRACGERISTIQUES DES MOTEURS
clear all
close all
clc

%load PARAM_Moteurs_ULYSSE.mat
load PARAM_Moteurs_CUBE.mat
load Coeff_CORR_CUBE.mat

for i = 1 : 200
    PWM(1:length(Moteur),i) = i-100;
    F_M(:,i) =  Carract_Moteurs(Moteur,PWM(:,i));
end


for i = 1 : 200
    PWM(1:length(Moteur),i) = i-100;
    F_M_EST(:,i) =  Carract_Moteurs(Moteur_EST,PWM(:,i));
end

for i = 1 : 200
    PWM(1:length(Moteur),i) = i-100;
%Carract_Moteurs_CORRIGE(Moteur,PWM(:,i),Coeff_CORR/0.0165)
    F_M_CORR(:,i) =  Carract_Moteurs_CORRIGE(Moteur,PWM(:,i),Coeff_CORR/0.0165);
end

figure()

for i = 1:length(Moteur)
    col = [rand rand rand];
    plot(PWM(i,:),F_M(i,:),'color',col);
    hold on
    %x=min(PWM(i,:))+i*(max(PWM(i,:))-min(PWM(i,:)))/length(Moteur);
    x=PWM(i,i*floor(length(PWM)/12))
    %xx=length(F_M(i,:))/12;
    y=F_M(i,i*floor(length(PWM)/12));
    text(x,y,['Prop.' num2str(i)],'color',col)
    plot(PWM(i,:),F_M_CORR(i,:),'color',col,'linestyle','--','linewidth',3);
end
plot(PWM(1,:),F_M_EST(1,:),'color','k','linewidth',2,'linestyle','--');

title('Real (and unknown) actuators characteristic')
xlabel('c_m (PWM)')
ylabel('F_M (N)')




