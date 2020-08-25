tot_length = 300;
tot_point = 10;
radius = 2;
dis = 0.1;
temp = zeros(3,1);
point_coordinate = zeros(tot_length*tot_point,3);
dis1 = zeros(tot_length*tot_point,3);
dis2 = zeros(tot_length*tot_point,3);
w1 = zeros(tot_length*tot_point);
w2 = zeros(tot_length*tot_point);
t1 = zeros(8,1);
t2 = zeros(8,1);
q1 = zeros(8,1);
temp4 = zeros(8,1);
temp4(1) = 1;
temp4(6) = -(tot_length*dis)/4;
q2 = zeros(8,1);
t1(1) = 1;
t2(1) = 1;
angle1 = 0;
angle2 = 90;
angle1 = (angle1*pi)/180.0;
angle2 = (angle2*pi)/180.0;
q1(1)=cos(angle1/2.0);
q1(2)=sin(angle1/2.0);
q2(1)=cos(angle2/2.0);
q2(2)=sin(angle2/2.0);
q2(6) = 0;
q2 = dualquaternionProduct(q2,temp4);
temp4(6) = -temp4(6);
q2 = dualquaternionProduct(temp4,q2);
%%%%%%%      INITIAL POINTS

for i=1:tot_length
    for j=1:tot_point
        point_coordinate((i-1)*tot_point+j,1)=i*dis;
        point_coordinate((i-1)*tot_point+j,2)=radius*sin(((j-1)*2*pi)/tot_point+(pi/tot_point)*mod(i,2));
        point_coordinate((i-1)*tot_point+j,3)=radius*cos(((j-1)*2*pi)/tot_point+(pi/tot_point)*mod(i,2));
        if(i<=(tot_length/2))
            w1((i-1)*tot_point+j)=1;
            w2((i-1)*tot_point+j)=(((dis)*((tot_length/2)-i))*((dis)*((tot_length/2)-i)))+1;
        else
            w2((i-1)*tot_point+j)=1;
            w1((i-1)*tot_point+j)=(((dis)*(i-(tot_length/2)))*((dis)*(i-(tot_length/2))))+1;
        end
    end
end

%%%%%%%

%%%%%%%      ASSIGN WEIGHTS

for  i=1:tot_length*tot_point
    x = w1(i);
    y = w2(i);
    w1(i) = y/(x+y);
    w2(i) = x/(x+y);
end

%%%%%%%

%%%%%%% LINEAR BLENDING
tempi =zeros(tot_length*tot_point);
for i=1:tot_length*tot_point
    temp(1) = point_coordinate(i,1);
    temp(2) = point_coordinate(i,2);
    temp(3) = point_coordinate(i,3);
    q = zeros(8,1);
    q = (w1(i)*q1) + (w2(i)*q2);
    %q = findd(q);
    tempi(i) = q(1)*q(1) + q(2)*q(2) + q(3)*q(3) + q(4)*q(4);
    q = q/sqrt(tempi(i));
    temp = dual2point(temp,q);
    point_coordinate(i,1) = temp(6);
    point_coordinate(i,2) = temp(7);
    point_coordinate(i,3) = temp(8);
end
%%%%%%%
figure(11);
plot([1:tot_length*tot_point],tempi);
figure(10);
plot3(point_coordinate(:,1),point_coordinate(:,2),point_coordinate(:,3),'.');
xlim([-30 30]);
ylim([-30 30]);
zlim([-30 30]);