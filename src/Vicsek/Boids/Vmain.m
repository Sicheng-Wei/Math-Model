%对于一个个体，具有4个参量
%横坐标、纵坐标、运动速度、运动角度
x = 1 + 8 * rand(500,1);
y = 1 + 8 * rand(500,1);
angle = 2 * pi * rand(500,1);
regiangle = zeros(500,1);
len = 0.03;
N = input('迭代次数');
for i = 1:N
    quiver(x,y,cos(angle),sin(angle),0.6);
    x = x + len .* cos(angle);
    y = y + len .* sin(angle);
    axis([0,10,0,10]);
    axis square
    for j = 1:500
        regiangle(j) = adjustDirection(x,y,angle,j);
    end
    angle = regiangle;
    if i==1
        pause(5);
    else
        pause(0.1);
    end
end



