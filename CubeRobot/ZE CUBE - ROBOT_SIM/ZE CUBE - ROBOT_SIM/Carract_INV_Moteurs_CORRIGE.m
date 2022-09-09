function PWM =  Carract_INV_Moteurs_CORRIGE(Moteur,F_M, Pente_CORR)


for iii=1:length(Moteur)
    if F_M(iii)>=0,
        PWM(iii) = (F_M(iii)/Pente_CORR(iii))+Moteur(iii).DZ_pos;
        if PWM(iii)<=0, PWM(iii)=0;end
        if PWM(iii)>100, PWM(iii)=100;end
    end
    if F_M(iii)<0,
       PWM(iii) = 0;%-(F_M(iii)/(Moteur(iii).Max_neg/(Moteur(iii).DZ_neg+100)))+Moteur(iii).DZ_neg;
       if PWM(iii)>0, PWM(iii)=0;end
       if PWM(iii)<-100, PWM(iii)=+100;end
    end
    
end