function [d_estime, sigma_estime] = estimation_d_sigma(liste_d, liste_erreurs_generalisation)
  % Calcul d'une estimation du degré d de la courbe de Bézier égale au minimiseur de l'erreur
  % de généralisation, ainsi qu'une estimation sigma de l'écart-type du bruit sur les données.
  %
  % liste_d : liste des degrés d'approximation de la courbe de Bézier
  % liste_erreurs_generalisation : liste des erreurs de généralisation
  %
  % d_estime : estimation du degré d de la courbe de Bézier égale au minimiseur de l'erreur
  % sigma_estime : estimation de l'écart-type du bruit sur les données

  [m, ind] = min(liste_erreurs_generalisation); % indice du minimum de liste_erreurs_generalisation
  d_estime = liste_d(ind) + 1; % + 1 why tho ?
  sigma_estime = sqrt(m);
end
