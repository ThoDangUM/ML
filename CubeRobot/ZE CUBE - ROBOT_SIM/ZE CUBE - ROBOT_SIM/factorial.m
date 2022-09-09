function fac = factorial(N)
    if N==0,
        fac = 1;
    else
        fac = N*factorial(N-1);
    end
end