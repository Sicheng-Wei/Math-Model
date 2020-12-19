% Signal Transformer
% author: 韦思成
% company: HUST（华中科技大学）
% date: 2020/12/18

%初始化配置
x = linspace(0,10,1000);
fx = zeros(1000,1);
delta = zeros(1000,1);
regist = zeros(10,1);
x0 = 0; T = 10; bound = 1;sign = 1;

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
        if x0
            delta(bound) = fx(bound)-fun(x0);
        else
            delta(bound) = fx(bound);
        end
        bound = bound + 1;
    end
    x0 = x1;
    regist(sign) = x0;
    sign = sign + 1;
    
    [outer,x1] = searchNearMin(x0,T);
    if outer == 0
        break;
    end
    while x(bound) < x1
        delta(bound) = 0;
        bound = bound + 1;
    end
    x0 = x1;
    regist(sign) = x0;
    sign = sign + 1;
end

for i = bound : 1000
    delta(i) = delta(i) - fun(x0);
end

bound = 1;
hold on
axis([-1,10,-7,9]);
g1 = plot(x,fx,'LineWidth',1.5);
g2 = plot(x,delta,'--','LineWidth',1.5);
line([-1,20],[0,0],'LineWidth',1,'color','k');
line([0,0],[-8,9],'LineWidth',1,'color','k');
for i = 1 : 1000
    if x(i) > regist(bound) && regist(bound)
        line([x(i),x(i)],[fx(i),delta(i)],'LineWidth',1,'linestyle',':','color','k');
        bound = bound + 1;
    end
end
line([0,regist(3)],[fun(regist(2)),fun(regist(3))],'LineWidth',1,'linestyle',':','color','k');
line([0,regist(5)],[fun(regist(4)),fun(regist(5))],'LineWidth',1,'linestyle',':','color','k');
set(gca,'TickLabelInterpreter', 'latex');
set(gca,'XTick',0:5:20);
set(gca,'XTickLabel',{'$0$','$5$','$10$','$15$','$20$'},'FontSize',16);
legend([g1,g2],'$f$','$\delta_{abs}(f)$','Interpreter','latex','Location','northwest');
hold off