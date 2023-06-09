% 绘制混沌系统逻辑分叉图x → r*x(1-x)

r = 0:0.01:4;   % 设置r的范围
n = 1000;       % 迭代次数
initial_x = rand(1); % 随机设置初始状态

for i = 1:n
    initial_x = r.*initial_x.*(1-initial_x);   % 使用迭代公式更新x的值
    if i > 100   % 去掉前面的迭代，只记录后面的数据
        plot(r, initial_x, '.', 'MarkerSize',3)   % 绘制逻辑分叉图
        hold on   % 将多个图形叠加显示
    end
end

xlabel('r')
ylabel('x')
title('混沌系统逻辑分叉图(bifurcation)')
print('fenchatu1.png', '-dpng', '-r300');