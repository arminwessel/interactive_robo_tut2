function [Jvgi , Jwi] = ComputeJacGi(alpha, d , theta, r, xg, yg, zg)
    Jvgi = zeros(3,6,6);
    Jwi = zeros(3,6,6);
    J = ComputeJac(alpha,d,theta,r); % J^0_{O_i}
    for i = 1:6
        OiGi_i = [xg(i);yg(i);zg(i)]; %vector from origin of frame i to center os mass of joint i in Frame i
        R_0i = get_R_0i(alpha,d,theta,r,i); % Rotation from Frame i to Frame 0
        OiGi_0 = R_0i*OiGi_i; % vector from origin of frame i to center os mass of joint i in Frame 0

        OOi_0 = get_p_0i(alpha,d,theta,r,i); % vector from robot base to origin of frame i

        OGi_0 = OOi_0 + OiGi_0; % vector from robot base to center of mass of joint i

        DGM = ComputeDGM(alpha,d,theta,r); % full transformation g from robot base to endeffector
        OOE_0 = DGM(1:3,4); % translation from robot base to endeffector

        OEGi = -OOE_0 + OGi_0; % vector from endeffector to center of mass of joint i
        skew_OEGi = [0 -OEGi(3) OEGi(2) ; OEGi(3) 0 -OEGi(1) ; -OEGi(2) OEGi(1) 0 ];
        
        M_varignon = [eye(3), -skew_OEGi; zeros(3,3), eye(3)];
        J_trans_i = M_varignon * J;
        Jvgi(:,:,i) = J_trans_i(1:3,:);
        Jwi(:,:,i) = J_trans_i(4:6,:);
    end
    
    

end