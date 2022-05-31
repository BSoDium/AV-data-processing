function d = kronDel(A, B)
    % Kronecker delta of two matrices
    % A and B are assumed to be of equal sizes

    d = zeros(size(A));
    d(A == B) = 1;
end
