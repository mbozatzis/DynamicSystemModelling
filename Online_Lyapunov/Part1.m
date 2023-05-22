clc
clear

a = 3;
b = 0.5;
gamma = 10;

t = 0:0.01:5;
[~, y_a] = ode45(@(t, y) g_d_ode(t, y, u1(t), gamma), t, [0; 0; 0; 0; 0]);
[~, y_b] = ode45(@(t, y) g_d_ode(t, y, u2(t), gamma), t, [0; 0; 0; 0; 0]);

x_a = y_a(:, 5);
zeta1_a = y_a(:, 1);
zeta2_a = y_a(:, 2);
theta1_a = y_a(:, 3);
theta2_a = y_a(:, 4);

a_bar_a = theta1_a + 3;
b_bar_a = theta2_a;

for i = 1:length(t)
    x_bar_a(i) = [theta1_a(i) theta2_a(i)]*[zeta1_a(i); zeta2_a(i)];
end


x_b = y_b(:, 5);
zeta1_b = y_b(:, 1);
zeta2_b = y_b(:, 2);
theta1_b = y_b(:, 3);
theta2_b = y_b(:, 4);

a_bar_b = theta1_b + 3;
b_bar_b = theta2_b;

for i = 1:length(t)
    x_bar_b(i) = [theta1_b(i) theta2_b(i)]*[zeta1_b(i); zeta2_b(i)];
end

% Results for (a)
figure(1);
subplot(2, 1, 1);
plot(t, x_bar_a, t, x_a);
legend('Estimated ODE solution', 'Exact ODE solution');
title('ODE solutions (a)');
subplot(2, 1, 2);
plot(t, x_a-x_bar_a');
title('Estimated solution error (a)');

figure(2);
subplot(2, 1, 1);
plot(t, a_bar_a);
hold on;
yline(a, '-r');
title('a parameter estimation (a)');
subplot(2, 1, 2);
plot(t, a-a_bar_a);
title('a parameter estimation error (a)');

figure(3);
subplot(2, 1, 1);
plot(t, b_bar_a);
hold on;
yline(b, '-r');
title('b parameter estimation (a)');
subplot(2, 1, 2);
plot(t, b-b_bar_a);
title('b parameter estimation error (a)');

% Results for (b)
figure(4);
subplot(2, 1, 1);
plot(t, x_bar_b, t, x_b);
legend('Estimated ODE solution', 'Exact ODE solution');
title('ODE solutions (b)');
subplot(2, 1, 2);
plot(t, x_b-x_bar_b');
title('Estimated solution error (b)');

figure(5);
subplot(2, 1, 1);
plot(t, a_bar_b);
hold on;
yline(a, '-r');
title('a parameter estimation (b)');
subplot(2, 1, 2);
plot(t, a-a_bar_b);
title('a parameter estimation error (b)');

figure(6);
subplot(2, 1, 1);
plot(t, b_bar_b);
hold on;
yline(b, '-r');
title('b parameter estimation (b)');
subplot(2, 1, 2);
plot(t, b-b_bar_b);
title('b parameter estimation error (b)');


function u1 = u1(t)
    u1 = 10;
end

function u2 = u2(t)
    u2 = 10*sin(3*t);
end

function dydt = g_d_ode(t, y, u, gamma)
    dydt = zeros(5, 1);
    % zeta1 = y(1)
    % zeta2 = y(2)
    % theta1 = y(3)
    % theta2 = y(4)
    % x = y(5);
    a = 3;
    b = 0.5;

    dydt(5) = -a*y(5) + b*u;
    e = y(5) - y(3)*y(1) - y(4)*y(2);
    dydt(1) = y(5) - 3*y(1);
    dydt(2) = u - 3*y(2);
    dydt(3) = gamma*e*y(1);
    dydt(4) = gamma*e*y(2);
end