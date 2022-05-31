clear;
close all;
taille_ecran = get(0, 'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load enregistrement;

% Calcul de la transformée de Fourier à court terme :
n_fenetre = 4096; % Largeur de la fenêtre (en nombre d'échantillons)
n_decalage = 2048; % Décalage entre positions successives de la fenêtre (en nombre d'échantillons)
fenetre = 'hann'; % Type de la fenêtre : 'rect' ou 'hann'

[Y, valeurs_tau, valeurs_f] = TFCT(y, f_ech, n_fenetre, n_decalage, fenetre);
S = 20 * log10(abs(Y) + eps);

% Affichage du module de la transformée de Fourier à court terme :
figure('Name', 'Transformée de  Fourier à court terme', 'Position', [0.4 * L, 0, 0.6 * L, 0.6 * H]);
imagesc(valeurs_tau, valeurs_f, S);
axis xy;
set(gca, 'FontSize', 20);
xlabel('Temps ($s$)', 'Interpreter', 'Latex', 'FontSize', 30);
ylabel('Frequence ($Hz$)', 'Interpreter', 'Latex', 'FontSize', 30);
drawnow;

save exercice_1;
