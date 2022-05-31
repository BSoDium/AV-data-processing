function [Y, valeurs_tau, valeurs_f] = TFCT(y, f_ech, n_fenetre, n_decalage, fenetre)
  %TFCT - Calcul et affichage de la transformée de Fourier à court terme du signal.
  %
  % Syntax: Y, valeurs_tau, valeurs_f = TFCT(y, f_ech, n_fenetre, n_decalage, fenetre)
  %

  % création de la fenêtre
  if (fenetre == "hann")
    win = hann(n_fenetre);
  elseif (fenetre == "rect")
    win = ones(n_fenetre, 1);
  else
    error("Fenêtre inconnue");
  end

  choppedUpSignal = buffer(y, n_fenetre, n_fenetre - n_decalage, "nodelay");

  % calcul de la transformée de Fourier à court terme
  Y = fft(win .* choppedUpSignal);

  % on ne garde que la partie inférieure de Y
  Y = Y(1:n_fenetre / 2 + 1, :);

  % calcul des valeurs de tau et de f
  valeurs_tau = n_decalage / f_ech * (0:size(Y, 2) - 1);
  step = f_ech / n_fenetre;
  valeurs_f = 0:step:f_ech / 2;
end
