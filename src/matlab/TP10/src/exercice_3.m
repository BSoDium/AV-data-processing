clear;
close all;

load enregistrement;

screen_size = get(0, 'ScreenSize');
L = screen_size(3);
H = screen_size(4);

% Calcul de la TFCT :
n_decalage = 441; % Décalage entre positions successives de la fenêtre (en nombre d'échantillons)
n_fenetre = 441; % Largeur de la fenêtre (nombre d'échantillons)
fenetre = 'rect'; % Type de la fenêtre ('rect'/'hann')

% Calcul de la TFCT :
[Y, valeurs_tau, valeurs_f] = TFCT(y, f_ech, n_fenetre, n_fenetre, fenetre);

% Paramètre à faire varier :
m = size(Y, 1) * 1/2;

% Affichage du sonagramme d'origine :
subplot(1, 2, 1);
imagesc(valeurs_tau, valeurs_f, 20 * log10(abs(Y)));
title("Sonagramme d'origine", 'FontSize', 20);
axis xy;
xlabel('Temps ($s$)', 'Interpreter', 'Latex', 'FontSize', 30);
ylabel('Frequence ($Hz$)', 'Interpreter', 'Latex', 'FontSize', 30);

% Reconstitution de la TFCT :
nb_colonnes = size(Y, 2);
Y_reconstitue = zeros(size(Y));
Y_reconstitue(1:m, :) = Y((m + 1):end, :) * 1000;

% Affichage du sonagramme reconstitué :
subplot(1, 2, 2);
imagesc(valeurs_tau, valeurs_f, 20 * log10(abs(Y_reconstitue) + eps));
title('Sonagramme reconstitué (TFCT)', 'FontSize', 20);
axis xy;
xlabel('Temps ($s$)', 'Interpreter', 'Latex', 'FontSize', 30);
ylabel('Frequence ($Hz$)', 'Interpreter', 'Latex', 'FontSize', 30);
drawnow;

% Restitution du signal :
[signal_restitue, ~] = ITFCT(Y_reconstitue, f_ech, n_decalage, fenetre);
sound(signal_restitue, f_ech);
