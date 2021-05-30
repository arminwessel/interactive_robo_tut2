%% Dynamic Model
%load params to workspace
param;
clc;

% set q vector
qi=-pi/2*[1,0,1,1,1,1]';
thetai=qi+[0;0;pi/2;0;0;0];


%% Q12
disp('Question 12');
[JvGs, JwGs] = ComputeJacGi(angles_alpha, distances_d, thetai, distances_r, coordinates_G(1,:), coordinates_G(2,:), coordinates_G(3,:));
JvGs(:,:,6)
JwGs(:,:,6)

%% Q13
disp('Question 13');
A = ComputeMatInert(qi)


%% Q14 
% We don't know if the vertical or the horizontal configurations will have
% higher eigenvalues so we try both
% The lowest should be moving only the end effector

% Vertical
q_ver = pi*[0;0.5;0;0;0;0];
A_ver = ComputeMatInert(q_ver);
[U_ver,S_ver,V_ver] = svd(A_ver);
U_ver
S_ver 
      % sigma max = 10.1986 using q2 and q3 in the same direction
      % sigma_min = 0.0574 moving the end effector with q6 but also
      % compensating with q4 in the opposite direction
      
% Horiztonal
q_hor = pi*[0;0;0;0;0;0];
A_hor = ComputeMatInert(q_hor);
[U_hor,S_hor,V_hor] = svd(A_hor);
U_hor
S_hor 
      % sigma_max = 10.976, lower, and similar value obtained with only
      % using q1
      % sigma_min equal to vertical configuration
%% Q15
disp('Question 15');
G = ComputeGravTorque(qi)
G = ComputeGravTorque([0;pi/2;0;0;0;0]) % upright position of the robot arm should produce zero forces on joints (structure bearing 100% support)

%% Q16
q_hor = pi*[0;0;0;0;0;0];
sum(ComputeGravTorque(q_hor))


%% Q18
disp('Question 18');
q_d_i = [-1;0;-1;-1;-1;-1];
q_d_f = [0;1;0;0;0;0];

% MU2 from Q14
mu2 = 10.976;



% Maximum acceleration
k_as = zeros(6,1);
for i = 1:6
    k_as(i) = (tau_max(i)*r_red(i)) / mu2; % max acceleration 
end

t_f_min = zeros(6,1);
for i = 1:6
    delta_q = q_d_f(i) - q_d_i(i); % angle between initial and final pos
    
    t_f_min(i) = sqrt(0.3e1) * sqrt(0.30e2) * (k_as(i) * sqrt(0.3e1)) ^ (-0.1e1 / 0.2e1) / 0.3e1;
end
t_f_min

%% Q19
time = linspace(0,0.5,100);
traj = zeros(6,100);
for t = 1:length(time)
   traj(:,t) = GenTraj(q_d_i,q_d_f,time(t));
end

plot_q(traj,zeros(6),zeros(6), 'Desired Joint Trajectories', true);


