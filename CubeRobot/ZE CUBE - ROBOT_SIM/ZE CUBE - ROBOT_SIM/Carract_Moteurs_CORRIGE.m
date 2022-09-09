function F_M_CORR =  Carract_Moteurs_CORRIGE(Moteur,PWM,Coeff_CORR)

% -100<PWM<100


for iii=1:length(Moteur)
    if PWM(iii)>100,PWM(iii)=100;end
    if PWM(iii)<-100,PWM(iii)=-100;end
    F_M_CORR(iii)=0;
    if PWM(iii)>=Moteur(iii).DZ_pos,
        %F_M(iii) = (Moteur(iii).Max_pos/(100-Moteur(iii).DZ_pos))*(PWM(iii)-Moteur(iii).DZ_pos);
        F_M_CORR(iii) = Coeff_CORR(iii)*(PWM(iii)-Moteur(iii).DZ_pos);
    end
    if PWM(iii)<Moteur(iii).DZ_neg,
       %F_M(iii) = (Moteur(iii).Max_neg/(Moteur(iii).DZ_neg+100))*(Moteur(iii).DZ_neg-PWM(iii));
       F_M_CORR(iii) = 0*(PWM(iii)-Moteur(iii).DZ_pos);
    end
end

    

