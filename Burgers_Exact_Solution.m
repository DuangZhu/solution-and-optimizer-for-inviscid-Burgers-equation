function result = Burgers_Exact_Solution
F = @(x) sin ( x ); dF = @(x ) cos ( x );
psi = @(x ,t , xi ) x - F( xi )* t - xi ;
dpsi = @(x ,t , xi ) - dF ( xi )* t - 1 ;
N = 128;
x = linspace ( 0, 2*pi , N );
Output ( x , 0, F( x ) )
t = 0 ; Step = 0;
T = 1 ; % 中断时间为 1
N_T = 100; dt = T/ N_T ;

result = [];
while ( t <= T )
    Step = Step + 1; t = t + dt ;
    U = Exact_Solution ( x , t ) ;
    result = [result,U];
    Output ( x , t , U )
end

    function U = Exact_Solution ( x , t )
        U = zeros ( size ( x ) );
        for i = 1: N
            xi = Newton ( x(i ), t );
            U(i ) = F( xi );
        end
    end
    function xi = Newton ( x , t )
        K_Max = 100000;
        k = 1 ;
        xi0 = x ;
        tol = 1e-12;
        r = 1 ;
        while (r >tol && k <= K_Max )
            xi = xi0 - ...
                psi ( x , t , xi0 ) /...
                dpsi ( x , t , xi0 ) ;
            r = abs ( xi - xi0 ) ;
            xi0 = xi ;
            k = k + 1 ;
        end
    end
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    function Output ( x , t , U )
        plot ( x , U , 'r -o' )
        axis ( [0 , 2*pi , -1, 1 ] )
        title(['t=',num2str(t)]);
        pause ( 1 )
    end
end
