clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Paramètres :
n_fenetre = 4096;			% Largeur de la fenêtre (en nombre d'échantillons)
n_decalage = 2048;			% Décalage entre deux fenêtres (en nombre d'échantillons)
fenetre = 'hann';			% Type de la fenêtre

f_min_bruit = 4000;			% Fréquence min du bruit généré
f_max_bruit = 12000;			% Fréquence max du bruit généré
SNR = 10;				% Ratio signal/bruit (élevé => peu bruité)

% Chargement de l'enregistrement :
load enregistrement;
[Y_s, valeurs_tau, valeurs_f] = TFCT(y, f_ech, n_fenetre, n_decalage, fenetre);
S_s = 20 * log10(abs(Y_s) + eps);

% Génération du bruit :
y_b = (2 * rand(length(y), 1) - 1);
[Y_b, valeurs_tau, valeurs_f] = TFCT(y_b, f_ech, n_fenetre, n_decalage, fenetre);
f_min_bruit_ligne = round(f_min_bruit / (f_ech / 2) * size(Y_b, 1));
f_max_bruit_ligne = round(f_max_bruit / (f_ech / 2) * size(Y_b, 1));
Y_b([1:f_min_bruit_ligne-1 f_max_bruit_ligne+1:end], :) = 0;

Y_b = Y_b / SNR;

S_b = 20 * log10(abs(Y_b) + eps);

% Ajout du bruit :
Y_sb = Y_s + Y_b;
S_sb = 20 * log10(abs(Y_sb) + eps);
[y_sb, ~] = ITFCT(Y_sb,f_ech,n_decalage, fenetre);

% À faire :
Y_debruite = debruitage(Y_sb, Y_b);
[y_debruite, ~] = ITFCT(Y_debruite, f_ech, n_decalage, fenetre);

% Affichage du signal et du bruit :
figure('Name','Signal et bruit','Position',[0.4*L,0,0.6*L,0.6*H]);

subplot(2, 2, 1);
imagesc(valeurs_tau,valeurs_f,S_s);
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Signal');

subplot(2, 2, 2);
imagesc(valeurs_tau,valeurs_f,S_b);
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Bruit');

subplot(2, 2, 3);
imagesc(valeurs_tau,valeurs_f,S_sb);
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Signal + Bruit');

subplot(2, 2, 4);
imagesc(valeurs_tau,valeurs_f, 20 * log10(abs(Y_debruite) + eps));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Signal debruite');

drawnow;
