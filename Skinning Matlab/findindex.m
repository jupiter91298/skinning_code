function [x] = findindex(v,p)
    x = 0;
    err = 1000;
    n = size(v,1);
    for i=1:n
        if (dist(transpose(v(i,:)),p)<err)
            err = dist(transpose(v(i,:)),p);
            x = i;
        end
    end
end