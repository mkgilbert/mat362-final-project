function [ u ] = mol( t0, tf, nt, F, u0 )
    t = linspace(t0, tf, nt)';
    
    [tt, u] = ode45(F, t, u0);
end

