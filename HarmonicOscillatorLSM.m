function [b, k, m, y_t] = HarmonicOscillatorLSM(y, u)
    N = length(y);

    t = 0:0.1:10;
    H1s = tf(1, [1 3 2]);
    H2s = tf([1 0], [1 3 2]);

    zeta = [-lsim(H2s, y, t) -lsim(H1s, y, t) lsim(H1s, u, t)];
    zeta = zeta';

    A = zeros(3);
    B = zeros(3, 1);

    for i = 1:N
        A = A + (1/N)*(zeta(:, i)*zeta(:, i)');
        B = B + (1/N)*(zeta(:, i)*y(i));
    end

    theta = A\B;
    m = 1/theta(3);
    b = (theta(1)+3)*m;
    k = (theta(2)+2)*m;
    y_t = zeta' * theta;
end