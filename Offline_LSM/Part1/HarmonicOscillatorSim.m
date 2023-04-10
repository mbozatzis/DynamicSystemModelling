clc
clear

m = 10;
b = 0.5;
k = 2.5;

t = 0:0.1:10;
[t, y] = ode45(@(t, y) odefunc(t, y, m, b, k), t, [0 0]);
u = 15 * sin(3*t) + 8;

y = y(:, 1);
[b_t, k_t, m_t, y_t] = HarmonicOscillatorLSM(y, u);
e = y - y_t;

figure(1);
plot(t, y, 'ro', t, y_t, 'b-');
title("ODE Solutions");
legend("Exact Solution", "LSM Solution");
xlabel("Time");
ylabel("Position y(t)");

figure(2);
plot(t, e);
title("Solution estimation error");
xlabel("Time");
ylabel("Solution error e(t)");

fprintf("Using the Least Square Method (LSM) we get the values:\n");
fprintf("m = %f\n", m_t);
fprintf("b = %f\n", b_t);
fprintf("k = %f\n", k_t);



function dydt = odefunc(t, y, m, b, k)
    u = 15 * sin(3*t) + 8;
    dydt = zeros(2, 1);
    dydt(1) = y(2);
    dydt(2) = (1/m)*u - (b/m)*y(2) - (k/m)*y(1);
end