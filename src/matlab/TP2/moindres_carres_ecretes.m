function beta_estime = moindres_carres_ecretes(D_app, beta_0, beta_d, d, lambda)
  % D_app : matrice de donnees d'apprentissage
  % beta_0 : parametre beta[0]
  % beta_d : parametre beta[d]
  % d : dimension de l'espace de representation
  % lambda : hyper-parametre de regularisation

  n = size(D_app, 2);
  x = D_app(1, :)';
  y = D_app(2, :)';

  % matrice des Betas
  B = y - beta_0 * (1 - x).^d - beta_d * x.^d;

  % matrice des Betas barre
  alphas = (1:d - 1) / d;
  B_b = beta_0 + (beta_d - beta_0) * alphas;

  % matrice A
  A = zeros(n, d - 1);

  for i = 1:d - 1
    A(:, i) = bernstein(d, i, x);
  end

  C = B - A * B_b';

  D = (A' * A + lambda * eye(d - 1)) \ (A' * C);

  beta_estime = D + B_b';
end
