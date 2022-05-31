function empreintes = indexation(paires)

f1 = rem(paires(:,1)-1,2^8);
f2 = rem(paires(:,2)-1,2^8);
t21 = rem(paires(:,4)-paires(:,3),2^16);
empreintes = uint32(f1*2^24+f2*2^16+t21);
