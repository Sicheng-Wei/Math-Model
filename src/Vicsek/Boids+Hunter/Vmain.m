%对于一个个体，具有4个参量
%横坐标、纵坐标、运动速度、运动角度
x = 1 + 8 * rand(500,1);
y = 1 + 8 * rand(500,1);
angle = 2 * pi * rand(500,1);
velo = zeros(500,1);
for i = 1:500
    velo(i) = 0.03;
end
regiangle = zeros(500,1);
N = input('迭代次数');
hangle = 0;
for i = 1:N
    xh = 5 + 2 * cos(hangle);
    yh = 5 + 2 * sin(hangle);
    hold on
    quiver(x,y,0.3*cos(angle),0.3*sin(angle),'AutoScale','off');
    quiver(xh,yh,sin(hangle),-cos(hangle),0.89,'LineWidth',1.5,'AutoScale','off');
    hold off
    hangle = hangle - pi / 40;
    [angle,velo] = adjacentZone(x,y,angle,velo,xh,yh);
    %[angle,velo] = visibleZone(x,y,angle,velo,xh,yh,hangle - pi/2);
    x = x + velo .* cos(angle);
    y = y + velo .* sin(angle);
    axis([-1,11,-1,11]);
    axis square
    for j = 1:500
        regiangle(j) = adjustDirection(x,y,angle,j);
    end
    angle = regiangle;
    if i==1
        pause(5);
        clf
    else
        if i ~= N
            pause(0.1);
            clf
        else
            break;
        end
    end
end

function [angle,velo] = adjacentZone(x,y,angle,velo,xh,yh)
    dh = [xh,yh];
    for i = 1:500
        velo(i) = 0.03;
        dt = [x(i),y(i)];
        if norm(dt - dh) < 2
            velo(i) = 0.03 + 0.07 * norm(dt - dh);
            angle(i) = atan2(yh-y(i),xh-x(i)) + pi;
        end
    end
end

function [angle,velo] = visibleZone(x,y,angle,velo,xh,yh,hangle)
    dh = [xh,yh];
    for i = 1:500
         dt = [x(i),y(i)];
         if norm(dt - dh) < 4 && abs(atan2(y(i) - yh,x(i) - xh) - hangle) < pi/6
             vt = 0.05*(pi/6 - abs(atan2(y(i) - yh,x(i) - xh) - hangle));
             tangle = atan2(y(i) - yh,x(i) - xh) - hangle;
             if tangle > 0
                 tangle = tangle + pi/2;
                 v = [velo(i) * cos(angle(i)) + vt * cos(tangle),velo(i) * sin(angle(i)) + vt * sin(tangle)];
                 velo(i) = norm(v);
                 angle(i) = atan2(v(2),v(1));
             else
                 tangle = tangle - pi/2;
                 v = [velo(i) * cos(angle(i)) + vt * cos(tangle),velo(i) * sin(angle(i)) + vt * sin(tangle)];
                 velo(i) = norm(v);
                 angle(i) = atan2(v(2),v(1));
             end
         end
    end
end



