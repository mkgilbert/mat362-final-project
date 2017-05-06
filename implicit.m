function [ u ] = implicit( a, b, at, bt, nt, n, f )
    % Calculate x's and xs's and other misc things
    dx = (b-a)/n;
    dt = (bt-at)/nt;
    xs = linspace(a, b, n-1);
    t = linspace(at, bt, nt)';
    
    % Make D2 & I
    d_ones  = ones(n,1);
    D2 = spdiags([d_ones, -2*d_ones, d_ones], [-1, 0, 1], n - 1, n - 1);
    I = speye(n-1);
    
    alpha = dt/(dx)^2;
    u = zeros(nt,n-1);
    
    % Make B_alpha
    B_alpha = (I - alpha*D2);
    u(1,:) = f(xs)';
    
    % Figure out u as t progresses
    for i=2:nt
        u(i,:) = B_alpha\u(i-1,:)';
    end
    
    figure('Name', 'Implicit');
    xlabel('x');
    ylabel('Time');
    %hold on;
    surf(xs, t, u, 'EdgeColor','none','LineStyle','none','FaceLighting','phong');
    xlabel('x');
    ylabel('Time');
    zlabel('Tempature');
end

