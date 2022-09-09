% Brute force algorithm to find all solutions (the solution's set)
% Vet-can algorithm
function C=search(i,n) % i=1, n=8
    if (i>n)
        % it is a solution, save or store or compare
        msgbox('je suis Dang');
        C = 0;
    else
        for j=1100:100:1900
            C(i)= j;% choose solution j for step i
            search(i+1,n); % call recursion
            C(i)=0;
        end
    end
end
