function A = ComputeMatInert(q)
global I;
global G;
param;
A_i = zeros(6,6,6);
theta = q + [0;0;pi/2;0;0;0];
[JvGs, JwGs] = ComputeJacGi(angles_alpha, distances_d, theta, distances_r, G(1,:), G(2,:), G(3,:));

% Express inertia around origin of joint coordinate frame
I_Oi = zeros(3,3,6);
for i = 1:6
        
    OOi_0 = get_p_0i(angles_alpha,distances_d,theta,distances_r,i); % vector from robot base to origin of frame i
    %G(:,i) % vector from origin of frame i to center of mass of segment i 
    r_0c = OOi_0+G(:,i); %vector from robot base to mass center of joint i
    
    % skew symmetric matrices ffrom vectors r_0c and r_ic
    a_Oc = [0, -r_0c(3), r_0c(2); r_0c(3), 0, -r_0c(1); -r_0c(2), r_0c(1), 0]; 
    a_1c = [0, -G(3,i), G(2,i); G(3,i), 0, -G(1,i); -G(2,i), G(1,i), 0];
    
    % Generalized Huyghens theorem
    % transform inertia around Origin i to inertia around Origin 0
    I_Oi(:,:,i) = I(:,:,i) +  m(i)*( (a_Oc')*a_Oc ) - m(i)*( (a_1c)'*a_1c );
end

for i=1:6
    % Translational inertia of body i
    JvGi = JvGs(:,:,i); % Get jacobian
    A_trans = m(i) * (JvGi') * JvGi; %slide 169
    
    % Rotational inertia of body i
    JwGi = JwGs(:,:,i); % Get Jacobian
    R = get_R_0i(angles_alpha, distances_d, theta, distances_r, i); % Rotation matrix from robot base to origin of frame i
    I_i = R*I_Oi(:,:,i)*R'; % Rotate inertia into frame 0 (slide 349)
    A_rot = ((JwGi') * I_i * JwGi);
    
    % Add translational and rotatioanal inertia for each body
    A_i(:,:,i) = A_trans + A_rot;
end
% sum the inertia of all 6 bodies
A = sum(A_i,3);

% Add the inertia of the joint drives
A = A + diag(Jm*r_red.^2);
end
