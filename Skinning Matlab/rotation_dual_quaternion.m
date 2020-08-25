function [x] = rotation_dual_quaternion(r)
    x = zeros(8,1);
    x(1:4,1) = r;
end