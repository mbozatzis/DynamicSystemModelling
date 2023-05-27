clc
clear

t = 0:0.001:20;

u = @(t) cos(t) + cos(2*t);
uin = u(t);
[y, ~] = sys(t, u);


[y_bar_1, th_1] = LeastSquares(t, y, uin, 1);
figure(1);
subplot(2, 1, 1);
plot(t, y, t, y_bar_1);
legend("Exact Solution", "LSM Solution");
subplot(2, 1, 2);
plot(t, y-y_bar_1);
legend("Error");
sgtitle("Black Box System Simulation with model: y' + ay = bu");
fprintf("Model A Parameters:\n");
fprintf("a = %f\n", th_1(1) + 30);
fprintf("b = %f\n\n", th_1(2));

[y_bar_2, th_2] = LeastSquares(t, y, uin, 2);
figure(2);
subplot(2, 1, 1);
plot(t, y, t, y_bar_2);
legend("Exact Solution", "LSM Solution");
subplot(2, 1, 2);
plot(t, y-y_bar_2);
legend("Error");
sgtitle("Black Box System Simulation with model: y'' + a_1y' + a_2y = bu");
fprintf("Model B Parameters:\n");
fprintf("a_1 = %f\n", th_2(1) + 30);
fprintf("a_2 = %f\n", th_2(2) + 20)
fprintf("b = %f\n\n", th_2(3));

[y_bar_3, th_3] = LeastSquares(t, y, uin, 3);
figure(3);
subplot(2, 1, 1);
plot(t, y, t, y_bar_3);
legend("Exact Solution", "LSM Solution");
subplot(2, 1, 2);
plot(t, y-y_bar_3);
legend("Error");
sgtitle("Black Box System Simulation with model: y'' + a_1y' + a_2y = b_1u' + b_2u");
fprintf("Model C Parameters:\n");
fprintf("a_1 = %f\n", th_3(1) + 30);
fprintf("a_2 = %f\n", th_3(2) + 20)
fprintf("b_1 = %f\n", th_3(3));
fprintf("b_2 = %f\n\n", th_3(4));