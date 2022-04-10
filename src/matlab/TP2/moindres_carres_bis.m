function X_estime = moindres_carres_bis(d, y, left_border, beta_0, right_border, gamma_0)
  % Resolution du systeme lineaire en moindres carres.

  n = length(left_border); % = length(right_border)
  alpha_i = linspace(0, 1, n + 1);
  alpha_i = alpha_i(2:n + 1)';

  E = zeros(2 * n, 2 * d - 1); % "- 1" car beta_d = gamma_d
  F = [left_border; right_border];
  F(1:n, :) = F(1:n) - beta_0 .* ((1 - alpha_i).^d);
  F(n + 1:2 * n) = F(n + 1:2 * n) - gamma_0 .* (1 - alpha_i).^d;

  P_i = [alpha_i; zeros(n, 1)]; % bord gauche]
  Q_i = [zeros(n, 1); alpha_i]; % bord droit

  for i = 1:d - 1
    E(:, i) = bernstein(d, i, P_i);
    E(:, i + d - 1) = bernstein(d, i, Q_i);
  end

  E(:, 2 * d - 1) = P_i.^d + Q_i.^d;

  X_estime = E \ F;
end
