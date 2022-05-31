function parametres_MV = max_vraisemblance_2(D_app, parametres_test, sigma)
  % D_app : ensemble d'apprentissage (matrice 2*n)
  % parametres_test : parametres de l'ellipse (matrice np*2*5)

  pi_1 = 0.5;
  pi_2 = 0.5;
  sigma_1 = sigma;
  sigma_2 = sigma;

  np = size(parametres_test, 1);

  sums = zeros(np, 1);

  for i = 1:np
    parametres_1 = parametres_test(i, 1, :);
    parametres_2 = parametres_test(i, 2, :);
    r1 = calcul_r(D_app, parametres_1);
    r2 = calcul_r(D_app, parametres_2);
    ps1 = pi_1 / sigma_1;
    ps2 = pi_2 / sigma_2;
    lr = log(ps1 * exp(-r1.^2 / (2 * sigma_1^2)) + ps2 * exp(-r2.^2 / (2 * sigma_2^2)));
    s = sum(lr);
    sums(i) = s;
  end

  [~, ind] = max(sums);
  parametres_MV = parametres_test(ind, :);
end
