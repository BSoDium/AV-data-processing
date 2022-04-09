function b = bernstein(d, i, x)
  % Returns the value of the d-th degree Bernstein polynomial at x

  b = nchoosek(d, i) * x.^i .* (1 - x).^(d - i);
end
