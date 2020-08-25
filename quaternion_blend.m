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
r1 = rotx(0);
t1 = zeros(3,1);
t2 = zeros(3,1);
t1(1) = 0;
t1(2) = 0;
t1(3) = 0;
t2(1) = (tot_length*dis)/2;
t2(2) = 0;
t2(3) = 0;

r2 = roty(90);
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
    nw1 = temp - t1;
    nw2 = temp - t2;
    q1 = r2q(r1);
    q2 = r2q(r2);
    q = w1(i)*q1 + w2(i)*q2;
    q = nor(q);
    r = q2r(q);
    tempi(i)=det(r);
    temp = r*temp;
    point_coordinate(i,1) = temp(1);
    point_coordinate(i,2) = temp(2);
    point_coordinate(i,3) = temp(3);
end
%%%%%%%
figure(1);
plot([1:tot_length*tot_point],tempi);
figure(2);
plot3(point_coordinate(:,1),point_coordinate(:,2),point_coordinate(:,3),'.');
xlim([-30 30]);
ylim([-30 30]);
zlim([-30 30]);