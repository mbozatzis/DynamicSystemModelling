clc
clear

A = [-0.25 3; -5 0];
B = [0.5; 1.5];

t = 0:0.01:60;
y0 = zeros(1,10);
[~, y] = ode45(@(t, y) L_ps_ode(t, y, u_in(t)), t, y0);

x = [y(:, 9) y(:, 10)];
x_bar = [y(:, 1) y(:, 2)];
a11_bar = y(:, 3);
a12_bar = y(:, 4);
a21_bar = y(:, 5);
a22_bar = y(:, 6);
b1_bar = y(:, 7);
b2_bar = y(:, 8);


% Results 

figure(1);
subplot(2, 2, 1);
plot(t, x_bar(:, 1), t, x(:, 1));
legend('Estimated ODE solution', 'Exact ODE solution');
title('ODE solutions - x');
subplot(2, 2, 2);
plot(t, x(:, 1)-x_bar(:, 1));
title('Estimated solution error - x');
subplot(2, 2, 3);
plot(t, x_bar(:, 2), t, x(:, 2));
legend('Estimated ODE solution', 'Exact ODE solution');
title('ODE solutions - y');
subplot(2, 2, 4);
plot(t, x(:, 2)-x_bar(:, 2));
title('Estimated solution error - y');

figure(2);
subplot(2, 2, 1);
plot(t, a11_bar);
hold on;
yline(A(1,1), '-r');
title('a11 parameter estimation');
subplot(2, 2, 2);
plot(t, a12_bar);
hold on;
yline(A(1,2), '-r');
title('a12 parameter estimation');
subplot(2, 2, 3);
plot(t, a21_bar);
hold on;
yline(A(2,1), '-r');
title('a21 parameter estimation');
subplot(2, 2, 4);
plot(t, a22_bar);
hold on;
yline(A(2,2), '-r');
title('a22 parameter estimation');

figure(3);
subplot(2, 1, 1);
plot(t, b1_bar);
hold on;
yline(B(1), '-r');
title('b1 parameter estimation');
subplot(2, 1, 2);
plot(t, b2_bar);
hold on;
yline(B(2), '-r');
title('b2 parameter estimation');


function u_in = u_in(t)
    u_in = 3.5*sin(7.2*t)+2*sin(11.7*t);
end


function dydt = L_ps_ode(t, y, u)
    dydt = zeros(10, 1);

    % x_bar1 = y(1)
    % x_bar2 = y(2)
    % a11 = y(3)
    % a12 = y(4)
    % a21 = y(5)
    % a22 = y(6)
    % b1 = y(7)
    % b2 = y(8)
    % x1 = y(9)
    % x2 = y(10)
    A = [-0.25 3; -5 0];
    B = [0.5; 1.5];
    C = [0.3 0.3; 0.3 0.3];

    dydt(9) = A(1,1)*y(9) + A(1,2)*y(10) + B(1)*u;
    dydt(10) = A(2,1)*y(9) + A(2,2)*y(10) + B(2)*u;
    
    e = [y(9) - y(1); y(10) - y(2)];
    dydt(1) = y(3)*y(1) + y(4)*y(2)+y(7)*u-(C(1,1)*e(1) + C(1,2)*e(2));
    dydt(2) = y(5)*y(1) + y(6)*y(2)+y(8)*u-(C(2,1)*e(1) + C(2,2)*e(2));
    dydt(3) = y(1)*e(1);
    dydt(4) = y(2)*e(1);
    dydt(5) = y(1)*e(2);
    dydt(6) = y(2)*e(2);
    dydt(7) = e(1)*u;
    dydt(8) = e(2)*u;

end