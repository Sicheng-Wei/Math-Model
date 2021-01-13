V_integrate(1000,1000,1,0.03,0,0.2);

function [] = V_integrate(T,N,R,v0,tinf,tsup)
%V-INTEGRATE ���ɺ���
%����˵����
%N - ��Ⱥ��Ŀ��R - ��Ⱥ����Ӱ��뾶��v0 - �����ٶȣ�tinf,tsup - ������Χ
    %% ��������ʼ��
    x = 1 + 8 * rand(N,1);
    y = 1 + 8 * rand(N,1);
    angle = 2 * pi * rand(N,1);
    velo = zeros(N,1);
    for i = 1:N
        velo(i) = v0;
    end
    
    %% ����������
    for i = 1:T
        Vplot(x,y,angle,i);
        [x,y,angle,velo] = Basic_Vicsek(N,R,tinf,tsup,x,y,angle,velo);
        clf
    end
    
    
end

%% ��ͼ
function[] = Vplot(x,y,angle,times)
    quiver(x,y,0.2 * cos(angle),0.2 * sin(angle),'AutoScale','off');
    axis([-1,11,-1,11]);
    axis square
    title(['Times = ',num2str(times)]);
    pause(0.03);
end

%% Vicsek����ģ��
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

