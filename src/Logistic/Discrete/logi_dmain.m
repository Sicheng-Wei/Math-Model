subplot(2,2,1);
axis([0,10,0,200]);
hold on
logi_fund(1.0,100,40,1/2);
title('$r = 1.0$','Interpreter','latex');
xlabel('Time');
ylabel('Population');
hold off

subplot(2,2,2);
axis([0,10,0,200]);
hold on
logi_fund(1.7,100,40,1/2);
title('$r = 1.7$','Interpreter','latex');
xlabel('Time');
ylabel('Population');
hold off

subplot(2,2,3);
axis([0,10,0,200]);
hold on
logi_fund(2.0,100,40,1/2);
title('$r = 2.0$','Interpreter','latex');
xlabel('Time');
ylabel('Population');
hold off

subplot(2,2,4);
hold on
logi_fund(2.2,100,40,1/2);
title('$r = 2.2$','Interpreter','latex');
xlabel('Time');
ylabel('Population');
hold off