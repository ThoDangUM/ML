figure(10)
clf
couleurfond=[0.2 0.3 .2]+0;
set(10,'color',couleurfond)
set(10,'NextPlot','replace')
set(gca,'color',couleurfond,'xcolor',1-couleurfond,'ycolor',1-couleurfond,'zcolor',1-couleurfond)
axis equal
axis([-0.5 1.5 -0.5 1.5 -0.5 1.5])
view(25,16)
xlabel('X');ylabel('Y');zlabel('Z')
hold on

%%%_____________________________________________________________________________________________________________________
% Base canonique
v_S_X=[0 1 0 0];
v_S_Y=[0 0 1 0];
v_S_Z=[0 0 0 1];
VD=[0 1 1 1]/sqrt(3);
%%%_____________________________________________________________________________________________________________________
line([0 1],[0  0],[0 0],'color','r','linewidth',3);
line([0 0],[0  1],[0 0],'color','g','linewidth',3);
line([0 0],[0  0],[0 1],'color','b','linewidth',3);
ptrTraj=plot3(0,0,0,'w');

a1=atan2(1/sqrt(2),1);n1=[1 0 0];n1=n1/norm(n1);
qC1=[cos(a1/2) sin(a1/2)*n1(1) sin(a1/2)*n1(2) sin(a1/2)*n1(3) ];
a2=-pi/4;n2=[0 1 0];n2=n2/norm(n2);
qC2=[cos(a2/2) sin(a2/2)*n2(1) sin(a2/2)*n2(2) sin(a2/2)*n2(3) ];
q1=quatmultiply(qC1,qC2);

q1=[1 0 0 0];

    ptrMarin= uicontrol('Style','checkbox','BackgroundColor','k','ForegroundColor','y',...
        'Position' ,[150 10 100 20],'fontsize',16,'string','MARIN');
    ptrSLIDE= uicontrol('Style','slider','BackgroundColor','k',...
        'Position' ,[150 50 170 20],'value',0,'fontsize',16,'min',0,'max',1);

X1=quatmultiply(quatmultiply(q1,v_S_X),quatconj(q1));
Y1=quatmultiply(quatmultiply(q1,v_S_Y),quatconj(q1));
Z1=quatmultiply(quatmultiply(q1,v_S_Z),quatconj(q1));
dec=[.5 .5 .5];
ptrX1=line([dec(1) dec(1)+X1(2)],[dec(2)  dec(2)+X1(3)],[dec(3)  dec(3)+X1(4)],'color','r','linewidth',3,'linestyle',':');
ptrY1=line([dec(1) dec(1)+Y1(2)],[dec(2)  dec(2)+Y1(3)],[dec(3)  dec(3)+Y1(4)],'color','g','linewidth',3,'linestyle',':');
ptrZ1=line([dec(1) dec(1)+Z1(2)],[dec(2)  dec(2)+Z1(3)],[dec(3)  dec(3)+Z1(4)],'color','b','linewidth',3,'linestyle',':');

alpha=0;
s=[1 1 1];s=s/norm(s);
Q2=[cos(alpha/2) s(1)*sin(alpha/2) s(2)*sin(alpha/2) s(3)*sin(alpha/2)];
qT=quatmultiply(q1,Q2);

%qT=[1 0 0 0];



Xm=quatmultiply(quatmultiply(qT,v_S_X),quatconj(qT));
Ym=quatmultiply(quatmultiply(qT,v_S_Y),quatconj(qT));
Zm=quatmultiply(quatmultiply(qT,v_S_Z),quatconj(qT));
Dm=quatmultiply(quatmultiply(qT,VD),quatconj(qT));

ptrXm=line([dec(1) dec(1)+Xm(2)],[dec(2)  dec(2)+Xm(3)],[dec(3)  dec(3)+Xm(4)],'color','r','linewidth',3);
ptrYm=line([dec(1) dec(1)+Ym(2)],[dec(2)  dec(2)+Ym(3)],[dec(3)  dec(3)+Ym(4)],'color','g','linewidth',3);
ptrZm=line([dec(1) dec(1)+Zm(2)],[dec(2)  dec(2)+Zm(3)],[dec(3)  dec(3)+Zm(4)],'color','b','linewidth',3);
ptrDm=line([dec(1) dec(1)+Dm(2)],[dec(2)  dec(2)+Dm(3)],[dec(3)  dec(3)+Dm(4)],'color','y','linewidth',3);
 Traj=[];
 qT=[1 0 0 0];
for t=0:0.009:3,
    
    if get(ptrMarin,'value'),
        set(gca,'zdir','reverse')
        set(gca,'ydir','reverse')
    else
        set(gca,'zdir','normal')
        set(gca,'ydir','normal')
    end
    set(gca,'color',[1 1-get(ptrSLIDE,'value') get(ptrSLIDE,'value')])
    alpha=0.1;
    Q2=[cos(alpha/2) s(1)*sin(alpha/2) s(2)*sin(alpha/2) s(3)*sin(alpha/2)];
    Q2=[cos(alpha/2) 0 0 sin(alpha/2)];
    qT=quatmultiply(qT,Q2);
%         alpha=3*t;
%     Q2=[cos(alpha/2) s(1)*sin(alpha/2) s(2)*sin(alpha/2) s(3)*sin(alpha/2)];
%qT=quatmultiply(q1,Q2);
    Xm=quatmultiply(quatmultiply(qT,v_S_X),quatconj(qT));
    Ym=quatmultiply(quatmultiply(qT,v_S_Y),quatconj(qT));
    Zm=quatmultiply(quatmultiply(qT,v_S_Z),quatconj(qT));
    Dm=quatmultiply(quatmultiply(qT,VD),quatconj(qT));
    Traj=[Traj;[dec(1)+Xm(2) dec(2)+Xm(3) dec(3)+Xm(4)]];
    set(ptrTraj,'xdata',Traj(:,1),'ydata',Traj(:,2),'zdata',Traj(:,3))
    
    set(ptrXm,'xdata',[dec(1) dec(1)+Xm(2)],'ydata',[dec(2)  dec(2)+Xm(3)],'zdata',[dec(3)  dec(3)+Xm(4)])
    set(ptrYm,'xdata',[dec(1) dec(1)+Ym(2)],'ydata',[dec(2)  dec(2)+Ym(3)],'zdata',[dec(3)  dec(3)+Ym(4)])
    set(ptrZm,'xdata',[dec(1) dec(1)+Zm(2)],'ydata',[dec(2)  dec(2)+Zm(3)],'zdata',[dec(3)  dec(3)+Zm(4)])
    set(ptrDm,'xdata',[dec(1) dec(1)+Dm(2)],'ydata',[dec(2)  dec(2)+Dm(3)],'zdata',[dec(3)  dec(3)+Dm(4)])
    drawnow
end


