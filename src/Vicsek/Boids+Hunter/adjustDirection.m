function [angle] = adjustDirection(x,y,angle,j)
    dot0 = [x(j),y(j)];
    R = 1.0;
    sinSum = 0; cosSum = 0;
    for i = 1:500
        tpdot = [x(i),y(i)];
        if i == j
            continue;
        end
        if norm(dot0 - tpdot) < R
            sinSum = sinSum + sin(angle(i));
            cosSum = cosSum + cos(angle(i));
        end
    end
    angle = atan2(sinSum,cosSum)+0.2 * rand(1,1);
end
