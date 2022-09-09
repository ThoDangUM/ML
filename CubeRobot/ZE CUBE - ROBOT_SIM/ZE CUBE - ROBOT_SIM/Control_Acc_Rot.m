function [dot_W_B_CONTROL]=Control_Acc_Rot(Q_B_0,W_B,Q_D,dot_Q_D,ddot_Q_D) 



%% Control
    Q_e = quatmultiply(quatconj(Q_B_0),Q_D); % Q->Q_B_0
    Q_e_hat = [0 Q_e(2) Q_e(3) Q_e(4)];
    %Kinematic
    W_D = 2*quatmultiply(quatconj(Q_D),dot_Q_D);
    K1 = 1;
    REF = quatmultiply( Q_e , quatmultiply( W_D , quatconj(Q_e) ));
    W_C = REF + K1*Q_e_hat;

    dot_W_D = quatmultiply(quatconj(Q_D),(ddot_Q_D - .5*(quatmultiply(dot_Q_D,W_D))));
    
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
    
    K1 = 1;
    K2 = 1;
    K3 = 1;
    KI=0;
    dot_W = quatmultiply( dot_Q_e , quatmultiply( W_D , quatconj(Q_e) ))...
        + quatmultiply( Q_e , quatmultiply( dot_W_D , quatconj(Q_e) ))...
        + quatmultiply( Q_e , quatmultiply( W_D , quatconj(dot_Q_e) ))...
        + K1*(REF - [0 W_B])... %W -> [0 W_B]
        + K2*Q_e_hat...
        + K3*dot_Q_e_hat;
        %+ KI*INT_Q;
    

    
    dot_W_B_CONTROL = dot_W(2:4)';