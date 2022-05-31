function filtered_sinogramme = filtrage(sinogramme)
  %filtrage - Description
  %
  % Syntax: filtered_sinogramme = filtrage(sinogramme)
  %
  % Long description

  % fft on each line
  fftlen = size(sinogramme, 2);
  fft_sinogramme = fft(sinogramme, fftlen, 2);
  % apply fft shift
  fft_sinogramme = fftshift(fft_sinogramme, 2);

  % generate filter mask and apply it
  mask = abs(linspace(-1, 1, fftlen));
  fft_sinogramme = fft_sinogramme .* repmat(mask, size(sinogramme, 1), 1);

  % reverse fft shift
  fft_sinogramme = ifftshift(fft_sinogramme, 2);

  % reverse fft
  filtered_sinogramme = real(ifft(fft_sinogramme, fftlen, 2));
end
