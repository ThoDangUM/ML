function [F_M_CONTROL,dot_w_CONTROL,dot_V_B_Control]=Control_Robot(Q_B_0,W_B,X,V_B,Q_D,dot_Q_D,W_D,dot_W_D,X_D,dot_V_B_DES,V_B_DES,INT_ERREUR_V_B,Concentrateur,dt,Dyn_Robot) 



%% Control
    Q_e = quatmultiply(quatconj(Q_B_0),Q_D); % Q->Q_B_0
    Q_e_hat = [0 Q_e(2) Q_e(3) Q_e(4)];
    %Kinematic
    K1 = 1;
    REF = quatmultiply( Q_e , quatmultiply( W_D , quatconj(Q_e) ));
    W_C = REF + K1*Q_e_hat;

    dot_Q = .5*quatmultiply(Q_B_0,[0 W_B]);%Q->Q_B_0 et W -> [0 W_B]
    dot_Q_e = quatmultiply( quatconj(dot_Q) , Q_D ) + quatmultiply( quatconj(Q_B_0) , dot_Q_D ); %Q->Q_B_0
    dot_Q_e_hat = [0 dot_Q_e(2) dot_Q_e(3) dot_Q_e(4)];
    
%     [PSI,THETA,PHI]=quat2angle(Q_B_0);
%     DPHI = Phi_D - PHI;
%     DTHETA = Theta_D - THETA;
%     DPSI = Psi_D - PSI;

%     INT_DPHI = INT_DPHI + DPHI*dt;
%     INT_DTHETA = INT_DTHETA + DTHETA*dt;
%     INT_DPSI = INT_DPSI + DPSI*dt;
%     
%     Qe_INT = quatmultiply(Qe_INT,Q_e_hat);
%     
%     INT_Q = quatnormalize (INT_Q + Q_e_hat*dt);
    
    K1 = 10;
    K2 = 10;
    K3 = 10;
    KI=0;
    dot_W = quatmultiply( dot_Q_e , quatmultiply( W_D , quatconj(Q_e) ))...
        + quatmultiply( Q_e , quatmultiply( dot_W_D , quatconj(Q_e) ))...
        + quatmultiply( Q_e , quatmultiply( W_D , quatconj(dot_Q_e) ))...
        + K1*(REF - [0 W_B])... %W -> [0 W_B]
        + K2*Q_e_hat...
        + K3*dot_Q_e_hat;
        %+ KI*INT_Q;
    

    
    dot_w_CONTROL = dot_W(2:4)';

    X_err_0 = X_D-X';
    Q_Temp = quatmultiply(quatmultiply(quatconj(Q_B_0),[0 X_err_0']),Q_B_0);
    X_err_B = Q_Temp(2:4)';
    V_B_DES = tanh(X_err_B);
    
   % INT_ERREUR_V_B =  INT_ERREUR_V_B +  (V_B_DES-V_B')*dt;
    dot_V_B_Control = dot_V_B_DES + 1*(V_B_DES-V_B') + 1*X_err_B;
        
    dot_u = dot_V_B_Control(1);u=V_B(1);
    dot_v = dot_V_B_Control(2);v=V_B(2);
    dot_w = dot_V_B_Control(3);w=V_B(3);
    dot_p = dot_w_CONTROL(1);p=W_B(1);
    dot_q = dot_w_CONTROL(2);q=W_B(2);
    dot_r = dot_w_CONTROL(3);r=W_B(3);

   
    F_B(1) = Dyn_Robot.m_u*dot_u + Dyn_Robot.d_u*V_B(1);
    F_B(2) = Dyn_Robot.m_v*dot_v + Dyn_Robot.d_v*V_B(2);
    F_B(3) = Dyn_Robot.m_w*dot_w + Dyn_Robot.d_w*V_B(3);
    F_B(4) = Dyn_Robot.m_p*dot_p + Dyn_Robot.d_p*W_B(1);
    F_B(5) = Dyn_Robot.m_q*dot_q + Dyn_Robot.d_q*W_B(2);
    F_B(6) = Dyn_Robot.m_r*dot_r + Dyn_Robot.d_r*W_B(3);
    


    F_M_CONTROL = pinv(Concentrateur)*F_B';
    

