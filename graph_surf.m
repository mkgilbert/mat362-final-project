function graph_surf(X, Y, u, n, min_time, step, max_time, axis_settings)
    TOL = 10^-3;
    [~, c] = size(axis_settings);
    for i = max_time:-step:min_time
        if c ~= 0
            axis(axis_settings)
        end
        W = u(i, :);
        % don't keep going through the loop if Z axis is close to 0
        if abs(max(W)) <= TOL
            continue;
        end
        figure();
        W = reshape(W, n-1, n-1);

        % padd the W matrix with 0s around all edges
        p = zeros(n+1, 1);
        q = [zeros(1, n-1); W; zeros(1, n-1)];
        r = zeros(n+1, 1);
        W = [p, q, r];
        surf(X, Y, W, 'EdgeColor','none','LineStyle','none','FaceLighting','phong');
        xlabel('x');
        ylabel('Time');
        zlabel('Temp');
    end
end