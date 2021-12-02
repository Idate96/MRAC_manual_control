p1 = 10;
p2 = 0.02;
k1 = 150;
k2 = 30;
s = tf('s');
H1 = k1/(s*(s + p1));
H2 = k2/(s*(s + p2));

bode(H1);
figure;
bode(H2);