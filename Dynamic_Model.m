%% Dynamic Model
%load params to workspace
param;
clc;

% set q vector
qi=-pi/2*[1,0,1,1,1,1]';
thetai=qi+[0;0;pi/2;0;0;0];


%% Test Q12
disp('Question 12');
[JvGs, JwGs] = ComputeJacGi(angles_alpha, distances_d, thetai, distances_r, coordinates_G(1,:), coordinates_G(2,:), coordinates_G(3,:));
JvGs(:,:,6)
JwGs(:,:,6)

%% Test Q13
disp('Question 13');
A = ComputeMatInert(qi)

%% Test Q15
disp('Question 15');
G = ComputeGravTorque(qi)
G = ComputeGravTorque([0;pi/2;0;0;0;0]) % upright position of the robot arm should produce zero forces on joints (structure bearing 100% support)

%% Q18
disp('Question 18');
q_d_i = [-1;0;-1;-1;-1;-1];
q_d_f = [0;1;0;0;0;0];

% MU2 value not calculated!!
mu2 = 50; % DUMMY VALUE


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


