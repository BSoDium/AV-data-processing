function [pics_t, pics_f] = pics_spectraux(S)
  %pics_spectraux - Calcul des pics spectraux
  %
  % Syntax: [pics_t, pics_f] = pics_spectraux(S)
  %
  % Calcul des pics spectraux du sonagramme S

  nhoodsize = 30;
  epsilon = 1;

  % on utilise imdilate pour trouver les pics
  J = imdilate(S, true(nhoodsize, nhoodsize));

  [pics_f, pics_t] = find(J == S & J > epsilon);
end
