function [dot_V_B_CONTROL]=Control_Acc_Lin(Q_B_0,X,V_B,X_D,dot_V_B_DES)

X_err_0 = X_D-X';
Q_Temp = quatmultiply(quatmultiply(quatconj(Q_B_0),[0 X_err_0']),Q_B_0);
X_err_B = Q_Temp(2:4)';
V_B_DES = tanh(X_err_B);

% INT_ERREUR_V_B =  INT_ERREUR_V_B +  (V_B_DES-V_B')*dt;
dot_V_B_CONTROL = dot_V_B_DES + 0.1*(V_B_DES-V_B') + 0.1*X_err_B;
