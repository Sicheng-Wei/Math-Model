function [] = mathmode2(r,d,a,b,M1,x0,y0)
%mathmode2 对应于肖力文的模型二
%给出一组定值r=10,d=0.01,a=5,b=3,N1=1000,x0=300,y0=150
%   该程序实现的主要功能就是求解微分方程组并绘制相轨图
RabbitFox=@(t,x)[r*x(1)-r/M1*x(1)^2-a*x(1)*x(2);-d*x(2)+b*x(1)*x(2)];
[t,x]=ode45(RabbitFox,[0,30],[x0,y0]);
disp(t);
subplot(1,2,1);
plot(t,x(:,1),'-',t,x(:,2),'-*');
legend('x1(t)','x2(t)');
xlabel('时间');ylabel('物种数量');
grid on
subplot(1,2,2);plot(x(:,1),x(:,2),'linewidth',3);
grid on
end

