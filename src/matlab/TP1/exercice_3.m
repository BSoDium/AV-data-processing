donnees_test;
close all;

% Calcul de l'erreur d'apprentissage (risque empirique) :
liste_d = 2:20;
liste_erreurs_apprentissage = zeros(1, length(liste_d));

for i = 1:length(liste_d)
  d = liste_d(i);
  erreur = erreur_apprentissage(D_app, beta_0, beta_d, d);
  liste_erreurs_apprentissage(i) = erreur;
end

% Tracé de l'erreur d'apprentissage en fonction de d :
figure('Name', 'Erreur d''apprentissage et erreur de generalisation', 'Position', [0.4 * L, 0.05 * H, 0.6 * L, 0.7 * H]);
plot(liste_d, liste_erreurs_apprentissage, 'sb-', 'LineWidth', 2);
set(gca, 'FontSize', 20);
xlabel('$d$', 'Interpreter', 'Latex', 'FontSize', 30);
ylabel('Erreur', 'FontSize', 30);
hold on;

% Calcul de l'erreur de généralisation (risque espéré) :
liste_erreurs_generalisation = zeros(1, length(liste_d));

for i = 1:length(liste_d)
  d = liste_d(i);
  erreur = erreur_generalisation(D_test, D_app, beta_0, beta_d, d);
  liste_erreurs_generalisation(i) = erreur;
end

% Tracé de l'erreur de généralisation en fonction de d :
plot(liste_d, liste_erreurs_generalisation, 'sg-', 'LineWidth', 2);
legend(' Erreur d''apprentissage', ' Erreur de generalisation', 'Location', 'Best');

% Estimation du degré d et de l'écart-type sigma :
[d_estime, sigma_estime] = estimation_d_sigma(liste_d, liste_erreurs_generalisation);
fprintf('Estimation du degre : d = %d\n', d_estime);
fprintf('Estimation de l''ecart-type du bruit sur les donnees : %.3f\n', sigma_estime);
