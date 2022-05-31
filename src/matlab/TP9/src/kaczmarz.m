function f = kaczmarz(p, W, n_boucles)
  %kaczmarz - Description
  %
  % Syntax: f = kaczmarz(p, W, n_boucles)
  %
  % Long description

  [n_mes, n_pix] = size(W);
  k_max = n_boucles * n_mes;
  f = zeros(n_pix, 1);
  WnormCol = sum(W.^2, 2);
  W_t = W';

  for k = 1:k_max
    i = mod(k - 1, n_mes) + 1;

    if WnormCol(i) ~= 0
      w_i = W_t(:, i)'; % memory access optimization
      f = f + (p(i) - w_i * f) / WnormCol(i) * w_i';
    end

  end

end
