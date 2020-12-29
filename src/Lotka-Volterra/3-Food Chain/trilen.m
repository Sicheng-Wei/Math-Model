function [] = trilen(N1,N2,N3,L12,L21,L23,L32,r1,r2,r3,Ns1,Ns2,Ns3)
%TRILEN 此处显示有关此函数的摘要
Q = 10000;
t = linspace(0,10,Q);
delta = 0.006;
x1 = zeros(Q,1);x2 = zeros(Q,1);x3 = zeros(Q,1);
x1(1) = Ns1;x2(1) = Ns2;x3(1) = Ns3;
for i = 2 : Q
    x1(i) = (r1*x1(i - 1)*(1 - x1(i - 1)/N1) - L12*x1(i - 1)*x2(i - 1)) * delta + x1(i - 1);
    x2(i) = (r2*x2(i - 1)*(- 1 - x2(i - 1)/N2) + L21*x1(i - 1)*x2(i - 1) - L23*x2(i - 1)*x3(i - 1)) * delta + x2(i - 1);
    x3(i) = (r3*x3(i - 1)*(- 1 - x3(i - 1)/N3) + L32*x2(i - 1)*x3(i - 1))* delta + x3(i - 1);
end
hold on
plot(t,x1,'linewidth',1);
plot(t,x2,'linewidth',1);
plot(t,x3,'linewidth',1);
legend('Prey','Mid-Predator','Top-Predator');
xlabel('Time');ylabel('Population');
hold off
grid on
%fprintf("x1 = %f\nx2 = %f\nx3 = %f\n\n",x1(Q),x2(Q),x3(Q));
plot3(x1,x2,x3);
xlabel('x1');ylabel('x2');zlabel('x3');
grid on
end

