clear;
close all;
taille_ecran = get(0, 'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

chemin = '../res/fragments/';
fichiers = dir([chemin '*.wav']);

% Chargement de la base de données :
load bdd;

% Lecture d'un fichier audio tiré aléatoirement :
numero_morceau = randi(length(fichiers));
[y, f_ech] = audioread([chemin fichiers(numero_morceau).name]);

% Extrait de durée variable, tiré aléatoirement :
duree_extrait = 15; % Durée de l'extrait en secondes
debut_extrait = randi(length(y) - f_ech * duree_extrait + 1);
y = y(debut_extrait:debut_extrait + f_ech * duree_extrait - 1);

% Création d'un bruit (blanc ou de parole) :
y_bruit_blanc = randn(size(y));
y_bruit_parole = audioread('../res/talking.wav');
debut_y_bruit_parole = randi(length(y_bruit_parole) - length(y) + 1);
y_bruit_parole = y_bruit_parole(debut_y_bruit_parole:debut_y_bruit_parole + length(y) - 1);

% Ajout du bruit (blanc et/ou de parole) :
SNR = 10; % Rapport signal sur bruit
% y = ajout_bruit(y,y_bruit_blanc,SNR);
% y = ajout_bruit(y,y_bruit_parole,SNR);
sound(y, f_ech);
pause(duree_extrait);

% Paramètres :
n_fenetre = 512; % Largeur de la fenêtre (en nombre de points)
n_decalage = 256; % Décalage entre deux fenêtres (en nombre de points)
fenetre = 'hann'; % Type de la fenêtre

% Calcul du sonagramme :
[Y, valeurs_t, valeurs_f] = TFCT(y, f_ech, n_fenetre, n_decalage, fenetre);
S = 20 * log10(abs(Y) + eps);

% Calcul des pics spectraux :
[pics_t, pics_f] = pics_spectraux(S);

% Calcul des paires de pics spectraux :
paires = appariement(pics_t, pics_f);

% Calcul des identifiants :
identifiants = indexation(paires);

% Récupération des empreintes présentes dans la base de données :
resultats = recherche_simplifiee(identifiants, bdd);

% Recherche du meilleur résultat :
[C, ia, ic] = unique(resultats, 'rows', 'stable');
h = accumarray(ic, 1);
[m, ind] = max(h);
numero_reconnu = C(ind, 1);

if numero_reconnu == numero_morceau
  fprintf('Le morceau "%s" a ete correctement reconnu !\n', fichiers(numero_morceau).name(1:end - 4));
else
  fprintf('Le morceau "%s" n''a pas ete reconnu !\n', fichiers(numero_morceau).name(1:end - 4));
end
