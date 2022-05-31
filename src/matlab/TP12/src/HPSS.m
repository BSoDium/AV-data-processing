function [F_h, F_p] = HPSS(input)
  %myFun - Description
  %
  % Syntax: [F_h, F_p] = HPSS(input)
  %
  % Long description

  % We're going to use medfilt2 to filter the input signal.

  n1 = 17;
  n2 = 17;

  F_h = medfilt2(input, [1, n1]);
  F_p = medfilt2(input, [n2, 1]);
end
