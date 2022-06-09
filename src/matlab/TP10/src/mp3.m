function [valeurs_max, indices_max, taux_compression] = mp3(Y, m, n)
  %mp3 - Calcule deux matrices indices_max et valeurs_max
  %
  % Syntax: [valeurs_max, indices_max, taux_compression] = mp3(Y, m, n)
  %
  % Long description

  % Initialisation
  valeurs_max = zeros(m, n);

end
 % On calcule les m coefficients de fourier les plus élevés en module
  % pour chaque colonne de Y
  for i = 1:n
    [valeurs_max(:, i), indices_max(:, i)] = max(abs(Y(:, i)));
  end

  % On calcule le taux de compression
  taux_compression = (m * n) / (m * n - sum(sum(valeurs_max)));

end
calcule le taux de compression
  taux_compression = (m * n) / (m * n - sum(sum(valeurs_max)));

end
