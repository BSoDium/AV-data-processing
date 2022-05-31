donnees_apprentissage;

% Degré de la courbe de Bézier utilisée comme modéle (testez plusieurs valeurs de d entre 2 et 20) :
d = 2;

% Estimation des paramétres de la courbe de Bézier (sauf beta_0 et beta_d) :
beta_estime = moindres_carres(D_app, beta_0, beta_d, d);

% Tracé de la courbe de Bézier estimée, de degré d (trait rouge) :
y_estime = Lib.bezier(beta_0, beta_estime, beta_d, x);
plot(x, y_estime, '-r', 'MarkerSize', 10, 'LineWidth', 3);
lg = legend(' Modele exact', ' Donnees d''apprentissage', [' Modele estime ($d=' num2str(d) '$)'], 'Location', 'Best');
set(lg, 'Interpreter', 'Latex');
