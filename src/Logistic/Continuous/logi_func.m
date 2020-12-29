function [] = logi_func(r,K,N0)
%LOGI_FUNC 连续型Logistic模型
    C = N0/(N0-K);
    t = linspace(0,10,1000);
    Nt = C.*K.*exp(r.*t)./(C.*exp(r.*t)-1);
    plot(t,Nt,'LineWidth',1.5);
end

