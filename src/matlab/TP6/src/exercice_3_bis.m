%--------------------------------------------------------------------------
% ENSEEIHT - 2SN MM - Traitement des donn�es audio-visuelles
% TP6 - Restauration d'images
% exercice_3_bis : inpainting par rapi��age (domaine D variable)
%--------------------------------------------------------------------------

clear
close all
clc

% Mise en place de la figure pour affichage :
taille_ecran = get(0, 'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name', 'Inpainting par rapiecage', ...
  'Position', [0.06 * L, 0.1 * H, 0.9 * L, 0.75 * H])

% Lecture de l'image :
u0 = double(imread('../Images/randonneur.jpg'));
[nb_lignes, nb_colonnes, nb_canaux] = size(u0);
u_max = max(u0(:));

% Affichage de l'image :
subplot(1, 2, 1)
imagesc(max(0, min(1, u0 / u_max)), [0 1])
axis image off
title('Image originale', 'FontSize', 20)

if nb_canaux == 1
  colormap gray
end

% S�lection et affichage du domaine � restaurer :
disp('Selectionnez un polygone (double-clic pour valider)')
[D, x_D, y_D] = roipoly();

for k = 1:length(x_D) - 1
  line([x_D(k) x_D(k + 1)], [y_D(k) y_D(k + 1)], 'Color', 'b', 'LineWidth', 2);
end

% Affichage de l'image r�sultat :
u_k = u0;

for c = 1:nb_canaux
  u_k(:, :, c) = (~D) .* u_k(:, :, c);
end

subplot(1, 2, 2)
imagesc(max(0, min(1, u_k / u_max)), [0 1])
axis image off
title('Image resultat', 'FontSize', 20)

if nb_canaux == 1
  colormap gray
end

drawnow nocallbacks

% Initialisation de la fronti�re de D :
delta_D = frontiere(D);
indices_delta_D = find(delta_D > 0);
nb_points_delta_D = length(indices_delta_D);

% Param�tres :
t = 9; % Voisinage d'un pixel de taille (2t+1) x (2t+1)
T = 50; % Fen�tre de recherche de taille (2T+1) x (2T+1)

% Tant que la fronti�re de D n'est pas vide :
while nb_points_delta_D > 0

  % Pixel p de la fronti�re de D tir� al�atoirement :
  indice_p = indices_delta_D(randi(nb_points_delta_D));
  [i_p, j_p] = ind2sub(size(D), indice_p);

  % Recherche du pixel q_chapeau :
  [existe_q, bornes_V_p, bornes_V_q_chapeau] = d_min(i_p, j_p, u_k, D, t, T);

  % S'il existe au moins un pixel q �ligible :
  if existe_q

    % Rapi��age et mise � jour de D :
    [u_k, D] = rapiecage(bornes_V_p, bornes_V_q_chapeau, u_k, D);

    % Mise � jour de la fronti�re de D :
    delta_D = frontiere(D);
    indices_delta_D = find(delta_D > 0);
    nb_points_delta_D = length(indices_delta_D);

    % Affichage de l'image r�sultat :
    subplot(1, 2, 2)
    imagesc(max(0, min(1, u_k / u_max)), [0 1])
    axis image off
    title('Image resultat', 'FontSize', 20)

    if nb_canaux == 1
      colormap gray
    end

    drawnow nocallbacks
  end

end
