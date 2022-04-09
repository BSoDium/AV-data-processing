function u_kp1 = debruitage(b, u_k, lambda, Dx, Dy, epsilon)
  % Fonction de debruitage
  % Applique le modèle (4) du sujet à une image bruitée
  %

  N = size(b, 1);
  dx_uk = Dx * u_k;
  dy_uk = Dy * u_k;

  W = spdiags(1 ./ (sqrt(dx_uk.^2 + dy_uk.^2 + epsilon)), 0, N, N);
  A = speye(N) - lambda * (- Dx' * W * Dx - Dy' * W * Dy);

  u_kp1 = A \ b;
end
