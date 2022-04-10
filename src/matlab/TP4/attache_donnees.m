function AD = attache_donnees(I, moyennes, variances)
  % Retourne une matrice tridimensionnelle contenant pour chaque 
  % pixel de l'image I, la valeur du terme d'attache aux donnees
  % relativement à chacune des N classes.


  N = size(moyennes, 2);
  [n, m] = size(I);

  AD = zeros(n, m, N);
  
  for i = 1:N
    AD(:, :, i) = log(variances(i)) + (I - moyennes(i)).^2 ./ (variances(i));
  end
end 
