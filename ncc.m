function coord = ncc(ch1,ch2)

val = normxcorr2(ch1,ch2);
[x,y] = find(val == max(val(:)));
coord = [x,y];
