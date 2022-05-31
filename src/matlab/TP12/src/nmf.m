function [D, A] = nmf(input, D_0, A_0, max_iter)
  %nmf - Description
  %
  % Syntax: [D, A] = nmf(input, D_0, A_0, max_iter)
  %
  % Long description

  % Initialize
  A = A_0;
  D = D_0;

  % Iterate
  for i = 1:max_iter
    % Update D
    D_next = D .* (input * A') ./ (D * A * A' + eps);

    % Update A
    A_next = A .* (D' * input) ./ (D' * D * A + eps);

    % Update
    D = D_next;
    A = A_next;
  end

  % Normalize
  D = D ./ repmat(max(D), size(D, 1), 1);
  A = A .* repmat(max(D)', 1, size(A, 2));
end
