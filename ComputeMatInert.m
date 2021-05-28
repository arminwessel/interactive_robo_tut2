function A = ComputeMatInert(q)

d3=0.7;
r1=0.5;
r4=0.2;
rE=0.1;

angles_alpha=pi/2*[0;1;0;1;-1;1];
distances_d=[0;0;d3;0;0;0];
distances_r=[r1;0;0;r4;0;0];

m = zeros(6,1);
m(1) = 15;
m(2) = 10;
m(3) = 1;
m(4) = 7;
m(5) = 1;
m(6) = 0.5;

I = zeros(3,3,6);
I(:,:,1) = [0.8, 0, 0.05; 0, 0.8, 0; 0.05, 0, 0.1];
I(:,:,2) = [0.1, 0, 0.1; 0, 1.5, 0; 0.1, 0, 1.5];
I(:,:,3) = [0.05, 0, 0; 0, 0.01, 0; 0, 0, 0.05];
I(:,:,4) = [0.5, 0, 0; 0, 0.5, 0; 0, 0, 0.05];
I(:,:,5) = [0.01, 0, 0; 0, 0.01, 0; 0, 0, 0.01];
I(:,:,6) = [0.01, 0, 0; 0, 0.01, 0; 0, 0, 0.01];

coordinates_G = zeros(3,6);
coordinates_G(:,1) = [0;0;-0.25];
coordinates_G(:,2) = [0.35;0;0];
coordinates_G(:,3) = [0;-0.1;0];
coordinates_G(:,4) = [0;0;0];
coordinates_G(:,5) = [0;0;0];
coordinates_G(:,6) = [0;0;0];

Jm = 1e-5;

r_red = zeros(6,1);
r_red(1) = 100;
r_red(2) = 100;
r_red(3) = 100;
r_red(4) = 70;
r_red(5) = 70;
r_red(6) = 70;

g = [0;0;-9.81];

F_v = 10*ones(6,1);
tau_max = 5*ones(6,1);

A_i = zeros(6,6,6);
A_trans = zeros(6,6,6);
A_rot = zeros(6,6,6);
theta = q + [0;0;pi/2;0;0;0];
[JvGs, JwGs] = ComputeJacGi(angles_alpha, distances_d, theta, distances_r, coordinates_G(1,:), coordinates_G(2,:), coordinates_G(3,:));

% Express inertia around origin of joint coordinate frame
I_Oi = zeros(3,3,6);
for i = 1:6
        
    OOi_0 = get_p_0i(angles_alpha,distances_d,theta,distances_r,i); % vector from robot base to origin of frame i
    %G(:,i) % vector from origin of frame i to center of mass of segment i 
    r_0c = OOi_0+coordinates_G(:,i); %vector from robot base to mass center of joint i
    
    % skew symmetric matrices ffrom vectors r_0c and r_ic
    a_Oc = [0, -r_0c(3), r_0c(2); r_0c(3), 0, -r_0c(1); -r_0c(2), r_0c(1), 0]; 
    a_1c = [0, -coordinates_G(3,i), coordinates_G(2,i); coordinates_G(3,i), 0, -coordinates_G(1,i); -coordinates_G(2,i), coordinates_G(1,i), 0];
    
    % Generalized Huyghens theorem
    % transform inertia around Origin i to inertia around Origin 0
    I_Oi(:,:,i) = I(:,:,i) - m(i)*( (a_1c)'*a_1c );
end

for i=1:6
    % Translational inertia of body i
    JvGi = JvGs(:,:,i); % Get jacobian
    A_trans(:,:,i) = m(i) * (JvGi') * JvGi; %slide 169
    
    % Rotational inertia of body i
    JwGi = JwGs(:,:,i); % Get Jacobian
    R = get_R_0i(angles_alpha, distances_d, theta, distances_r, i); % Rotation matrix from robot base to origin of frame i
    I_i = R*I_Oi(:,:,i)*R'; % Rotate inertia into frame 0 (slide 349)
    A_rot(:,:,i) = ((JwGi') * I_i * JwGi);
end
% sum the inertia of all 6 bodies
A_rot_total = sum(A_rot,3);
A_trans_total = sum(A_trans,3);

A = A_rot_total + A_trans_total;

% Add the inertia of the joint drives
A = A + diag(Jm*r_red.^2);
end
