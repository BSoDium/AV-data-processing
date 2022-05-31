function erreur = erreur_generalisation(D_test, D_app, beta_0, beta_d, d)
  % Ecart quadratique moyen entre les données de test et les prédictions
  % obtenues a partir du modèle appris f(beta_0, beta, beta_d, x) ou beta est
  % estimé à parti des donnees d'apprentissage.
  %
  % D_test : donnees de test
  % D_app : donnees d'apprentissage
  % beta_0 : parametre d'indice 0 dans beta_estime, vecteur des paramètres recherché
  % beta_d : parametre d'indice d dans beta_estime, vecteur des paramètres recherché
  % d : degré du modèle
  % erreur : erreur de generalisation

  % on isole les données de test
  x_test = D_test(1, :);
  y_test = D_test(2, :);

  % on estime beta_estime
  beta_estime = moindres_carres(D_app, beta_0, beta_d, d);
  y_estime = Lib.bezier(beta_0, beta_estime, beta_d, x_test);

  erreur = Lib.mean_square_error(y_estime, y_test);
end
