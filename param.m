%clear all;
%% Parameter Data
d3=0.7;
r1=0.5;
r4=0.2;
global rE;
rE=0.1;

%% initialize values
global angles_alpha;
global distances_d;
global distances_r;
angles_alpha=pi/2*[0;1;0;1;-1;1];
distances_d=[0;0;d3;0;0;0];
distances_r=[r1;0;0;r4;0;0];

%% Parameters for tutorial 2
m(1) = 15;
m(2) = 10;
m(3) = 1;
m(4) = 7;
m(5) = 1;
m(6) = 0.5;

I(:,:,1) = [0.8, 0, 0.05; 0, 0.8, 0; 0.05, 0, 0.1];
I(:,:,2) = [0.1, 0, 0.1; 0, 1.5, 0; 0.1, 0, 1.5];
I(:,:,3) = [0.05, 0, 0; 0, 0.01, 0; 0, 0, 0.05];
I(:,:,4) = [0.5, 0, 0; 0, 0.5, 0; 0, 0, 0.05];
I(:,:,5) = [0.01, 0, 0; 0, 0.01, 0; 0, 0, 0.01];
I(:,:,6) = [0.01, 0, 0; 0, 0.01, 0; 0, 0, 0.01];

coordinates_G(:,1) = [0;0;-0.25];
coordinates_G(:,2) = [0.35;0;0];
coordinates_G(:,3) = [0;-0.1;0];
coordinates_G(:,4) = [0;0;0];
coordinates_G(:,5) = [0;0;0];
coordinates_G(:,6) = [0;0;0];

Jm = 1e-5;

r_red(1) = 100;
r_red(2) = 100;
r_red(3) = 100;
r_red(4) = 70;
r_red(5) = 70;
r_red(6) = 70;

g = [0;0;-9.81];

F_v = 10*ones(6,1);
tau_max = 5*ones(6,1);

K_P = 1;
K_D = 1;