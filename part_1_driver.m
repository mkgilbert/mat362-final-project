function part_1_driver()
    a = 0; % Initial x
    b = 1; % Final x
    at = 0; % Initial time
    bt = 0.5; % Final time
    n = 100; % Size of n
    nt = 25; % Number of time steps (except in explicit/C-N)
    dx = (b-a)/n;

    % Make D2
    make_D2 = @(n) (spdiags([ones(n,1), -2*ones(n,1), ones(n,1)], [-1, 0, 1], n - 1, n - 1)*(1/dx^2));
    
    f = @(x) sin(pi*x)+(1/5).*sin(10*pi*x);
    %f = @(x) ones(size(x));
    F = @(t, u) make_D2(n)*u;
    
    implicit(a, b, at, bt, nt, n, f);
    explicit(a, b, at, bt, n, f);
    crank_nicolson(a, b, at, bt, n, f);
    mol(a, b, at, bt, nt, n, f, F);
end