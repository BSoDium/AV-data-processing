clear;
close all;
taille_ecran = get(0, 'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

%  -------the following block requires some modifications-----------------

% Parametres :
T = 1.0;
N = 50; % Nombre de disques d'une configuration
R = 10; % Rayon des disques
q_max = 50;
alpha = 0.99;
beta = 1.0;
lambda = 100;

R_carre = R * R;
nb_points_disque = 30;
increment_angulaire = 2 * pi / nb_points_disque;
theta = 0:increment_angulaire:2 * pi;
rose = [253 108 158] / 255;
q_max = 100000;
nb_valeurs_a_afficher = 10000;
pas_entre_deux_affichages = floor(q_max / nb_valeurs_a_afficher);
temps_affichage = 0.001;

%  -----------------------------------------------------------------------

% Image loading and display :
I = imread('data/colonie.png');
I = rgb2gray(I);
I = double(I);
I = I(100:500, 100:500);
[nb_lignes, nb_colonnes] = size(I);
figure('Name', 'Detection de flamants roses', 'Position', [0.25 * L, 0, 0.75 * L, 0.5 * H]);

subplot(1, 2, 2); % creating the graph
xlabel('x'); % thanks copilot but I'll pass this one
ylabel('y');

% Generating the initial configuration :

for q = 1:q_max
  % Naissance :
  N_tilde = poissrnd(lambda);
  X_nv = zeros(N, 1);
  Y_nv = zeros(N, 1);
  nvg_moyens_disques_nv = zeros(N, 1);

  for k = 1:N_tilde
    abscisse_nouveau = nb_colonnes * rand;
    ordonnee_nouveau = nb_lignes * rand;
    %nvg_moyens_disques_nv(k) = nvg_moyen(abscisse_nouveau,ordonnee_nouveau,R,I);
    X_nv(k) = abscisse_nouveau;
    Y_nv(k) = ordonnee_nouveau;
  end

  X = [X; X_nv];
  Y = [Y; Y_nv];
  N = N +N_tilde;

  % 2.Mort
  % 2.1 Tri des disques :
  Uad = U_AD_tt(N, R, Y, X, I);
  [val, ind] = sort(Uad, 'descend');
  X = X(ind);
  Y = Y(ind);
  % 2.2 Calcul de p(w,w\{D(k)})
  for k = 1:N
    X_ss = X;
    Y_ss = Y;
    X_ss(k) = [];
    Y_ss(k) = [];
    x = X(k);
    y = Y(k);
    produit_temp = Uad - beta * (recouvrement(X_ss, Y_ss, x, y, R)) / T;

    if (rand() > (lambda / (lambda + exp(produit_temp))))
      X = X_ss;
      Y = Y_ss;
    end

  end

  T = alpha * T;
end
