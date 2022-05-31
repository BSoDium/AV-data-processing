load exercice_2;

% Restitution du signal à partir de la TFCT reconstituée :
[signal_restitue, ~] = ITFCT(Y_reconstitue,f_ech,n_decalage,fenetre);
sound(signal_restitue,f_ech);
