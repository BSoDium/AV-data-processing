module Data

export basic, upgraded

canvas_size = [630, 540] # size of the canvas

function basic(size::Int64 = 20)
  scale = [-size size -size size]

  # Generating random parameters for the ellipse
  a = 2 * taille / 5 * (rand() + 1) # semi-major axis
  e = 0.9 * rand  # eccentricity
  x_C = (taille - a) * (2 * rand() - 1) # x-coordinate of the center
  y_C = (taille - a) * (2 * rand() - 1) # y-coordinate of the center
  theta = 2 * pi * rand # angle of the major axis
  b = a * sqrt(1 - e^2)
  R = [cos(theta) -sin(theta); sin(theta) cos(theta)]
  VT_parameters = [a, e, x_C, y_C, theta]

  # Drawing the ellipse
  n_display = 100
  theta_display = 2*pi/n_display:2*pi/n_display:2*pi
  P = R * [a * cos(theta_affichage); b * sin(theta_affichage)] + [x_C; y_C] * ones(1, n_affichage)
  x = P(1, :)
  y = P(2, :)

  # TODO: draw
  return 0
end

function upgraded(size::Int64 = 20)
  return 1
end

end