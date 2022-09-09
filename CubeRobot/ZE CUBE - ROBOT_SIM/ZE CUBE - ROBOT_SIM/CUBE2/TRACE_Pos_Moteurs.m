
for i = 1 : 12
    F_M(i)=0.21;
end
figure()
hold on
for i = 1 : length(Moteur)
    Sommets(i,:) = [Moteur(i).position(1),Moteur(i).position(2),Moteur(i).position(3)];
end
facess = convhull(Sommets(:,1),Sommets(:,2),Sommets(:,3));
Forme = patch('vertices',Sommets,'faces',facess,'facecolor','none');



for i = 1:length(Moteur)
    plot3(Moteur(i).position(1),Moteur(i).position(2),Moteur(i).position(3),'*')
    Q_M = angle2quat( Moteur(i).orientation(3),Moteur(i).orientation(2),Moteur(i).orientation(1) );
    Q_Temp = quatmultiply(quatmultiply(Q_M,[0 1 0 0]),quatconj(Q_M));
    Dir_Thrust = Q_Temp(2:4)*F_M(i);
    quiver3(Moteur(i).position(1),Moteur(i).position(2),Moteur(i).position(3),Dir_Thrust(1),Dir_Thrust(2),Dir_Thrust(3),'linewidth',4,'maxheadsize',4,'color',Moteur(i).Color);
    text(Moteur(i).position(1),Moteur(i).position(2),Moteur(i).position(3),[num2str(i)],'color',Moteur(i).Color,'fontsize',18);
end


quiver3(0,0,0,.25,0,0,'linewidth',6,'maxheadsize',10,'color','r');
quiver3(0,0,0,0,.25,0,'linewidth',6,'maxheadsize',10,'color','g');
quiver3(0,0,0,0,0,.25,'linewidth',6,'maxheadsize',10,'color','b');


%quiver3(0,0,0,F_B(1),F_B(2),F_B(3),'linewidth',6,'maxheadsize',10);

axis equal