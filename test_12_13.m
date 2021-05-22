%load params to workspace
param;
clc;

% set q vector
qi=-pi/2*[1,0,1,1,1,1]';
thetai=qi+[0;0;pi/2;0;0;0];


%% Test Q12
[JvGs, JwGs] = ComputeJacGi(angles_alpha, distances_d, thetai, distances_r, G(1,:), G(2,:), G(3,:));
JvGs(:,:,6)
JwGs(:,:,6)

%% Test Q13
A = ComputeMatInert(qi)