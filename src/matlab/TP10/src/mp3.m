function [valeurs_max, indices_max, taux_compression] = mp3(Y, m, n)
  %mp3 - Calcule deux matrices indices_max et valeurs_max
  %
  % Syntax: [valeurs_max, indices_max, taux_compression] = mp3(Y, m, n)

  % On trie le signal au préalable
  [valeurs_max, indices_max] = sort(abs(Y), 'descend');
  
  % On sélectionne les m premiers éléments
  indices_max = indices_max(1:m, :);
  valeurs_max = valeurs_max(1:m, :);
  
  taux_compression = 3 * m * size(Y, 2) / n;
end
