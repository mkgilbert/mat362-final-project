function [ u ] = implicit( n, dx, at, bt, nt, D2, u0 )
    dt = (bt-at)/nt;
    I = speye((n-1)^2);
    
    alpha = dt/(dx)^2;
    u = zeros(nt, (n-1)^2);
    
    % Make B_alpha
    B_alpha = (I - alpha*D2);
    u(1, :) = u0;
    
    % Figure out u as t progresses
    for i=2:nt
        u(i,:) = B_alpha\u(i-1,:)';
    end
end

