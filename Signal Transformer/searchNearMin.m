function [hasMin,MinValue] = searchNearMin(infimum,supremum)
%searchNearMin 寻找搜索域内距离原点最近的极小值点
    hasMin = 0;
    MinValue = -1;
    gap = (supremum - infimum) / 1000;
    for i = 1:999
        upper = infimum + gap * (i + 1);
        mider = upper - gap;
        dower = mider - gap;
        if fun(dower) > fun(mider) && fun(mider) < fun(upper)
            hasMin = 1;
            break;
        end
    end
    if hasMin
        [MinValue,] = fminbnd(@(x)fun(x),dower,upper);
    end
end

