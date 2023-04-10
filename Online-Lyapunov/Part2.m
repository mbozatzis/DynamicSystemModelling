clc
clear

a = 3;
b = 0.5;

t = 0:0.01:15;
[~, y_a] = ode45(@(t, y) L_p_ode(t, y, u2(t)), t, [0; 0; 0; 0]);
[~, y_b] = ode45(@(t, y) L_ps_ode(t, y, u2(t)), t, [0; 0; 0; 0]);

x_a = y_a(:, 4);
x_bar_a = y_a(:, 1);
theta1_a = y_a(:, 2);
theta2_a = y_a(:, 3);

a_bar_a = theta1_a;
b_bar_a = theta2_a;



x_b = y_b(:, 4);
x_bar_b = y_b(:, 1);
theta1_b = y_b(:, 2);
theta2_b = y_b(:, 3);

a_bar_b = theta1_b;
b_bar_b = theta2_b;


% Results for (a)
figure(1);
subplot(2, 1, 1);
plot(t, x_bar_a, t, x_a);
legend('Estimated ODE solution', 'Exact ODE solution');
title('ODE solutions (a)');
subplot(2, 1, 2);
plot(t, x_a-x_bar_a);
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
plot(t, x_b-x_bar_b);
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



function u2 = u2(t)
    u2 = 10*sin(3*t);
end

function [n, dndt] = noise(t)
    n0 = 0.5;
    f = 40;
    n = n0*sin(2*pi*f*t);
    dndt = 2*pi*f*n0*cos(2*pi*f*t);
end

function dydt = L_p_ode(t, y, u)
    dydt = zeros(4, 1);
    [n, dndt] = noise(t);

    % x_bar = y(1)
    % theta1 = y(2)
    % theta2 = y(3)
    % x = y(4);
    a = 3;
    b = 0.5;

    dydt(4) = -a*y(4) + b*u -dndt - a*n;
    e = y(4) - y(1) + n;
    dydt(1) = -y(2)*y(1) + y(3)*u;
    dydt(2) = -e*y(1);
    dydt(3) = e*u;
end

function dydt = L_ps_ode(t, y, u)
    dydt = zeros(4, 1);
    [n, dndt] = noise(t);

    % x_bar = y(1)
    % theta1 = y(2)
    % theta2 = y(3)
    % x = y(4);
    a = 3;
    b = 0.5;
    theta_m = 0.5;
    
    dydt(4) = -a*y(4) + b*u - dndt - a*n;
    e = y(4) - y(1) + n;
    dydt(1) = -y(2)*y(1) + y(3)*u - theta_m*e;
    dydt(2) = -e*y(1);
    dydt(3) = e*u;
end