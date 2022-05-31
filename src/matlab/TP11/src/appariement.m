function paires = appariement(pics_t, pics_f)
  %appariement - Formation de paires de pics
  %
  % Syntax: paires = appariement(pics_t, pics_f)
  %
  % Formation de paires de pics spectraux voisins.
  % Retourne un tableau dont chaque ligne, composée du quadruplet
  % (k_i, k_j, m_i, m_j), correspond à une paire.

  % Initialisation
  delta_t = 90;
  delta_f = 90;
  n_neigh = 5;
  paires = [];
  n = length(pics_t);
  % Parcours des pics spectraux de la trame t
  for i = 1:n
    nhood = find(abs(pics_f - pics_f(i)) < delta_f & 0 < (pics_t - pics_t(i)) & (pics_t - pics_t(i)) < delta_t, n_neigh);
    % Parcours des pics spectraux de la trame f
    for j = 1:length(nhood)
      % Ajout de la paire
      neighborindex = nhood(j);
      paires = [paires; pics_f(i), pics_f(neighborindex), pics_t(i), pics_t(neighborindex)];
    end

  end

end
