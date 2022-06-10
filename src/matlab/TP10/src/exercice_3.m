clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load enregistrement;

% Calcul de la transformée de Fourier à court terme :
n_fenetre = 441;		% Largeur de la fenêtre (en nombre d'échantillons)
n_decalage = 441;		% Décalage entre positions successives de la fenêtre (en nombre d'échantillons)
fenetre = 'rect';		% Type de la fenêtre : 'rect' ou 'hann'

% Calcul de la TFCT :
[Y, valeurs_tau, valeurs_f] = TFCT(y,f_ech,n_fenetre,n_fenetre,fenetre);

% Paramètre à ajuster :
m = size(Y,1)*1/2;


subplot(1,2,1);
imagesc(valeurs_tau,valeurs_f,20*log10(abs(Y)));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Sonagramme original','FontSize',20);

% Reconstitution de la TFCT à partir de indices_max et valeurs_max :
nb_colonnes = size(Y,2);
Y_reconstitue = zeros(size(Y));

Y_reconstitue(1:m,:) = Y((m+1):end,:)*1000;

% Affichage de la TFCT reconstituée :
subplot(1,2,2);
imagesc(valeurs_tau,valeurs_f,20*log10(abs(Y_reconstitue) + eps));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Sonagramme de la TFCT reconstitue','FontSize',20);
drawnow;

%saveas(gcf, audio, 'jpg');

% Restitution du signal à partir de la TFCT reconstituée :
[signal_restitue, ~] = ITFCT(Y_reconstitue,f_ech,n_decalage,fenetre);
sound(signal_restitue,f_ech);
