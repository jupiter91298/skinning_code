function [x] = quaternionProduct(q1,q2)
    x = zeros(4,1);
    x(1) = q1(1)*q2(1)-dot(q1(2:4),q2(2:4));
    x(2:4) = q1(1)*q2(2:4) + q2(1)*q1(2:4) + cross(q1(2:4),q2(2:4));
    %pq = p0q0 ? p · q + p0q + q0p + p × q.
end