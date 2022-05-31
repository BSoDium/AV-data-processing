function uk = calcul_structure_2(u, b, Dx, Dy, lambda, epsilon)
  %calcul_structure_2 - Description
  %
  % Syntax: output = calcul_structure_2(input, b, Dx, Dy, lambda, epsilon)
  %
  % Long description

  [n_lignes, nb_colonnes] = size(u);
  u = u(:);
  N = size(b, 1);
  dx_uk = Dx * u;
  dy_uk = Dy * u;

  W = spdiags(1 ./ (sqrt(dx_uk.^2 + dy_uk.^2 + epsilon)), 0, N, N);
  A = speye(N) - lambda * (- Dx' * W * Dx - Dy' * W * Dy);

  uk = A \ b;
  uk = reshape(uk, n_lignes, nb_colonnes);
end
