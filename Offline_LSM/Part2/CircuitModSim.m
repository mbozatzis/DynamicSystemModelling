clc
clear

t = 0:0.1:10;
u1 = 2*sin(4*t);
u2 = 4*ones(size(t));

[Vc, Vr] = v(t);

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

