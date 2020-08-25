function [x] = translation_dual_quaternion(t)
    x = zeros(8,1);
    x(1,1) = 1;
    x(6:8,1) = t/2;
end