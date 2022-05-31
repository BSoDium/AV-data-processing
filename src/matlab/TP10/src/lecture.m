clear;

[y, f_ech] = audioread('../res/Audio/mpl.wav');
% [signal,f_ech] = audioread('../res/Audio/message_cache.wav');
if size(y, 2) > 1
  y = mean(y, 2);
end

sound(y, f_ech);

save enregistrement;
