clear;
close all;

chemin = '/mnt/n7fs/ens/tp_jmelou/Shazam/Morceaux/';
fichiers = dir([chemin '*.wav']);

% Chargement de la base de données :
load bdd;

% Paramètres :
duree_extrait = 10;		% Durée des extraits (en secondes)
n_fenetre = 512;		% Largeur de la fenêtre (en nombre de points)
n_decalage = 256;		% Décalage entre deux fenêtres (en nombre de points)
fenetre = 'hann';		% Type de la fenêtre
N_tests = 100;			% Nombre de tests

nb_reconnus = 0;
f = waitbar(0,'Starting');
for i = 1:N_tests

	% Lecture d'un fichier audio tiré aléatoirement :
	numero_morceau = randi(length(fichiers));
	[y,f_ech] = audioread([chemin fichiers(numero_morceau).name]);
	
	% Extrait de durée variable, tiré aléatoirement :
	debut_extrait = randi(length(y)-f_ech*duree_extrait);
	y = y(debut_extrait:debut_extrait+f_ech*duree_extrait-1);

	% Calcul du sonagramme :
	[Y,valeurs_t,valeurs_f] = TFCT(y,f_ech,n_fenetre,n_decalage,fenetre);
	S = 20*log10(abs(Y)+eps);

	% Calcul des pics spectraux :
	[pics_t,pics_f] = pics_spectraux(S);

	% Calcul des paires :
	paires = appariement(pics_t,pics_f);

	% Calcul des identifiants :
	identifiants = indexation(paires);

	% Comparaison des identifiants :
	resultats = recherche_simplifiee(identifiants,bdd);

	if length(resultats)<1
		continue;
	end

	[C,ia,ic] = unique(resultats,'rows','stable');
	h = accumarray(ic,1);
	[m,ind] = max(h);
	numero_reconnu = C(ind,1);

	if numero_reconnu==numero_morceau
		nb_reconnus = nb_reconnus+1;
	end
	waitbar(i/N_tests,f,sprintf('Progress: %d %%',floor(i/N_tests*100)));
end

fprintf('Precision : %4.1f %% \n',nb_reconnus/N_tests*100);
