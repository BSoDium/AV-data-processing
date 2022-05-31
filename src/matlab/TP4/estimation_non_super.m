function [moyennes, variances] = estimation_non_super(I, N, couleur_classes)
  fprintf('Autosélection des échantillons en cours\n');

  [m, n] = size(I);
  palette_size = 256;
  pts = 0:(palette_size - 1);

  n_trials = 500;
  mu_array = zeros(n_trials, N);
  sigma_array = zeros(n_trials, N);
  scores = zeros(1, n_trials);

  for t = 1:n_trials
    % On tire un mu (entre 0 et palette_size)
    mu = randi([0 (palette_size - 1)], 1, N);
    mu_array(t, :) = mu;

    % On tire un sigma (entre 10 et 25 pour accélérer le calcul)
    sigma = randi([10 25], 1, N);
    sigma_array(t, :) = sigma;

    data = reshape(I, [1, m * n]);
    [f, ~] = ksdensity(data, pts);

    % Construction de A (calcul des pi)
    A = zeros(palette_size, N);

    for i = 1:palette_size

      for j = 1:N
        x = i - 1;
        A(i, j) = (exp(- ((x - mu(j))^2) / (2 * sigma (j)^2))) / sigma(j) * (sqrt(2 * pi));
      end

    end

    % Calcul des pi
    p = transpose(A \ f');

    tentative = sum(p .* exp(- ((pts' - mu).^2) ./ (2 * sigma.^2)) ./ (sigma * sqrt(2 * pi)), 2);
    score = sum((f' - tentative).^2);
    scores(t) = score;
  end

  [~, optimal_index] = min(scores);

  moyennes = mu_array(optimal_index, :);
  variances = sigma_array(optimal_index, :);
end
