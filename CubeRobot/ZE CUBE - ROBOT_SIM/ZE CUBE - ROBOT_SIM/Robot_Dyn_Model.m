function [F_B_DES]=Robot_Dyn_Model(W_B,dot_w_CONTROL,V_B,dot_V_B_Control,Dyn_Robot)


dot_u = dot_V_B_Control(1);
dot_v = dot_V_B_Control(2);
dot_w = dot_V_B_Control(3);
dot_p = dot_w_CONTROL(1);
dot_q = dot_w_CONTROL(2);
dot_r = dot_w_CONTROL(3);


F_B(1) = Dyn_Robot.m_u*dot_u + Dyn_Robot.d_u*V_B(1);
F_B(2) = Dyn_Robot.m_v*dot_v + Dyn_Robot.d_v*V_B(2);
F_B(3) = Dyn_Robot.m_w*dot_w + Dyn_Robot.d_w*V_B(3);
F_B(4) = Dyn_Robot.m_p*dot_p + Dyn_Robot.d_p*W_B(1);
F_B(5) = Dyn_Robot.m_q*dot_q + Dyn_Robot.d_q*W_B(2);
F_B(6) = Dyn_Robot.m_r*dot_r + Dyn_Robot.d_r*W_B(3);


F_B_DES = F_B';
