function VC = calcul_VC_bis(D_app, beta_0, beta_d, d, lambda)
  % Calcul de la validation croisee (VC) pour la valeur de d donnee
  %
  % D_app : matrice des donnees d'apprentissage
  % beta_0 : parametre d'indice 0 dans beta_estime, vecteur des paramètres recherché
  % beta_d : parametre d'indice d dans beta_estime, vecteur des paramètres recherché
  % d : degré de la courbe de Bezier
  % lambda : hyperparamètre de la penalisation

  n_app = size(D_app, 2);
  VC = 1 / n_app;
  x = D_app(1, :);
  y = D_app(2, :);
  somme = 0;

  for i = 1:n_app
    x_i = x(i);
    y_i = y(i);
    beta_estime = moindres_carres_ecretes(D_app, beta_0, beta_d, d, lambda);
    y_estime = bezier(beta_0, beta_estime, beta_d, x_i);
    somme = somme + (y_i - y_estime)^2;
  end

  VC = VC * somme;
end
