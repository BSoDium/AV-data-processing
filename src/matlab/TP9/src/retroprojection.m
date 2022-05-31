function f = retroprojection(sinogramme, theta, nb_rayons, nb_lignes, nb_colonnes)
  %retroprojection - résolution de la tomographie par retroprojection
  %
  % Syntax: f = retroprojection(sinogramme, theta, nb_rayons, nb_lignes, nb_colonnes)
  %
  % Une manière de retrouver une image f(x, y) à partir d'un sinogramme consiste à "déprojeter" les données

  f = zeros(nb_lignes, nb_colonnes);
  n_theta = length(theta);

  for k = 1:n_theta

    for i = 1:nb_lignes

      y = -i + nb_lignes / 2;

      for j = 1:nb_colonnes

        x = j - nb_colonnes / 2;
        thet = deg2rad(theta(k));
        t = round(x * cos(thet) + y * sin(thet)) + ceil(nb_rayons / 2);

        f(i, j) = f(i, j) + sinogramme(t, k);
      end

    end

  end

  f = f / n_theta;

end
