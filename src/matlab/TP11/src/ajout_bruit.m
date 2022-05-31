function y = ajout_bruit(y,y_bruit,SNR)

E_y = sum(y.^2);
E_bruit = sum(y_bruit.^2);
rapport = sqrt(E_y/(E_bruit*SNR));
y = y+rapport*y_bruit;
y = y/max(y(:));
