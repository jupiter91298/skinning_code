function [x] = conjugate(q)
    x = zeros(4,1);
    x(1) = q(1);
    for i=2:4
        x(i) = -q(i);
    end
end