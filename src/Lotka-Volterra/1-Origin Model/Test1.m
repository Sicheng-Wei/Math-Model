%本程序将对应于肖力文所展示的数学模型稳定解的数据测试 
flag=input('请输入您希望观看稳定点2的数据还是稳定点4的数据 [2/4]?');
if(flag==2)
d=10;r=10;
M1=1000; a=0.01;
b=0.005; M2=500;
%满足d>N1*b
mathmode1(r,a,d,b,300,150,M1,M2);
elseif(flag==4)
d=10;r=10;
M1=1000;a=0.01;
b=0.02;M2=500;
%满足d<N1*b
mathmode1(r,a,d,b,300,150,M1,M2);
else
disp('选择错误');
end