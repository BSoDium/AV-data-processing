function erreur = erreur_apprentissage(D_app, beta_0, beta_d, d)
  % Calcul de l'erreur d'apprentissage correspondant à la valeur du degré
  % d passé en paramètre (écart quadratique moyen entre les données
  % d'apprentissage et les prédictions obtenues).
  %
  % D_app : matrice de données d'apprentissage
  % beta_0 : parametre d'indice 0 dans beta_estime, vecteur des paramètres recherché
  % beta_d : parametre d'indice d dans beta_estime, vecteur des paramètres recherché
  % d : degré du modèle
  % erreur : erreur d'apprentissage

  x_appr = D_app(1, :);
  y_appr = D_app(2, :);

  beta_estime = moindres_carres(D_app, beta_0, beta_d, d);
  y_pred = Lib.bezier(beta_0, beta_estime, beta_d, x_appr);

  erreur = Lib.mean_square_error(y_appr, y_pred);
end
