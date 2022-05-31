load exercice_1;

duree = length(y) / f_ech;

disp('Reconstruction normale : tapez entree');
pause;

% Restitution du signal à partir de la transformée de Fourier à court terme :
[signal_restitue, ~] = ITFCT(Y,f_ech,n_decalage,fenetre);
sound(signal_restitue,f_ech);
pause(duree)

disp('Apres suppression de la partie imaginaire du spectre : tapez entree');
pause;

% Restitution du signal en n'utilisant que la partie réelle de la TFCT :
[signal_restitue, ~] = ITFCT(real(Y),f_ech,n_decalage,fenetre);
sound(signal_restitue,f_ech);
pause(duree)

disp('Apres suppression de la phase du spectre : tapez entree');
pause;

% Restitution du signal en n'utilisant que le module complexe de la TFCT :
[signal_restitue, ~] = ITFCT(abs(Y),f_ech,n_decalage,fenetre);
sound(signal_restitue,f_ech);
