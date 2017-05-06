function [ u ] = mol( a, b, at, bt, nt, n, f, F )
    % Misc things
    xs = linspace(a, b, n-1)';
    t = linspace(at, bt, nt)';
    
    init = f(xs);

    [tt, u] = ode45(F, t, init);
    
    figure('Name', 'Method of Lines');
    %hold on;
    surf(xs, t, u, 'EdgeColor','none','LineStyle','none','FaceLighting','phong');
    xlabel('x');
    ylabel('Time');
    zlabel('Tempature');
end

