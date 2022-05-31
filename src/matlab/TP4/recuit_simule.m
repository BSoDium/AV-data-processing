function [U, k] = recuit_simule(U, k, AD, T, beta)
  % Algorithme de recuit simule
  % Note: résultat assez décevant (à corriger dans l'idéal
  % avant rédaction du rapport)

  [h, w, N] = size(AD); % height, width, number of classes

  for i = 1:h

    for j = 1:w

      % tirage d'une nouvelle réalisation k_s' dans {1, ..., N} \ {k_s} de la VA k_s
      values = 1:N;
      values = values(values ~= k(i, j));
      k_sp = values(randi(length(values)));

      U_sp = AD(i, j, k_sp) + beta * regularisation(i, j, k, k_sp);
      U_s = U(i, j);

      % comparaison des énergies U_s et U_s'
      if (U_sp < U_s)
        k(i, j) = k_sp;
        U(i, j) = U_sp;
      else
        % Spécificité du recuit simulé : on ne rejette pas systematiquement
        % les changements de configuration qui font croitre l'énergie

        if (rand() < exp(- (U_sp - U_s) / T))
          % on accepte la nouvelle configuration tout de même
          % avec une probabilité exp(- (U_sp - U_s) / T)
          k(i, j) = k_sp;
          U(i, j) = U_sp;
        end

      end

    end

  end

end
