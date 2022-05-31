clear;
close all;

chemin = '../res/fragments/';
fichiers = dir([chemin '*.wav']);
bdd = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

% Paramètres :
n_fenetre = 512; % Largeur de la fenêtre (en nombre de points)
n_decalage = 256; % Décalage entre deux fenêtres (en nombre de points)
fenetre = 'hann'; % Type de la fenêtre

for id = 1:length(fichiers)

  % Lecture d'un fichier audio :
  disp(fichiers(id).name);
  [y, f_ech] = audioread([chemin fichiers(id).name]);

  % Calcul du sonagramme :
  [Y, valeurs_t, valeurs_f] = TFCT(y, f_ech, n_fenetre, n_decalage, fenetre);
  S = 20 * log10(abs(Y) + eps);

  % Calcul des pics spectraux :
  [pics_t, pics_f] = pics_spectraux(S);

  % Calcul des paires de pics spectraux :
  paires = appariement(pics_t, pics_f);

  % Calcul des identifiants :
  identifiants = indexation(paires);

  % Stockage des identifiants :
  for i = 1:length(identifiants)
    identifiant = identifiants(i);
    entree = [paires(i, 3) id];

    if bdd.isKey(identifiant)
      bdd(identifiant) = [bdd(identifiant); entree];
    else
      bdd(identifiant) = entree;
    end

  end

end

save bdd.mat bdd;
