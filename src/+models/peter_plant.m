function y_dot = peter_plant(case_, t, u, y_prev)
    % case 1: first to second order system transition
    if case_ == 1
        M = -1;
        G = -100;
    % case 2: second to first order transition
    elseif case_ == 2 
        M = 0;
        G = 100;
    elseif case_ == 3    
        M = 50;
        G = 0.5;
    elseif case_ == 6
        M = 50;
        G = 100;
    else
        M = 0;
        G = 0;
    end

    omega_b1 = 6;
    omega_b2 = 0.2;
    k_c1 = 90;
    k_c2 = 30;

    omega_b = omega_b1 + (omega_b2 - omega_b1)./(1 + exp(-G * (t - M)));
    k_c = k_c1 + (k_c2 - k_c1)./(1 + exp(-G * (t - M)));
    
    
    A = [0, 1; 0, -omega_b];
    B = [0; k_c];
    y_dot = A*y_prev + B*u;
end