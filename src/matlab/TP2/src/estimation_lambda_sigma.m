function [lambda_optimal, sigma_estime] = estimation_lambda_sigma(liste_lambda, liste_VC)
  % Estimation de la valeur optimale de lambda (minimisant VC), ainsi
  % que de l'écart-type sigma du bruit sur les données.
  %
  % liste_lambda : liste des valeurs de lambda à tester
  % liste_VC : liste des valeurs de VC

  [m, ind] = min(liste_VC);
  lambda_optimal = liste_lambda(ind);
  sigma_estime = sqrt(m);
end
