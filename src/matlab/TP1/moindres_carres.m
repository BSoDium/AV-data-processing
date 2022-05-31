function beta_estime = moindres_carres(D_app, beta_0, beta_d, d);
  % D_app : matrice de donnees d'apprentissage
  % beta_0 : parametre d'indice 0 dans beta, vecteur des paramètres recherché
  % beta_d : parametre d'indice d dans beta, vecteur des paramètres recherché
  % retourne une solution approchée beta de l'équation A*beta' = b

  dataLen = size(D_app,2);
  x = D_app(1,:)';
  y = D_app(2,:)';
  B = y - beta_0 * (1 - x).^d - beta_d * x.^d;
  A = zeros(dataLen, d - 1);
  for i = 1 : d - 1
    A(:, i) = nchoosek(d, i) * x.^i .* (1 - x).^(d - i);
  end

  beta_estime = A\B;
end