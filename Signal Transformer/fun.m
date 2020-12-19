function [val] = fun(x)
%fun 原函数（理论原始信号函数）
    val = sqrt(x)*(1 + cos(2*x))*cos(3*x);
end

