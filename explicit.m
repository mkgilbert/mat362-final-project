function [ nt, u ] = explicit(n, dx, at, bt, D2, u0 )
    % Calculate nt based on input parameters to ensure a alpha < 0.5
    nt = ceil((bt-at)/(0.24*dx^2));
    dt = (bt-at)/nt;
    t = linspace(at, bt, nt)';
    
    alpha = dt/(dx)^2;
    u = zeros(nt,(n-1)^2);
    I = speye((n-1)^2);
    % Make A_alpha
    A_alpha = (I + alpha*D2);
    u(1,:) = u0;
    
    % Figure out u as t progresses
    for i=2:nt
        u(i,:) = A_alpha*u(i-1,:)';
    end

%     figure('Name', 'Explicit');
%     xlabel('x');
%     ylabel('Time');
%     surf(xs, t, u, 'EdgeColor','none','LineStyle','none','FaceLighting','phong');
%     xlabel('x');
%     ylabel('Time');
%     zlabel('Tempature');
end

