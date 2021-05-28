function Gamma_f = ComputeFrictionTorque(q_dot)
param;
Gamma_f = zeros(6,1);
for i = 1:6
    Gamma_f(i) = q_dot(i)*F_v(i);
end
  
end

