
%figure(1)
figure;
grid on
Bouton_Marin= uicontrol('Style','checkbox','BackgroundColor','k','ForegroundColor','y',...
    'Position' ,[50 380 100 20],'fontsize',16,'string','MARIN');
zlabel('zzZzz');ylabel('yyYyy');xlabel('xxXxx')

for i = 1 : 12
    F_M(i)=0.21;
end

hold on
for i = 1 : length(Moteur)
    Sommets(i,:) = [Moteur(i).position(1),Moteur(i).position(2),Moteur(i).position(3)];
end
facess = convhulln(Sommets);
Forme = patch('vertices',Sommets,'faces',facess,'facecolor','none');

for i = 1:length(Moteur)
    %plot3(Moteur(i).position(1),Moteur(i).position(2),Moteur(i).position(3),'*')
    Q_M = angle2quat( Moteur(i).orientation(3),Moteur(i).orientation(2),Moteur(i).orientation(1) );
    Moteur(i).Q_M_B = Q_M;
    Q_Temp = quatmultiply(quatmultiply(Q_M,[0 1 0 0]),quatconj(Q_M));
    Dir_Thrust = Q_Temp(2:4)*1;
    Moteur(i).Dir_Thrust_B = Dir_Thrust/norm(Dir_Thrust);
    Thrust_GRAPH(i)=quiver3(Moteur(i).position(1),Moteur(i).position(2),Moteur(i).position(3),Dir_Thrust(1),Dir_Thrust(2),Dir_Thrust(3),'linewidth',2,'maxheadsize',0.1,'color',Moteur(i).Color);
    Num_Moteur(i)=text(Moteur(i).position(1),Moteur(i).position(2),Moteur(i).position(3),num2str(i),'color',Moteur(i).Color,'fontsize',20);
end

%quiver3(0,0,0,F_B(1),F_B(2),F_B(3),'linewidth',6,'maxheadsize',10);

%Repere 0
AxeX_0 = quiver3(0,0,0,1,0,0,'linewidth',1,'maxheadsize',0.1,'color','r');
AxeY_0 = quiver3(0,0,0,0,1,0,'linewidth',1,'maxheadsize',0.1,'color','g');
AxeZ_0 = quiver3(0,0,0,0,0,1,'linewidth',1,'maxheadsize',0.1,'color','b');

%Repere Robot
Q_Temp = quatmultiply(quatmultiply(Q_B_0,[0 1 0 0]),quatconj(Q_B_0));
AxeX_B = quiver3(X(1),X(2),X(3),Q_Temp(2),Q_Temp(3),Q_Temp(4),'linewidth',2,'maxheadsize',0.1,'color','r');
Q_Temp = quatmultiply(quatmultiply(Q_B_0,[0 0 1 0]),quatconj(Q_B_0));
AxeY_B = quiver3(X(1),X(2),X(3),Q_Temp(2),Q_Temp(3),Q_Temp(4),'linewidth',2,'maxheadsize',0.1,'color','g');
Q_Temp = quatmultiply(quatmultiply(Q_B_0,[0 0 0 1]),quatconj(Q_B_0));
AxeZ_B = quiver3(X(1),X(2),X(3),Q_Temp(2),Q_Temp(3),Q_Temp(4),'linewidth',2,'maxheadsize',0.1,'color','b');

axis equal