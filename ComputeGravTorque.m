function Gravity_vector = ComputeGravTorque(q)
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
    
    theta=q+[0;0;pi/2;0;0;0];
    [Jvgi,~] = ComputeJacGi(angles_alpha, distances_d, theta, distances_r, coordinates_G(1,:), coordinates_G(2,:), coordinates_G(3,:));
    Gravity_vector = zeros(6,1);
    for i = 1:length(q)
      Gravity_vector =   Gravity_vector - m(i)*Jvgi(:,:,i)'*g;
    end
end

