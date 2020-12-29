function [] = mathmode1(IA1,IA2,IA3,IA4,x0,y0,M1,M2)
%��Ӧ��Ф���Ľ�ģ������ģ��1 IA1=r, IA2=a,IA3=d,IA4=b,x0,y0�ֱ����x,y�ĳ�ֵ

%wffc ���̶���ʽ΢�ַ���
%   �˴���ʾ��ϸ˵��
RabbitFox=@(t,x)[x(1)*IA1*(1-x(1)/M1)-x(1)*IA2*x(2);x(2)*(1+x(2)/M2)*(-IA3)+x(2)*IA4*x(1)];
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

