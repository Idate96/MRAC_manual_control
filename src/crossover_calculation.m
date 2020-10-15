%% verification expected value 5
syms x
p = 0.2;
k_c = 30;
k_d = 5/k_c;
k_p = p * k_d;
eqn = (x^2 * k_p - x^2 * p * k_d)^2 + (p * x * k_p + x^3 * k_d)^2 - (x^4 + p^2 * x^2)^2/k_c^2;
S = solve(eqn);
%%
syms x
p = 0.2;
k_c = 30;
k_d = 0.065;
k_p = 0.1;
eqn = (x^2 * k_p - x^2 * p * k_d)^2 + (p * x * k_p + x^3 * k_d)^2 - (x^4 + p^2 * x^2)^2/k_c^2;
S = solve(eqn);
sol_num = double(vpa(S, 5));
crossover = sol_num(sol_num > 0);
crossover