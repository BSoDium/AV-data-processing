function X = moindres_carres_ponderes(D_app, probas)
  % D_app : ensemble d'apprentissage (matrice 2*n)
  % X : vecteur de parametres (matrice 1*m)

  n = size(D_app, 2);
  np = 6;
  x = D_app(1, :);
  y = D_app(2, :);

  O = [zeros(n, 1); 1];
  X = zeros(np, 1);
  A = zeros(n, np);

  for i = 1:n
    A(i, :) = [x(i)^2, x(i) * y(i), y(i)^2, x(i), y(i), 1] * probas(i);
  end

  A = [A; [1, 0, 1, 0, 0, 0]];

  X = A \ O;
end
