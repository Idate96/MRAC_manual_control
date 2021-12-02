function y_dot = plant(dynamics_case, speed_case, t, u, y_prev)

    if speed_case == 1
        G = 100;
    elseif speed_case == 0
        G = 0.5;
    else 
        G = 0;
    end
        
    if dynamics_case == 1
        omega_b1 = 6;
        omega_b2 = 6;
        k_c1 = 90;
        k_c2 = 90;    
        M = 0;
        
    elseif dynamics_case == 2
        omega_b1 = 0.2;
        omega_b2 = 0.2;
        k_c1 = 30;
        k_c2 = 30;    
        M = 0;
        
    else
        omega_b1 = 1000;
        omega_b2 = 1000;
        k_c1 = 0;
        k_c2 = 0;    
        M = 0;
    end        
        

    omega_b = omega_b1 + (omega_b2 - omega_b1)./(1 + exp(-G * (t - M)));
    k_c = k_c1 + (k_c2 - k_c1)./(1 + exp(-G * (t - M)));
    
    
    A = [0, 1; 0, -omega_b];
    B = [0; k_c];
    y_dot = A*y_prev + B*u;
end