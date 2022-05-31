classdef (Sealed) Lib

  methods (Static)

    function s = smoothstep(c, gamma, S)
      % SMOOTHSTEP  Smoothstep function
      %
      %   Returns the smoothstep function value at c.

      % default parameters
      if ~exist('gamma', 'var')
        gamma = 5;
      end

      if ~exist('S', 'var')
        S = 130;
      end

      s = 1 - 2 ./ (1 + exp(- gamma * (c ./ S - 1)));
    end

    function b = positional_predicate(new_center, previous_center_array, radius)
      % POSITIONAL_PREDICATE  Initial predicate
      %
      %  Returns true if the new center is far enough from all the
      %  old centers.

      new_center_array = repmat(new_center, size(previous_center_array, 1), 1);
      distance = sqrt(sum((new_center_array - previous_center_array).^2, 2));
      b = sum(distance <= sqrt(2) * radius);
    end

  end

end
