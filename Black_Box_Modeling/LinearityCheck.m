clc
clear

t = 0:0.001:20;

% Define Test Input Functions
f1 = @(t) 2.6*sin(1.7*t);
f2 = @(t) 5*cos(3.1*t);
f3 = @(t) 0.9*sin(5*t);
f4 = @(t) 8.4*cos(7.3*t);
f5 = @(t) 3.2*sin(8.9*t);

a1 = 5;
a2 = 0.1;
a3 = 100;
a4 = 0.03;

u1t = @(t) f1(t) + f2(t) + f3(t) + f4(t) + f5(t);
u2t = @(t) f1(t) + f2(t) + f3(t) + f4(t);
u3t = @(t) f1(t) + f2(t) + f3(t);
u4t = @(t) f1(t) + f2(t);

u1s = @(t) a1*f1(t);
u2s = @(t) a2*f2(t);
u3s = @(t) a3*f3(t);
u4s = @(t) a4*f4(t);

% Calculate output for each input
[y1, ~] = sys(t, f1);
[y2, ~] = sys(t, f2);
[y3, ~] = sys(t, f3);
[y4, ~] = sys(t, f4);
[y5, ~] = sys(t, f5);

[y1t, ~] = sys(t, u1t);
[y2t, ~] = sys(t, u2t);
[y3t, ~] = sys(t, u3t);
[y4t, ~] = sys(t, u4t);

[y1s, ~] = sys(t, u1s);
[y2s, ~] = sys(t, u2s);
[y3s, ~] = sys(t, u3s);
[y4s, ~] = sys(t, u4s);

% Results
figure(1);
subplot(2, 1, 1);
plot(t, y1 + y2 + y3 + y4 + y5);
title("Output from test function and the superposition of its components")
hold on;
plot(t, y1t);
subplot(2, 1, 2);
plot(t, y1t - (y1 + y2 + y3 + y4 + y5));
title("Error")

figure(2);
subplot(2, 1, 1);
plot(t, y1 + y2 + y3 + y4);
title("Output from test function and the superposition of its components")
hold on;
plot(t, y2t);
subplot(2, 1, 2);
plot(t, y2t - (y1 + y2 + y3 + y4));
title("Error")

figure(3);
subplot(2, 1, 1);
plot(t, y1 + y2 + y3);
title("Output from test function and the superposition of its components")
hold on;
plot(t, y3t);
subplot(2, 1, 2);
plot(t, y3t - (y1 + y2 + y3));
title("Error")

figure(4);
subplot(2, 1, 1);
plot(t, y1 + y2);
title("Output from test function and the superposition of its components")
hold on;
plot(t, y4t);
subplot(2, 1, 2);
plot(t, y4t - (y1 + y2));
title("Error")

figure(5);
subplot(2, 2, 1);
plot(t, y1s - a1*y1);
subplot(2, 2, 2);
plot(t, y2s - a2*y2);
subplot(2, 2, 3);
plot(t, y3s - a3*y3);
subplot(2, 2, 4);
plot(t, y4s - a4*y4);
sgtitle("Error from scaling");
