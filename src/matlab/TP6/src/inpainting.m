function u_kp1 = inpainting(b, u_k, lambda, D, Dx, Dy, epsilon)
  % Fonction d'inpainting
  %
  % qu'est-ce qui est jaune et qui attend ? Un tp de TAV auquel je pige rien

  N = size(b, 1);
  dx_uk = Dx * u_k;
  dy_uk = Dy * u_k;

  W = spdiags(1 ./ (sqrt(dx_uk.^2 + dy_uk.^2 + epsilon)), 0, N, N);
  W_sauf_d = spdiags(~D, 0, N, N);
  A = W_sauf_d - lambda * (- Dx' * W * Dx - Dy' * W * Dy);

  u_kp1 = A \ W_sauf_d * b;
end