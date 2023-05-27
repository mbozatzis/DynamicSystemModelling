function [y_bar, theta] = LeastSquares(t, y, u, ode_case)
    N = length(y);

    H1s = tf(1, [1 30 20]);
    H2s = tf([1 0], [1 30 20]);
    H3s = tf(1, [1 30]);

    if ode_case == 1
        zeta = [-lsim(H3s, y, t) lsim(H3s, u, t)];
        zeta = zeta';

        A = zeros(2);
        B = zeros(2, 1);
    elseif ode_case == 2
        zeta = [-lsim(H2s, y, t) -lsim(H1s, y, t) lsim(H1s, u, t)];
        zeta = zeta';

        A = zeros(3);
        B = zeros(3, 1);
    elseif ode_case == 3
        zeta = [-lsim(H2s, y, t) -lsim(H1s, y, t) lsim(H2s, u, t) lsim(H1s, u, t)];
        zeta = zeta';

        A = zeros(4);
        B = zeros(4, 1);
    end

    for i = 1:N
        A = A + (1/N)*(zeta(:, i)*zeta(:, i)');
        B = B + (1/N)*(zeta(:, i)*y(i));
    end

    theta = A\B;

    y_bar = zeta' * theta;
end