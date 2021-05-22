function R = get_R_0i(alpha,d,theta,r,i)
if not(isequal(size(alpha),size(d),size(theta),size(r)))
    error('Geometric Model: parameter vectors need to have the same length')
end
g = eye(4); % initial value
for k = 1:i
    g = g * TransformMatElem(alpha(k),d(k),theta(k),r(k));
end
R=g(1:3,1:3);
end