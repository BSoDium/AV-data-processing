function [d_estime, sigma_estime] = estimation_d_sigma_bis(liste_d, liste_VC)
  % Estimation du degré d de la courbe de Bézier égale au minimiseur de VC, ainsi
  % que de l'écart-type sigma du bruit sur les données.
  %
  % liste_d : liste des valeurs de d
  % liste_VC : liste des valeurs de VC

  % [m, ind] = min(liste_VC);
  % d_estime = liste_d(ind);
  % sigma_estime = sqrt(m);

  % pourquoi recopier le meme code quand on peut le faire en une seule ligne ?
  [d_estime, sigma_estime] = estimation_d_sigma(liste_d, liste_VC);
end
