function [moyennes, ecarts_types] = estimation_lois_n(X)
  ecarts_types = std(X);
  moyennes = mean(X);
end
