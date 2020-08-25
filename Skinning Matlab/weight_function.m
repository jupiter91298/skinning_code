function [w] = weight_function(v,ind1,ind2)
    n = size(v,1);
    w = zeros(n,2);
    offset = 80;
    for i=1:n
        w(i,1)=offset;
        w(i,2)=offset;
    end
    temp1 = dist(transpose(v(ind1,:)),transpose(v(ind2,:)) );
    
    for i=1:n
        temp = dist(transpose(v(i,:)),transpose(v(ind2,:)) );
        if temp<temp1
            temp2 = dist(transpose(v(i,:)),transpose(v(ind1,:)) );
            w(i,1) = temp/(temp+temp2);
            w(i,2) = temp2/(temp+temp2);
        else
            w(i,2) = 0;
        end
    end
    for i=1:n
        x = w(i,1);
        y = w(i,2);
        w(i,1) = x/(x+y);
        w(i,2) = y/(x+y);
    end
end