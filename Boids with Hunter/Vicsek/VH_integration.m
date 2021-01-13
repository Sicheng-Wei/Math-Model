V_integrate(1000,3000,1,0.08,0,0);

function [] = V_integrate(T,N,R,v0,tinf,tsup)
%V-INTEGRATE 集成函数
%参数说明：
%N - 集群数目；R - 鱼群个体影响半径；v0 - 基础速度；tinf,tsup - 噪声范围
    %% 各参数初始化
    x = -10 + 30 * rand(N,1);
    y = -5 + 20 * rand(N,1);
    angle = 2 * pi * rand(N,1);
    velo = zeros(N,1);
    for i = 1:N
        velo(i) = v0;
    end
    
    %% 操作函数集
    for i = 1:T
        hold on
        Vplot(x,y,angle,i);
        [x,y,angle,velo] = Hunter_Threat(x,y,angle,velo,i);
        [x,y,angle,velo] = Basic_Vicsek(N,R,tinf,tsup,x,y,angle,velo);
        %疲倦参数
        indexFast = find(velo > v0);
        velo(indexFast) = velo(indexFast) - 0.02;
        hold off
        clf
    end
end

%% 绘图
function[] = Vplot(x,y,angle,times)
    quiver(x,y,0.3 * cos(angle),0.3 * sin(angle),'AutoScale','off');
    xh = -10 + 0.2 * times; yh = 5;
    quiver(xh,yh,1,0);
    
    %邻接区
    theta = linspace(0,2 * pi,10000);
    C1 = xh + 3 * cos(theta); C2 = yh + 3 * sin(theta);
    plot(C1,C2,'g');
    %视野区
    alpha = linspace(-pi/2,pi/2,1000);
    C3 = xh + 6 * cos(alpha); C4 = yh + 6 * sin(alpha);
    plot(C3,C4,'g');
    
    axis([-10,20,-5,15]);
    axis equal
    title(['Times = ',num2str(times)]);
    pause(0.10);
end

%% Vicsek基础模型
function [x,y,angle,velo] = Basic_Vicsek(N,R,tinf,tsup,x,y,angle,velo)
    x = x + velo .* cos(angle);
    y = y + velo .* sin(angle);
    regangle = angle; regvelo = velo;
    for i = 1:N
        unit = sqrt((x - x(i)).^2 + (y - y(i)).^2);
        index = find(unit <= R^2);
        sumCos = sum(cos(regangle(index)));
        sumSin = sum(sin(regangle(index)));
        velo(i) = sum(regvelo(index)) / length(index);
        angle(i) = atan2(sumSin,sumCos) + (tsup - tinf) * rand(1,1) - tinf;
    end
end

%% Vicsek捕食者项修正
function[x,y,angle,velo] = Hunter_Threat(x,y,angle,velo,times)
    xh = -10 + 0.2 * times; yh = 5; escv = 0.03;
    dangle = atan2(y - yh,x - xh);
    adjacent = sqrt((x - xh).^2 + (y - yh).^2);
    %邻接区修正
    indexAD = find(adjacent <= 3);
    angle(indexAD) = dangle(indexAD);
    velo(indexAD) = (3 - adjacent(indexAD)) * 0.13 + 0.07;
    %视野区修正
    inVSp = find(adjacent <= 6 & dangle < pi / 2 & dangle > 0);
    vxp = velo(inVSp).* cos(angle(inVSp)) + escv * cos(dangle(inVSp)).* cos(dangle(inVSp) + pi / 2);
    vyp = velo(inVSp).* sin(angle(inVSp)) + escv * cos(dangle(inVSp)).* sin(dangle(inVSp) + pi / 2);
    angle(inVSp) = atan2(vyp,vxp); velo(inVSp) = sqrt(vxp.^2 + vyp.^2);
    inVSn = find(adjacent <= 6 & dangle < 0 & dangle >-pi / 2);
    vxn = velo(inVSn).* cos(angle(inVSn)) + escv * cos(dangle(inVSn)).* cos(dangle(inVSn) - pi / 2);
    vyn = velo(inVSn).* sin(angle(inVSn)) + escv * cos(dangle(inVSn)).* sin(dangle(inVSn) - pi / 2);
    angle(inVSn) = atan2(vyn,vxn); velo(inVSn) = sqrt(vxn.^2 + vyn.^2);
end
