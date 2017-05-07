function [ nt, u ] = crank_nicolson( n, dx, t0, tf, D2, u0 )
    % Calculate nt based on input parameters to ensure a alpha < 0.5
    nt = ceil((tf-t0)/(0.24*dx^2));
    dt = (tf-t0)/nt;

    I = speye((n-1)^2);
    
    alpha = (dt/(dx)^2)/2;
    u = zeros(nt, (n-1)^2);

    u(1,:) = u0;

    % Make B_alpha
    B_alpha = (I - alpha*D2);
    
    % Make A_alpha
    A_alpha = (I + alpha*D2);
    
    % Crank all those nickels!
    for i=2:nt
        u(i,:) = B_alpha\(A_alpha*u(i-1,:)');
    end
end

