function resultats = recherche_simplifiee(identifiants, bdd)
  %recherche_simplifiee - Recherche dans la base de données
  %
  % Syntax: resultats = recherche_simplifiee(identifiants, bdd)
  %
  % Recherche du morceau musical correspondant aux identifiants
  % la bdd est un containers.Map dont chaque clé est un identifiant

  % Initialisation des variables
  cited = zeros(1, length(identifiants));

  % Recherche du morceau
  for i = 1:length(identifiants)

    if isKey(bdd, identifiants(i))
      cited(i) = cited(i) + size(bdd(identifiants(i)), 1);
    end

  end

  % On choisit le morceau le plus souvent cité
  [~, indice] = max(cited);
  cited
  resultats = bdd(identifiants(indice));

end
d
