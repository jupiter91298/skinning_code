function [f_v] = dualquaternion_skinning(v,w,r,t,bone_p)
    % v = set of vertices - n*3 matrix
    % w = weight function(w(i,j) i=vertex and j=bone) - n*m matrix
    % r = rotation for each bone(in quaternion form) - 4*m matrix
    % t = translation for each bone(x,y,z form) - m*3 matrix
    % bone_p = position of the bone - m*3 matrix
    n = size(v,1);             % n = total number of vertices
    m = size(r,2);             % m = total number of bones
    dq = zeros(8,m);           % dq = dual quaternion for each bone 
    f_v = zeros(n,3);          % f_v = final position of each vertices
    disp(n);
    disp(m);
    %%%%%%%%%%%%%           FINDING DUAL QUATERNION FOR EACH BONE
    for i=1:m
        dq(:,i) = find_dual_quaternion(transpose(bone_p(i,:)),transpose(t(i,:)),r(:,i)); 
    end
    %%%%%%%%%%%%%
    
    for i=1:n
        %%%%%%%%%%%%%%%             DUAL QUATERNION BLENDING
        q = zeros(8,1);
        for j=1:m
            q = q + w(i,j)*dq(:,j);
        end
        q = dualnorm(q);       % quaternion normalization 
        %%%%%%%%%%%%%%%
        f_v(i,:) = transpose( quatpoint( q, transpose(v(i,:)) ) );
    end
    
    
    %plot3(f_v(:,1),f_v(:,2),f_v(:,3),'.');
    %axis image;
end