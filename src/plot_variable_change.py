import numpy as np
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt 

M_1 = 30
M_2 = 60
T = 90

omega_1 = 6
omega_2 = 0.2

G_1 = 100
G_2 = 0.5

G_s = [G_1, G_2]
time = np.linspace(0, T, 100*T)
omega = np.zeros(np.shape(time))
for G in G_s:
    for i, t in enumerate(time):
        if t < T/2:
            omega[i] = omega_1 + (omega_2 - omega_1)/(1 + np.exp(-G * (t - M_1)))
        else:
            omega[i] = omega_2 + (omega_1 - omega_2)/(1 + np.exp(-G * (t - M_2)))

    plt.plot(time, omega)

plt.xlabel("Time [sec]")
plt.ylabel("Var [-]")
plt.legend(["G = " + str(G_1), "G = " + str(G_2)])
plt.savefig("images/G.png")