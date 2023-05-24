function y_bar = LeastSquares(t, y, u)
    N = length(y);

    H1s = tf(1, [1 30 20]);
    H2s = tf([1 0], [1 30 20]);

    zeta = [-lsim(H2s, y, t) -lsim(H1s, y, t) lsim(H2s, u, t) lsim(H1s, u, t)];
    zeta = zeta';

    A = zeros(4);
    B = zeros(4, 1);

    for i = 1:N
        A = A + (1/N)*(zeta(:, i)*zeta(:, i)');
        B = B + (1/N)*(zeta(:, i)*y(i));
    end

    theta = A\B;

    y_bar = zeta' * theta;
end