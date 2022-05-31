function parametres_MV = max_vraisemblance(D_app, parametres_test)
  % D_app : ensemble d'apprentissage (matrice 2*n)
  % parametres_test : parametres de l'ellipse (matrice np*5)

  n = size(D_app, 2);
  np = size(parametres_test, 1);

  sums = zeros(np, 1);

  for i = 1:np
    parametres = parametres_test(i, :);
    r = calcul_r(D_app, parametres);
    s = sum(r.^2);
    sums(i) = s;
  end

  [~, ind] = min(sums);
  parametres_MV = parametres_test(ind, :);
end
