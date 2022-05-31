clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load exercice_1;

% Paramètre à ajuster :
m = 50;

% Calcul de la TFCT :
[Y, valeurs_tau, valeurs_f] = TFCT(y,f_ech,n_fenetre,n_decalage,fenetre);

% Sélection des m coefficients de Fourier de plus grand module :
[valeurs_max,indices_max,taux_compression] = mp3(Y,m,length(y));
fprintf('Taux de compression : %.1f\n',taux_compression);

% Affichage du sonagramme original, en guise de comparaison :
figure('Name',['Compression audio : ' num2str(taux_compression,'%.1f')],'Position',[0,0,L,0.6*H]);
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
for i = 1:nb_colonnes
	indices_max_i = indices_max(:,i);
	Y_reconstitue(indices_max_i,i) = valeurs_max(:,i);
end

% Affichage de la TFCT reconstituée :
subplot(1,2,2);
imagesc(valeurs_tau,valeurs_f,20*log10(abs(Y_reconstitue) + eps));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Sonagramme de la TFCT reconstitue','FontSize',20);
drawnow;

save exercice_2;
