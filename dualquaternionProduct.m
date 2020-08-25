function [x] = dualquaternionProduct(q1,q2)
% q1 and q2 are 8x1 matrix
    x = zeros(8,1);
    x(1:4) = quaternionProduct(q1(1:4),q2(1:4))
    x(5:8) = quaternionProduct(q1(1:4),q2(5:8)) + quaternionProduct(q1(5:8),q2(1:4));
end