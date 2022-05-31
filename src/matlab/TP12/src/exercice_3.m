clear;
close all;
taille_ecran = get(0, 'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Lecture d'un fichier audio :
[y, f_ech] = audioread('../Musiques/Au clair de la lune.wav');

% Passage au domaine fréquentiel :
n_fenetre = 1024; % Largeur de la fenêtre (en nombre de points)
n_decalage = 512; % Décalage entre deux fenêtres (en nombre de points)
fenetre = 'hann'; % Type de la fenêtre

[Y, valeurs_t, valeurs_f] = TFCT(y, f_ech, n_fenetre, n_decalage, fenetre);
S = 20 * log10(abs(Y) + eps);

% NMF :
% fichiers_notes_piano = dir('../Musiques/Notes/Piano/');
% fichiers_notes_piano = {fichiers_notes_piano(3:end).name};
% fichiers_notes_piano = {'C5.wav','D5.wav','E5.wav'};
fichiers_notes_piano = {'C5.wav', 'Db5.wav', 'D5.wav', 'Eb5.wav', 'E5.wav', 'F5.wav', 'Gb5.wav', 'G5.wav', 'Ab5.wav', 'A5.wav', 'Bb5.wav', 'B5.wav'};
chemins_notes_piano = strcat('../Musiques/Notes/Piano/', fichiers_notes_piano);
D_0 = initialisation_notes(chemins_notes_piano, n_fenetre, n_decalage, fenetre);
A_0 = rand(size(D_0, 2), size(S, 2));
[D, A] = nmf(abs(Y), D_0, A_0, 2);

% Figures :
figure('Name', 'Dictionnaire et activations en sortie du NMF', 'Position', [0.4 * L, 0, 0.6 * L, 0.6 * H]);
subplot(1, 2, 1);
imagesc(1:size(D, 2), valeurs_f, 20 * log10(abs(D)));
set(gca, 'xtick', 1:size(D, 2));
caxis([-40 10]);
axis xy;
xlabel('Composantes', 'Interpreter', 'Latex', 'FontSize', 30);
ylabel('Frequence ($Hz$)', 'Interpreter', 'Latex', 'FontSize', 30);
title('$\mathbf{D}$', 'Interpreter', 'Latex', 'FontSize', 30);

subplot(1, 2, 2);
imagesc(valeurs_t, 1:size(D, 2), A);
set(gca, 'ytick', 1:size(D, 2));
axis xy;
xlabel('Temps ($s$)', 'Interpreter', 'Latex', 'FontSize', 30);
ylabel('Composantes', 'Interpreter', 'Latex', 'FontSize', 30);
title('$\mathbf{A}$', 'Interpreter', 'Latex', 'FontSize', 30);
