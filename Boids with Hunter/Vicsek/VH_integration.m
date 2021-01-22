V_integrate(1000,10000,2,0.08,0,0);

function [] = V_integrate(T,N,R,v0,tinf,tsup)
%V-INTEGRATE 集成函数
%参数说明：
%N - 集群数目；R - 鱼群个体影响半径；v0 - 基础速度；tinf,tsup - 噪声范围
    %% 各参数初始化
    BOIDS.x = -50 + 70 * rand(N,1);
    BOIDS.y = -25 + 40 * rand(N,1);
    BOIDS.angle = 2 * pi * rand(N,1);
    BOIDS.velo = zeros(N,1);
    
    HUNTER.x = zeros(1,1);
    HUNTER.y = zeros(1,1);
    HUNTER.angle = zeros(1,1);
    HUNTER.velo = zeros(1,1);
    HUNTER = Hunter_Trace(HUNTER.x);
    
    for i = 1:N
        BOIDS.velo(i) = v0;
    end
    
    %% 操作函数集
    for i = 1:T
        hold on
        Vplot(BOIDS,HUNTER,i);
        HUNTER = Hunter_Trace(i);
        BOIDS = Hunter_Threat(BOIDS,HUNTER);
        BOIDS = Basic_Vicsek(N,R,tinf,tsup,BOIDS);
        %速度回归参数
        indexFast = find(BOIDS.velo > v0);
        BOIDS.velo(indexFast) = BOIDS.velo(indexFast) - 0.03;
        hold off
        clf
    end
end

%% 绘图
function[] = Vplot(BOIDS,HUNTER,times)
    quiver(BOIDS.x,BOIDS.y,0.3 * cos(BOIDS.angle),0.3 * sin(BOIDS.angle),'AutoScale','off');
    quiver(HUNTER.x,HUNTER.y,cos(HUNTER.angle),sin(HUNTER.angle),'AutoScale','off');
    axis([-10,20,-5,15]);
    axis equal
    title(['Times = ',num2str(times)]);
    if times == 1
        pause(5);
    else
        pause(0.01);
    end
end

%% Hunter轨迹
function [HUNTER] = Hunter_Trace(time)
    HUNTER.x = -60 + 0.2 * time;
    HUNTER.y = 5;
    HUNTER.angle = 0;
end

%% Vicsek基础模型
function [BOIDS] = Basic_Vicsek(N,R,tinf,tsup,BOIDS)
    BOIDS.x = BOIDS.x + BOIDS.velo .* cos(BOIDS.angle);
    BOIDS.y = BOIDS.y + BOIDS.velo .* sin(BOIDS.angle);
    regangle = BOIDS.angle; regvelo = BOIDS.velo;
    for i = 1:N
        unit = sqrt((BOIDS.x - BOIDS.x(i)).^2 + (BOIDS.y - BOIDS.y(i)).^2);
        index = find(unit <= R^2);
        sumCos = sum(cos(regangle(index)));
        sumSin = sum(sin(regangle(index)));
        BOIDS.velo(i) = sum(regvelo(index)) / length(index);
        BOIDS.angle(i) = atan2(sumSin,sumCos) + (tsup - tinf) * rand(1,1) - tinf;
    end
end

%% Vicsek捕食者项修正
function[BOIDS] = Hunter_Threat(BOIDS,HUNTER)
    escv = 0.20;
    dangle = atan2(BOIDS.y - HUNTER.y,BOIDS.x - HUNTER.x) - HUNTER.angle;
    adjacent = sqrt((BOIDS.y - HUNTER.y).^2 + (BOIDS.x - HUNTER.x).^2);
    %邻接区修正
    indexAD = find(adjacent <= 3);
    BOIDS.angle(indexAD) = dangle(indexAD);
    BOIDS.velo(indexAD) = (3 - adjacent(indexAD)) * 0.30 + 0.08;
    %视野区修正
    inVSp = find(adjacent <= 8 & dangle < pi / 2 & dangle > 0);
    vxp = BOIDS.velo(inVSp).* cos(BOIDS.angle(inVSp)) + escv * cos(dangle(inVSp)).* cos(dangle(inVSp) + pi / 2);
    vyp = BOIDS.velo(inVSp).* sin(BOIDS.angle(inVSp)) + escv * cos(dangle(inVSp)).* sin(dangle(inVSp) + pi / 2);
    BOIDS.angle(inVSp) = atan2(vyp,vxp); BOIDS.velo(inVSp) = sqrt(vxp.^2 + vyp.^2);
    inVSn = find(adjacent <= 8 & dangle < 0 & dangle >-pi / 2);
    vxn = BOIDS.velo(inVSn).* cos(BOIDS.angle(inVSn)) + escv * cos(dangle(inVSn)).* cos(dangle(inVSn) - pi / 2);
    vyn = BOIDS.velo(inVSn).* sin(BOIDS.angle(inVSn)) + escv * cos(dangle(inVSn)).* sin(dangle(inVSn) - pi / 2);
    BOIDS.angle(inVSn) = atan2(vyn,vxn); BOIDS.velo(inVSn) = sqrt(vxn.^2 + vyn.^2);
end
