function [hasZero,ZeroValue] = searchNearZero(infimum,supremum,val)
%searchMinZero 寻找搜索域内距离原点最近的零点
    hasZero = 0;
    ZeroValue = -1;
    gap = (supremum - infimum) / 1000;
    for i = 1:1000
        t = infimum + gap * i;
        tmp = fun(t) - val;
        if fun(t) - val < 0
            hasZero = 1;
            break;
        end
    end

    if hasZero
        if fun(t - gap * 2) - val > 0
            ZeroValue = fzero(@(x)(fun(x)-val), [t - gap * 2,t]);
        else
            hasZero = -1;
        end
    end
end

