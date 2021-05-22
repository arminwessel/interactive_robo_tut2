function J = ComputeJac(alpha,d,theta,r)
J=zeros(6,0);
Zi=[0;0;1];
for i = 1:6
    R_0i = get_R_0i(alpha,d,theta,r,i);
    
    p_0i = get_p_0i(alpha,d,theta,r,i);
    g_0E = ComputeDGM(alpha,d,theta,r);
    p_0E = g_0E(1:3,4);
    p_iE = p_0E - p_0i;
    
%     temp = [R_0i*cross(Zi,p_iE);R_0i*Zi];
    temp = [cross(R_0i*Zi,p_iE);R_0i*Zi];
    
    J=[J temp];
end
%disp('end')


end

