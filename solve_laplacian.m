function solve_laplacian()
    a = 0; % Initial x
    b = 1; % Final x
    t0 = 0; % Initial time
    tf = 0.5; % Final time
    n = 25; % Size of n
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
    
    % setup graphing variables and find initial value for u
    [XS, YS] = meshgrid(xs, xs);
    u0 = f(XS, YS); 
    u0 = reshape(u0, (n-1)^2, 1);
    % define x and y values for the graphs
    [X, Y] = meshgrid(x, x);
    
    % solve using 4 different methods
    % implicit
    u = implicit(n, dx, t0, tf, nt, D2, u0);
    graph_surf(X, Y, u, n, 1, 1, nt, axis_settings);
    
    % crank nicolson
    [t_total, u] = crank_nicolson(n, dx, t0, tf, D2, u0);
    step = ceil(t_total/20);
    graph_surf(X, Y, u, n, 1, step, t_total, axis_settings);
    
    %explicit
    [t_total, u] = explicit(n, dx, t0, tf, D2, u0);
    step = ceil(t_total/20);
    graph_surf(X, Y, u, n, 1, step, t_total, axis_settings);
     D2 = D2 / dx^2;
     
    % method of lines
    t_total = ceil((tf-t0)/(0.24*dx^2));
    step = ceil(t_total/20);
    F = @(t, u) D2*u;
    u = mol(t0, tf, t_total, F, u0);
    graph_surf(X, Y, u, n, 1, step, t_total, axis_settings);
end