function [] = logi_fund(r,K,N0,T)
%LOGI_FUND ¿Î…¢–ÕLogisticƒ£–Õ
    t = 0:T:10;
    i = 2;
    while t(i) < 10
        plot(t(i-1),N0,'ko');
        N1 = N0+r*K*(1-N0/K);
        line([t(i-1),t(i)],[N0,N1]);
        N0 = N1;
        i = i + 1;
    end
end

