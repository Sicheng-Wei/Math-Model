V_integrate(1000,1000,1,0.03,0,0.2);

function [] = V_integrate(T,N,R,v0,tinf,tsup)
%V-INTEGRATE 集成函数
%参数说明：
%N - 集群数目；R - 鱼群个体影响半径；v0 - 基础速度；tinf,tsup - 噪声范围
    %% 各参数初始化
    x = 1 + 8 * rand(N,1);
    y = 1 + 8 * rand(N,1);
    angle = 2 * pi * rand(N,1);
    velo = zeros(N,1);
    for i = 1:N
        velo(i) = v0;
    end
    
    %% 操作函数集
    for i = 1:T
        Vplot(x,y,angle,i);
        [x,y,angle,velo] = Basic_Vicsek(N,R,tinf,tsup,x,y,angle,velo);
        clf
    end
    
    
end

%% 绘图
function[] = Vplot(x,y,angle,times)
    quiver(x,y,0.2 * cos(angle),0.2 * sin(angle),'AutoScale','off');
    axis([-1,11,-1,11]);
    axis square
    title(['Times = ',num2str(times)]);
    pause(0.03);
end

%% Vicsek基础模型
function [x,y,angle,velo] = Basic_Vicsek(N,R,tinf,tsup,x,y,angle,velo)
    x = x + velo .* cos(angle);
    y = y + velo .* sin(angle);
    regangle = angle;
    for i = 1:N
        unit = sqrt((x - x(i)).^2 + (y - y(i)).^2);
        index = unit <= R^2;
        sumCos = sum(cos(regangle(index)));
        sumSin = sum(sin(regangle(index)));
        angle(i) = atan2(sumSin,sumCos) + (tsup - tinf) * rand(1,1) - tinf;
    end
end

