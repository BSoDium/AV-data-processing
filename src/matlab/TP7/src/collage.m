function u = collage(r, s, interieur)
  %collage - collage de r et s
  %
  % Syntax: u = collage(r, s,interieur)

  % initialisation et conversion en double
  [nb_lignes, nb_colonnes, nb_canaux] = size(r);
  nb_pixels = nb_lignes * nb_colonnes;
  r = double(r);
  s = double(s);
  r_flat = reshape(r, [nb_pixels nb_canaux]);
  s_flat = reshape(s, [nb_pixels nb_canaux]);
  u = r_flat;

  for i = 1:nb_canaux
    channel_r_flat = r_flat(:, i);
    channel_s_flat = s_flat(:, i);

    % calcul de la matrice A
    e = ones(nb_pixels, 1);
    Dx = spdiags([-e e], [0 nb_lignes], nb_pixels, nb_pixels);
    Dx(end - nb_lignes + 1:end, :) = 0;
    Dy = spdiags([-e e], [0 1], nb_pixels, nb_pixels);
    Dy(nb_lignes:nb_lignes:end, :) = 0;

    A = (- Dx' * Dx - Dy' * Dy);

    % calcul de b
    b = zeros(nb_pixels, 1);
    grad_r = [Dx * channel_r_flat, Dy * channel_r_flat];
    grad_s = [Dx * channel_s_flat, Dy * channel_s_flat];
    g = grad_r;
    g(interieur, :) = grad_s(interieur, :);
    b =- Dx' * g(:, 1) - Dy' * g(:, 2);

    % modification des lignes de la matrice A correspondant aux pixels du bord de r
    A(r_border_indices, :) = sparse(1:n_border_r, r_border_indices, ones(nb_border_pixels, 1), nb_border_pixels, nb_pixels);
    u(:, i) = A \ b;
  end

  u = reshape(u, [nb_lignes nb_colonnes nb_canaux]);
end
