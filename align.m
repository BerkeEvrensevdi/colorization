function coord = align(ch1,ch2)
min = intmax;
for x = -15:15
    for y = -15:15
        Rs = circshift(ch1,[x,y]);
        T = sum(sum((ch2 - Rs).^2));
        if min > T
            min = T;
            coord = [x,y];
        end
    end
end
