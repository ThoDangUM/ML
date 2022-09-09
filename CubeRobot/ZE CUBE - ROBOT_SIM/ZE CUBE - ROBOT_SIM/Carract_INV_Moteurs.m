function PWM =  Carract_INV_Moteurs(Moteur,F_M)


for iii=1:length(Moteur)
    if F_M(iii)>=0,
        PWM(iii) = (F_M(iii)/(Moteur(iii).Max_pos/(100-Moteur(iii).DZ_pos)))+Moteur(iii).DZ_pos;
        if PWM(iii)<=0, PWM(iii)=0;end
        if PWM(iii)>100, PWM(iii)=100;end
    end
    if F_M(iii)<0,
       PWM(iii) = -(F_M(iii)/(Moteur(iii).Max_neg/(Moteur(iii).DZ_neg+100)))+Moteur(iii).DZ_neg;
       if PWM(iii)>0, PWM(iii)=0;end
       if PWM(iii)<-100, PWM(iii)=-100;end
    end
    
end