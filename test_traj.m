tf=5;
t = linspace(0,tf,100);
r = 10*(t/tf).^3 - 15*(t/tf).^4 + 6*(t/tf).^5;
plot(t,r)