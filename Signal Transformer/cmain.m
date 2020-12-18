% Signal Transformer
% author: 韦思成
% company: HUST（华中科技大学）
% date: 2020/12/18

%初始化配置
x = linspace(0,20,1000);
fx = zeros(1000,1);
delta = zeros(1000,1);
x0 = 0; T = 20; bound = 1;

for i = 1:1000
    fx(i) = fun(x(i));
    delta(i) = fun(x(i));
end

%信号转换中心
while 1
    [outer,x1] = searchNearZero(x0,T,fun(x0));
    if outer == 0
        break;
    end
    while x(bound) < x1
        delta(bound) = fx(bound)-fun(x0);
        bound = bound + 1;
    end
    x0 = x1;
    
    [outer,x1] = searchNearMin(x0,T);
    if outer == 0
        break;
    end
    while x(bound) < x1
        delta(bound) = 0;
        bound = bound + 1;
    end
    x0 = x1;
end

for i = bound : 1000
    delta(i) = delta(i) - fun(x0);
end

hold on
plot(x,fx);
plot(x,delta);
hold off