%% Dynamic Model
%load params to workspace
param;
clc;

% set q vector
qi=-pi/2*[1,0,1,1,1,1]';
thetai=qi+[0;0;pi/2;0;0;0];


%% Test Q12
[JvGs, JwGs] = ComputeJacGi(angles_alpha, distances_d, thetai, distances_r, coordinates_G(1,:), coordinates_G(2,:), coordinates_G(3,:));
JvGs(:,:,6)
JwGs(:,:,6)

%% Test Q13
A = ComputeMatInert(qi)


%% Q14 
% qmins=pi*[-1,-0.5,-1,-1,-0.5,-1];
% qmaxs=pi/2*[1,1,0,1,1,1];
% lambda_max = zeros(10,10,10,10,10,10);
% lambda_min = zeros(10,10,10,10,10,10);
% q1s = linspace(qmins(1),qmaxs(1),10);
% q2s = linspace(qmins(2),qmaxs(2),10);
% q3s = linspace(qmins(3),qmaxs(3),10);
% q4s = linspace(qmins(4),qmaxs(4),10);   
% q5s = linspace(qmins(5),qmaxs(5),10);
% q6s = linspace(qmins(6),qmaxs(6),10);
% for q1 = 1:10
% for q2 = 1:10
% for q3 = 1:10
% for q4 = 1:10    
% for q5 = 1:10
% for q6 = 1:10
%     q = [q1s(q1);q2s(q2);q3s(q3);q4s(q4);q5s(q5);q6s(q6)]+[0;0;pi/2;0;0;0];
%     A = ComputeMatInert(q);
%     lambdas = eig(A);
%     lambda_max(q1,q2,q3,q4,q5,q6) = max(lambdas);
%     lambda_min(q1,q2,q3,q4,q5,q6) = min(lambdas);
% end
% end
% end
% end
% end
% end

%% Test Q15
G = ComputeGravTorque(qi)
G = ComputeGravTorque([0;pi/2;0;0;0;0]) % upright position of the robot arm should produce zero forces on joints (structure bearing 100% support)

%% Q18
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
    % if joint speed is not bounded, and max torques are the same for
    % acceleration and deceleration, we take 0.5*delta_q to accelerate and
    % 0.5*delta_q to decelerate
    t_f_min(i) = sqrt(2*delta_q/k_as(i));
end

%% Q19
time = linspace(0,0.5,100);
traj = zeros(6,100);
for t = 1:length(time)
   traj(:,t) = GenTraj(q_d_i,q_d_f,time(t));
end

plot_q(traj,zeros(6),zeros(6), 'Desired Joint Trajectories', false);


