clear;
close all;
taille_ecran = get(0, 'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

chemin = '../res/fragments/';
fichiers = dir([chemin '*.wav']);

% Lecture d'un fichier audio :
[y, f_ech] = audioread([chemin fichiers(4).name]);

% Découpage d'un extrait de 15 secondes :
y = y(1:f_ech * 15);

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

% Affichage du spectrogramme et des paires de pics spectraux :
figure('Name', 'Paires de pics spectraux', 'Position', [0.4 * L, 0, 0.6 * L, 0.6 * H]);
imagesc(valeurs_t, valeurs_f, S);
caxis([-40 20]);
hold on;
plot(valeurs_t(pics_t), valeurs_f(pics_f), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'LineWidth', 2);

for i = 1:1:size(paires, 1)
  hold on;
  plot([valeurs_t(paires(i, 3)) valeurs_t(paires(i, 4))], ...
    [valeurs_f(paires(i, 1)) valeurs_f(paires(i, 2))], 'r', 'LineWidth', 2);
end

axis xy;
set(gca, 'FontSize', 20);
xlabel('Temps ($s$)', 'Interpreter', 'Latex', 'FontSize', 30);
ylabel('Frequence ($Hz$)', 'Interpreter', 'Latex', 'FontSize', 30);
drawnow;
