clc
clear

t = 0:0.1:10;
u1 = 2*sin(4*t);
u2 = 4*ones(size(t));

[Vc, Vr] = v(t);

it = randi(101, 2, 3);
for i = 1:3
    Vc(it(1, i)) = Vc(it(1, i)) + 13*Vc(it(1, i));
    Vr(it(2, i)) = Vr(it(2, i)) + 13*Vr(it(2, i));
end

[Vc_t, Vr_t] = CircuitLSM(Vc, Vr, u1, u2);
ec = Vc - Vc_t';
er = Vr - Vr_t';

figure(1);
plot(t, Vc, t, Vc_t);
title("Capacitor Voltage VC");
legend("Exact Solution", "LSM Solution");
xlabel("Time");
ylabel("Voltage VC(t)");

figure(2);
plot(t, Vr, t, Vr_t);
title("Resistor Voltage VR");
legend("Exact Solution", "LSM Solution");
xlabel("Time");
ylabel("Voltage VR(t)");

figure(3);
plot(t, ec);
title("Capacitor Voltage Error");
xlabel("Time");
ylabel("Error EC(t)");

figure(4);
plot(t, er);
title("Resistor Voltage Error");
xlabel("Time");
ylabel("Error ER(t)");