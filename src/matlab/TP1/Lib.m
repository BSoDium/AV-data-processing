classdef (Sealed) Lib

  methods (Static)

    function b = bernstein(x, d, i)
      % bernstein(x, d, i)
      %
      % Compute the Bernstein polynomial of degree d and order i
      % at point x.
      %
      % Inputs:
      %   x:  point at which to evaluate the Bernstein polynomial
      %   d:  degree of the Bernstein polynomial
      %   i:  order of the Bernstein polynomial
      %
      % Outputs:
      %   b:  value of the Bernstein polynomial at x
      %
      % Example:
      %   b = bernstein(0.5, 3, 2)

      b = nchoosek(d, i) * x.^i .* (1 - x).^(d - i);
    end

    function y = bezier(beta_0, beta, beta_d, x)
      % bezier(beta_0, beta, beta_d, x)
      %
      % Compute the Bezier curve defined by the control points
      % [beta_0, beta, beta_d] at point x.
      %
      % Inputs:
      %   beta_0:  first control point
      %   beta:    middle control point array
      %   beta_d:  last control point
      %   x:       point at which to evaluate the Bezier curve
      %
      % Outputs:
      %   y:  value of the Bezier curve at x
      %
      % Example:
      %   y = bezier([0, 0], [[1, 1], [1, 1.5]], [2, 2], 0.5)

      d = length(beta) + 1;
      y = beta_0 * (1 - x).^d + beta_d * x.^d;

      for i = 1:d - 1
        y = y + beta(i) * Lib.bernstein(x, d, i);
      end

    end

    function noised = gNoise(input, sigma)
      % noise(input, sigma)
      %
      % Add Gaussian noise to the input.
      %
      % Inputs:
      %   input:  input signal
      %   sigma:  standard deviation of the noise
      %
      % Outputs:
      %   noised:  input signal with added noise
      %
      % Example:
      %   noised = noise(input, 0.1)

      noised = input + sigma * randn(size(input));
    end

    function error = mean_square_error(input, output)
      % mean_square_error(input, output)
      %
      % Compute the mean square error between the input and output.
      %
      % Inputs:
      %   input:  input signal
      %   output: output signal
      %
      % Outputs:
      %   error:  mean square error
      %
      % Example:
      %   error = mean_square_error(input, output)

      error = mean((input - output).^2);
    end

  end

end
