clc
clear

gamma = 500;
u = @(t) cos(t) + cos(2*t);
ti = @(t) t/0.001 + 1;
t = 0:0.001:20;
[y, ~] = sys(t, u);

[~, var_bar] = ode45(@(t, var) g_d_ode(t, var, u(t), y, ti(t), gamma), t, [0; 0; 0; 0]);

zeta1 = var_bar(:, 1);
zeta2 = var_bar(:, 2);
theta1 = var_bar(:, 3);
theta2 = var_bar(:, 4);

a_bar = theta1 + 3;
b_bar = theta2;

for i = 1:length(t)
    y_bar(i) = [theta1(i) theta2(i)]*[zeta1(i); zeta2(i)];
end

figure(1);
plot(t, y, t, y_bar);
title("Black Box System Simulation");
legend("Exact Solution", "Gradient Method Solution");

figure(2);
plot(t, y-y_bar');
title("Gradient Method Error");

function dydt = g_d_ode(t, var, u, y, ti, gamma)
    dydt = zeros(4, 1);
    % zeta1 = var(1)
    % zeta2 = var(2)
    % theta1 = var(3)
    % theta2 = var(4)

    y_r = y(round(ti));
    e = y_r - var(3)*var(1) - var(4)*var(2);
    dydt(1) = y_r - 3*var(1);
    dydt(2) = u - 3*var(2);
    dydt(3) = gamma*e*var(1);
    dydt(4) = gamma*e*var(2);
end

