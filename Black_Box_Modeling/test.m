clc
clear

t = 0:0.001:20;


% f1 = @(t) sinc(t);
% f2 = @(t) 1/(t+1);
% 
% u = @(t) 20*f1(t) + 60*f2(t);
% [y1, ts] = sys(t, u);
% [y2a, ~] = sys(t, f1);
% [y2b, ~] = sys(t, f2);
% y2 = 20*y2a + 60*y2b;

u = @(t) cos(t) + cos(2*t) + cos(6*t);
uin = u(t);
[y, ts] = sys(t, u);
y_bar = LeastSquares(t, y, uin);

plot(ts, y);
hold on;
plot(ts, y_bar);