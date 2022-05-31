
function calcul_r(D_app, parametres)

  a = parametres[1]
  e = parametres[2]
  x_C = parametres[3]
  y_C = parametres[4]
  theta = parametres[5]
  e_carre = e^2
  b_carre = a^2 * (1 - e_carre)
  R = [cos(theta) -sin(theta); sin(theta) cos(theta)]

  D_app = transpose(R) * (D_app - [x_C; y_C] * ones(1, size(D_app, 2)))
  x = D_app[1, :]
  y = D_app[2, :]
  rho = sqrt(x .^ 2 + y .^ 2)
  cos_angle = cos(atan(y ./ x))
  rho_ellipse = sqrt(b_carre ./ (1 - e_carre * cos_angle .^ 2))
  r = rho - rho_ellipse
end

function calcul_score(parametres_VT, parametres_estim)

  a_VT = parametres_VT[1]
  e_VT = parametres_VT[2]
  c_VT = a_VT * e_VT
  x_C_VT = parametres_VT[3]
  y_C_VT = parametres_VT[4]
  theta_VT = parametres_VT[5]
  cos_VT = cos(theta_VT)
  sin_VT = sin(theta_VT)

  x_F1_VT = x_C_VT + c_VT * cos_VT
  y_F1_VT = y_C_VT + c_VT * sin_VT
  x_F2_VT = x_C_VT - c_VT * cos_VT
  y_F2_VT = y_C_VT - c_VT * sin_VT

  a_estim = parametres_estim[1]
  e_estim = parametres_estim[2]
  c_estim = a_estim * e_estim
  x_C_estim = parametres_estim[3]
  y_C_estim = parametres_estim[4]
  theta_estim = parametres_estim[5]
  cos_estim = cos(theta_estim)
  sin_estim = sin(theta_estim)

  x_F1_estim = x_C_estim + c_estim * cos_estim
  y_F1_estim = y_C_estim + c_estim * sin_estim
  x_F2_estim = x_C_estim - c_estim * cos_estim
  y_F2_estim = y_C_estim - c_estim * sin_estim

  a_max = max(a_VT, a_estim)
  x_min = floor(min([x_F1_VT, x_F2_VT, x_F1_estim, x_F2_estim]) - a_max)
  x_max = ceil(max([x_F1_VT, x_F2_VT, x_F1_estim, x_F2_estim]) + a_max)
  y_min = floor(min([y_F1_VT, y_F2_VT, y_F1_estim, y_F2_estim]) - a_max)
  y_max = ceil(max([y_F1_VT, y_F2_VT, y_F1_estim, y_F2_estim]) + a_max)

  pas_echantillonnage = 0.25
  x_range = x_min:pas_echantillonnage:x_max
  y_range = y_min:pas_echantillonnage:y_max
  [X, Y] = [x_range' .* ones(size(y_range)), ones(size(x_range))' .* y_range]

  d_P_F1_VT = sqrt((X - x_F1_VT) .^ 2 + (Y - y_F1_VT) .^ 2)
  d_P_F2_VT = sqrt((X - x_F2_VT) .^ 2 + (Y - y_F2_VT) .^ 2)

  d_P_F1_estim = sqrt((X - x_F1_estim) .^ 2 + (Y - y_F1_estim) .^ 2)
  d_P_F2_estim = sqrt((X - x_F2_estim) .^ 2 + (Y - y_F2_estim) .^ 2)

  indices_union = find(d_P_F1_VT + d_P_F2_VT < 2 * a_VT | d_P_F1_estim + d_P_F2_estim < 2 * a_estim)
  indices_inter = find(d_P_F1_VT + d_P_F2_VT < 2 * a_VT & d_P_F1_estim + d_P_F2_estim < 2 * a_estim)

  union = length(indices_union(:))
  inter = length(indices_inter(:))

  return inter / union
end


function calcul_score_2(parametres_1_VT, parametres_2_VT, parametres_1_estim, parametres_2_estim)

  score_1_1 = calcul_score(parametres_1_VT, parametres_1_estim)
  score_2_2 = calcul_score(parametres_2_VT, parametres_2_estim)
  score_sans_echange = (score_1_1 + score_2_2) / 2

  score_2_1 = calcul_score(parametres_2_VT, parametres_1_estim)
  score_1_2 = calcul_score(parametres_1_VT, parametres_2_estim)
  score_avec_echange = (score_2_1 + score_1_2) / 2

  return max(score_sans_echange, score_avec_echange)
end
