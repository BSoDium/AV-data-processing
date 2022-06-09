clear;
close all;

load verif_TFCT;

f_ech = 10;
y = (1:8);
n_fenetre = 4;
n_decalage = 3;
fenetre = 'hann';

[Y,valeurs_t,valeurs_f] = TFCT(y, f_ech, n_fenetre, n_decalage, fenetre);

if size(Y,1)~=(n_fenetre/2+1)
	disp('Le nombre de lignes n''est pas bon : avez-vous supprime les frequences negatives ?');
end

if size(Y,2)~=ceil((length(y)-n_fenetre)/n_decalage)+1
	disp('Le nombre de colonnes n''est pas bon : verifiez l''appel a la fonction buffer !');
end

if ~isequal(Y,cell2mat(test_1(1)))
	disp('La matrice TFCT n''est pas correte : le fenetrage a-t-il ete effectue correctement ?')
end

if ~isequal(valeurs_f,cell2mat(test_1(2)))
	disp('Les valeurs de f ne sont pas correctes : vont-elles bien de 0 Hz a f_ech/2 Hz ?')
end

if ~isequal(valeurs_t,cell2mat(test_1(3)))
	disp('Les valeurs de tau ne sont pas correctes : quand le segment analyse debute-t-il dans la k-ieme colonne de la TFCT ?')
end
