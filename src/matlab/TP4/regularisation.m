function R = regularisation(i, j, k, kij)
  % Retourne la valeur du terme de régularisation

  M = zeros(size(k));
  M(i, j) = 1;
  kt = k(conv2(M, [1, 1, 1; 1, 0, 1; 1, 1, 1], 'same') > 0);

  R = sum(1 - kronDel(kij, kt));
end
