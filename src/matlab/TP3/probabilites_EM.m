function probas = probabilites_EM(D_app, parametres_estim, proportion_1, proportion_2, sigma)
  % Calcul des probabilités d'appartenance aux deux classes des points d'apprentissage
  % P_i dans D_app.

  % les constantes suivantes ne sont définies qu'a des fins de lisibilité,
  % elles n'apportent absolument rien sémantiquement à l'algorithme
  pi_1 = proportion_1;
  pi_2 = proportion_2;
  sigma_1 = sigma;
  sigma_2 = sigma;

  n = size(D_app, 2);
  probas = zeros(2, n);

  parametres_1 = parametres_estim(1, :);
  parametres_2 = parametres_estim(2, :);
  r1 = calcul_r(D_app, parametres_1);
  r2 = calcul_r(D_app, parametres_2);

  den = (pi_1 / sigma_1) * exp(- r1.^2 / (2 * sigma_1^2)) + (pi_2 / sigma_2) * exp(- r2.^2 / (2 * sigma_2^2));

  probas(1, :) = (pi_1 / sigma_1) * exp(- r1.^2 / (2 * sigma_1^2)) ./ den;
  probas(2, :) = (pi_2 / sigma_2) * exp(- r2.^2 / (2 * sigma_2^2)) ./ den;
end
