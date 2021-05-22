function g_0E = ComputeDGM(alpha,d,theta,r)
if not(isequal(size(alpha),size(d),size(theta),size(r)))
    error('Geometric Model: parameter vectors need to have the same length')
end
g_06 = eye(4); % initial value
for i = 1:size(alpha)
    g_06 = g_06 * TransformMatElem(alpha(i),d(i),theta(i),r(i));
end
global rE;
g_0E = g_06 * [eye(3),[0;0;rE];[0,0,0,1]];

end

