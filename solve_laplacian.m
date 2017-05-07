function solve_laplacian()
    a = 0; % Initial x
    b = 1; % Final x
    t0 = 0; % Initial time
    tf = 0.5; % Final time
    n = 50; % Size of n
    nt = 25; % Number of time steps (except in explicit/C-N)
    dx = (b-a)/n;
    x = linspace(a, b, n+1);
    xs = x(2: end-1);
    axis_settings = [a b a b 0 20];
    
    f = @(x, y) sin(pi^2*x)*sin(pi^2*y);
    
    % Make Special (n-1)^2 x (n-1)^2 D2 matrix
    d = ones(n, 1);
    T = spdiags([d, -2*d, d], [-1, 0, 1], n-1, n-1);
    I = speye(n-1);
    D2 = kron(I, T) + kron(T, I);
    [XS, YS] = meshgrid(xs, xs);
    u0 = f(XS, YS); 
    u0 = reshape(u0, (n-1)^2, 1);
    
    % define x and y values for the graphs
    [X, Y] = meshgrid(x, x);
    
    u = implicit(n, dx, t0, tf, nt, D2, u0);
    step = 1;
    graph_surf(X, Y, u, n, 1, step, nt, axis_settings);
%     [t_total, u] = explicit(n, dx, t0, tf, D2, u0);
%     step = ceil(t_total/40);
%     axis_settings = [a b a b 0 20];
%     graph_surf(X, Y, u, n, 50, step, t_total, axis_settings);

    %implicit(a, b, at, bt, nt, n, f);
    %explicit(a, b, at, bt, n, f);
    %crank_nicolson(a, b, at, bt, n, f);
    %mol(a, b, at, bt, nt, n, f, F);
end