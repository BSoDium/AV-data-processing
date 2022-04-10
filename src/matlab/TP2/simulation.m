function [x_gauche, x_droite] = simulation(y, beta_0, gamma_0, moyennes, ecarts_types, d)
  % Simulation d'une silhouette de flamme par tirage
  % aléatoire de paramètres [beta_1, ..., beta_d-1, gamma_1, ..., gamma_d]

  leftsum = 0;
  rightsum = 0;

  for i = 1:d
    beta_i = beta_0 + ecarts_types(i) * randn(1);
    gamma_i = gamma_0 + ecarts_types(i) * randn(1);

    if (i == d)
      leftsum = leftsum + gamma_i * bernstein(d, i, y);
    else
      leftsum = leftsum + beta_i * bernstein(d, i, y);
    end

    rightsum = rightsum + gamma_i * bernstein(d, i, y);

  end

  x_gauche = beta_0 * bernstein(d, 0, y) + leftsum;
  x_droite = gamma_0 * bernstein(d, 0, y) + rightsum;

end
