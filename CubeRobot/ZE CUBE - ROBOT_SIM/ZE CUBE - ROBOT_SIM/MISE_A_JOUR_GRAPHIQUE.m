LL=size(Sommets); LL=LL(1);
Q_Temps = quatmultiply(quatmultiply(Q_B_0,[zeros(LL,1),Sommets]),quatconj(Q_B_0));
Sommets_new = Q_Temps(:,2:4);

OffSet_lineaire = [X(1)*ones(1,size(Sommets_new)*[1 0]')',X(2)*ones(1,size(Sommets_new)*[1 0]')',X(3)*ones(1,size(Sommets_new)*[1 0]')'];
Sommets_new = Sommets_new + OffSet_lineaire;
set(Forme,'vertices',Sommets_new);
for i = 1:length(Moteur)
    Q_Temp = quatmultiply(quatmultiply(Q_B_0,[0 Moteur(i).Dir_Thrust_B]),quatconj(Q_B_0));
    New_Dir_Thrust = Q_Temp(2:4)*PWM(i)/100;
    set(Thrust_GRAPH(i),'xdata',Sommets_new(i,1),'ydata',Sommets_new(i,2),'zdata',Sommets_new(i,3),'udata',New_Dir_Thrust(1),'vdata',New_Dir_Thrust(2),'wdata',New_Dir_Thrust(3));
    set(Num_Moteur(i),'position',[Sommets_new(i,1),Sommets_new(i,2),Sommets_new(i,3)]);
end


%Repere Robot
Q_Temp = quatmultiply(quatmultiply(Q_B_0,[0 1 0 0]),quatconj(Q_B_0));
set(AxeX_B,'xdata',X(1),'ydata',X(2),'zdata',X(3),'udata',Q_Temp(2),'vdata',Q_Temp(3),'wdata',Q_Temp(4));
Q_Temp = quatmultiply(quatmultiply(Q_B_0,[0 0 1 0]),quatconj(Q_B_0));
set(AxeY_B,'xdata',X(1),'ydata',X(2),'zdata',X(3),'udata',Q_Temp(2),'vdata',Q_Temp(3),'wdata',Q_Temp(4));
Q_Temp = quatmultiply(quatmultiply(Q_B_0,[0 0 0 1]),quatconj(Q_B_0));
set(AxeZ_B,'xdata',X(1),'ydata',X(2),'zdata',X(3),'udata',Q_Temp(2),'vdata',Q_Temp(3),'wdata',Q_Temp(4));



axis([X(1)-1 X(1)+1 X(2)-1 X(2)+1 X(3)-1 X(3)+1])
%axis equal
%axis square
%view(90,0)
if get(Bouton_Marin,'value'),
    set(gca,'zdir','reverse')
    set(gca,'ydir','reverse')
else
    set(gca,'zdir','normal')
    set(gca,'ydir','normal')
end
drawnow


