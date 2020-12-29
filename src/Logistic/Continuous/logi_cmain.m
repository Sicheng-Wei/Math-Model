subplot(1,2,1);
axis([0,10,0,1500]);
hold on
for i = 1 : 4
    logi_func(1,1000,-300+450*i);
end
legend('$N_0 = 150$','$N_0 = 600$','$N_0 = 1050$','$N_0 = 1500$','Interpreter','latex','Location','northeast');
xlabel('Time');
ylabel('Population');
hold off

subplot(1,2,2);
hold on
axis([0,10,0,1500]);
rval = [0.5,0.7,1.0,1.5];
for i = 1 : 4
    logi_func(rval(i),1000,150);
end
legend('$r = 0.5$','$r = 0.7$','$r = 1.0$','$r = 1.5$','Interpreter','latex','Location','northeast');
xlabel('Time');
ylabel('Population');
hold off