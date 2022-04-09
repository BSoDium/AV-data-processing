donnees;
drawnow;

% Trac� des donn�es d'apprentissage (croix bleues) :
figure('Name','Estimation par le maximum de vraisemblance','Position',[0.33*L,0,0.33*L,0.5*H]);
plot(D_app(1,:),D_app(2,:),'+b','MarkerSize',10,'LineWidth',2);
set(gca,'FontSize',20);
xlabel('$x$','Interpreter','Latex','FontSize',30);
ylabel('$y$','Interpreter','Latex','FontSize',30);
axis([-taille taille -taille taille]);
axis equal;
hold on;

% Tirages al�atoires de param�tres pour l'ellipse :
nb_tirages = 10000;
parametres_test = zeros(nb_tirages,5);
parametres_test(:,1) = 2*taille/5*(rand(nb_tirages,1)+1);		% Demi-grand axe
parametres_test(:,2) = rand(nb_tirages,1);				% Excentricit�
parametres_test(:,3) = (3*taille/5)*(2*rand(nb_tirages,1)-1);		% Abscisse du centre
parametres_test(:,4) = (3*taille/5)*(2*rand(nb_tirages,1)-1);		% Ordonn�e du centre
parametres_test(:,5) = 2*pi*rand(nb_tirages,1);				% Angle du grand axe

% Estimation de l'ellipse par le maximum de vraisemblance :
parametres_MV = max_vraisemblance(D_app,parametres_test);

% Trac� de l'ellipse estim�e par le maximum de vraisemblance (trait rouge) :
[x_MV,y_MV] = points_ellipse(parametres_MV,theta_affichage);
plot([x_MV x_MV(1)],[y_MV y_MV(1)],'r-','LineWidth',3);
legend(' Donnees d''apprentissage',' Ellipse estimee par MV','Location','Best');

% Calcul et affichage du score :
score_MV = calcul_score(parametres_VT,parametres_MV);
fprintf('Score de l''estimation par MV : %.3f\n',score_MV);
