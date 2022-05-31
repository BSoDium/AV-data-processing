clear;
close all;

% taille_ecran = get(0, 'ScreenSize');
% L = taille_ecran(3);
% H = taille_ecran(4);
L = 1920;
H = 1080;

% Calcul du modèle exact :
beta_0 = 115;
beta_d = 123;
beta = [133, 96, 139, 118];
n_affichage = 200; % Utilisation de 200 points pour l'affichage
pas_affichage = 1 / (n_affichage - 1);
x = 0:pas_affichage:1;
y = Lib.bezier(beta_0, beta, beta_d, x);

% Tracé du modèle exact (trait noir) :
figure('Name', 'Estimation de parametres', 'Position', [0.4 * L, 0.05 * H, 0.6 * L, 0.7 * H]);
plot(x, y, '-k', 'LineWidth', 2);
set(gca, 'FontSize', 20);
xlabel('$x$', 'Interpreter', 'Latex', 'FontSize', 30);
ylabel('$y$', 'Interpreter', 'Latex', 'FontSize', 30);
hold on;

% Calcul des données d'apprentissage (bruit blanc sur les ordonnées) :
n_app = 50;
pas_app = 1 / (n_app - 1);
x_j = 0:pas_app:1;
sigma = 0.5;
y_j = Lib.gNoise(Lib.bezier(beta_0, beta, beta_d, x_j), sigma);
D_app = [x_j; y_j];

% Calcul des données de test :
n_test = 200;
pas_test = 1 / (n_test - 1);
x_k = 0:pas_test:1;
y_k = Lib.gNoise(Lib.bezier(beta_0, beta, beta_d, x_k), sigma);
D_test = [x_k; y_k];

% Tracé des données de test (croix vertes) :
plot(x_k, y_k, '+g', 'MarkerSize', 10, 'LineWidth', 3);
legend(' Modele exact', ' Donnees de test', 'Location', 'Best');
