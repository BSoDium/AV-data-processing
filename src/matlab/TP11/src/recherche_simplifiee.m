function resultats = recherche_simplifiee(identifiants, bdd)
  %recherche_simplifiee - Recherche dans la base de données
  %
  % Syntax: resultats = recherche_simplifiee(identifiants, bdd)
  %
  % Recherche du morceau musical correspondant aux identifiants
  % la bdd est un containers.Map dont chaque clé est un identifiant

  % Initialisation des variables
  resultats = [];

  % Recherche du morceau
  for i = 1:length(identifiants)

    if isKey(bdd, identifiants(i))
      occurences = bdd(identifiants(i));
      occurences = occurences(:, 2);
      for j = 1:length(occurences)
        resultats = [resultats, occurences(j)];
      end
    end

  end
end

