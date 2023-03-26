function [Vc_t, Vr_t] = CircuitLSM(Vc, Vr, u1, u2)
    N = length(Vc);

    t = 0:0.1:10;
    H1s = tf(1, [1 3 2]);
    H2s = tf([1 0], [1 3 2]);

    zeta_c = [-lsim(H2s, Vc, t) -lsim(H1s, Vc, t) lsim(H2s, u1, t) lsim(H1s, u1, t) lsim(H2s, u2, t) lsim(H1s, u2, t)];
    zeta_c = zeta_c';

    zeta_r = [-lsim(H2s, Vr, t) -lsim(H1s, Vr, t) lsim(H2s, u1, t) lsim(H1s, u1, t) lsim(H2s, u2, t) lsim(H1s, u2, t)];
    zeta_r = zeta_r';

    Ac = zeros(6);
    Bc = zeros(6, 1);
    Ar = zeros(6);
    Br = zeros(6, 1);

    for i = 1:N
        Ac = Ac + (1/N)*(zeta_c(:, i)*zeta_c(:, i)');
        Bc = Bc + (1/N)*(zeta_c(:, i)*Vc(i));

        Ar = Ar + (1/N)*(zeta_r(:, i)*zeta_r(:, i)');
        Br = Br + (1/N)*(zeta_r(:, i)*Vr(i));
    end

    theta_c = Ac\Bc;
    theta_r = Ar\Br;

    Vc_t = zeta_c' * theta_c;
    Vr_t = zeta_r' * theta_r;
end