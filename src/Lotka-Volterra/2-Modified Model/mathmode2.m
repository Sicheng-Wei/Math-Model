function [] = mathmode2(r,d,a,b,M1,x0,y0)
%mathmode2 ��Ӧ��Ф���ĵ�ģ�Ͷ�
%����һ�鶨ֵr=10,d=0.01,a=5,b=3,N1=1000,x0=300,y0=150
%   �ó���ʵ�ֵ���Ҫ���ܾ������΢�ַ����鲢�������ͼ
RabbitFox=@(t,x)[r*x(1)-r/M1*x(1)^2-a*x(1)*x(2);-d*x(2)+b*x(1)*x(2)];
[t,x]=ode45(RabbitFox,[0,30],[x0,y0]);
disp(t);
subplot(1,2,1);
plot(t,x(:,1),'-',t,x(:,2),'-*');
legend('x1(t)','x2(t)');
xlabel('ʱ��');ylabel('��������');
grid on
subplot(1,2,2);plot(x(:,1),x(:,2),'linewidth',3);
grid on
end

