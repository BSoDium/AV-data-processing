function probas = probabilites(D_app, parametres_estim, sigma)

  % les constantes suivantes ne sont définies qu'a des fins de lisibilité,
  % elles n'apportent absolument rien sémantiquement à l'algorithme
  pi_1 = 0.5;
  pi_2 = 0.5;
  sigma_1 = sigma;
  sigma_2 = sigma;

  n = size(D_app, 2);
  probas = zeros(2, n);

  parametres_1 = parametres_estim(1, :);
  parametres_2 = parametres_estim(2, :);
  r1 = calcul_r(D_app, parametres_1);
  r2 = calcul_r(D_app, parametres_2);

  p1a = exp(- (r1.^2) / (2 * sigma_1^2)) * pi_1 / (sigma_1 * sqrt(2 * pi));
  p1b = exp(- (r1.^2) / (2 * sigma_2^2)) * pi_2 / (sigma_2 * sqrt(2 * pi));

  p2a = exp(- (r2.^2) / (2 * sigma_1^2)) * pi_1 / (sigma_1 * sqrt(2 * pi));
  p2b = exp(- (r2.^2) / (2 * sigma_2^2)) * pi_2 / (sigma_2 * sqrt(2 * pi));

  probas(1, :) = max(p1a, p1b);
  probas(2, :) = max(p2a, p2b);

end
