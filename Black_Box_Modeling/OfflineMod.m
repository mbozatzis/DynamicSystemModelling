clc
clear

t = 0:0.001:20;

u = @(t) cos(t) + cos(2*t);
uin = u(t);
[y, ~] = sys(t, u);
y_bar = LeastSquares(t, y, uin);

figure(1);
plot(t, y, t, y_bar);
title("Black Box System Simulation");
legend("Exact Solution", "LSM Solution");

figure(2);
plot(t, y-y_bar);
title("LSM Error");