function u = collage(r, s, interieur)
  %collage - collage de r et s
  %
  % Syntax: u = collage(r, s,interieur)

  % initialisation et conversion en double
  [nb_lignes, nb_colonnes, nb_canaux] = size(r);
  nb_pixels = nb_lignes * nb_colonnes;
  r = double(r);
  s = double(s);

  % calcul de la matrice A
  e = ones(nb_pixels, 1);
  Dx = spdiags([-e e], [0 nb_lignes], nb_pixels, nb_pixels);
  Dx(end - nb_lignes + 1:end, :) = 0;
  Dy = spdiags([-e e], [0 1], nb_pixels, nb_pixels);
  Dy(nb_lignes:nb_lignes:end, :) = 0;

  A = (- Dx' * Dx - Dy' * Dy);

  border_r = ones(nb_lignes, nb_colonnes);
  border_r(2:nb_lignes - 1, 2:nb_colonnes - 1) = zeros(nb_lignes - 2, nb_colonnes - 2);
  border_r = find(border_r == 1);
  nb_border_r = length(border_r);

  A(border_r, :) = sparse(1:nb_border_r, border_r, ones(nb_border_r, 1), nb_border_r, nb_pixels);
  u = r;

  for i = 1:nb_canaux
    r_i = r(:, :, i);
    s_i = s(:, :, i);
    u_i = u(:, :, i);

    dx_s_i = Dx * s_i(:);
    dy_s_i = Dy * s_i(:);
    g_i_x = Dx * r_i(:);
    g_i_y = Dy * r_i(:);

    g_i_x(interieur) = dx_s_i(interieur);
    g_i_y(interieur) = dy_s_i(interieur);

    b =- Dx' * g_i_x - Dy' * g_i_y;
    b(border_r) = u_i(border_r);
    u_i = A \ b;
    u(:, :, i) = reshape(u_i, nb_lignes, nb_colonnes);

  end

end
, nb_colonnes_r);

  end

end
nes nb_canaux]);
end
ux]);
end
lat];
    grad_s = [Dx * channel_s_flat, Dy * channel_s_flat];
    g = grad_r;
    g(interieur, :) = grad_s(interieur, :);

    % modification des lignes de la matrice A correspondant aux pixels du bord de r
    u(:, i) = A \ b;
  end

  u = reshape(u, [nb_lignes nb_colonnes nb_canaux]);
end
