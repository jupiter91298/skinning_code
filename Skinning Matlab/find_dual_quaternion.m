function [x] = find_dual_quaternion(p,t,r)
    % p = position of the bone - 3*1 matrix
    % r = rotation quaternion - 4*1 matrix
    % t = translation - 3*1 matrix
    % HERE WE ARE ASSUMING THAT FIRST WE ROTATE IT AROUND BONE AND THAN TRNASLATE 
    x = zeros(8,1);
    temp1 = translation_dual_quaternion(p);
    temp2 = rotation_dual_quaternion(r);
    temp3 = translation_dual_quaternion(-1*p);
    x = dualquaternionProduct(temp1,temp2);
    x = dualquaternionProduct(x,temp3);
    x = dualquaternionProduct(translation_dual_quaternion(t),x);
end