% 使用拓扑混合来生成混沌状态
% 在拓扑混合中，绘制一组状态[x，y]的六次迭代通过逻辑图

clear all;

%% 参数定义
a = 1.1; % 控制参数a
b = 0.3; % 控制参数b
n = 10000; % 迭代次数

x = 0.1; % 初始状态x
y = 0.3; % 初始状态y

x_history = zeros(n, 1); % x值历史记录
y_history = zeros(n, 1); % y值历史记录

%% 迭代
for i = 1:n
    dx = y - a*x^3 + b;
    dy = -x;
    x = x + dx;
    y = y + dy;
    
    x_history(i) = x;
    y_history(i) = y;
end

%% 图形绘制
figure('color', 'black');
set(gca,'color', 'black','XColor','white','YColor','white');
axis([0 1 0 1]);
hold on;

% 绘制混沌散点图
plot(x_history(1:10:end), y_history(1:10:end), '.', 'color', [1,1,1], 'markersize', 0.5); % 散点图

for i = 1:6
    % 随机生成一组颜色值
    c1 = [rand, rand, rand];
    c2 = [rand, rand, rand];
    % 绘制顶点标识
    x_center = mean(x_history(5000+750*(i-1) : 5000+750*i-1));
    y_center = mean(y_history(5000+750*(i-1) : 5000+750*i-1));
    plot(x_center, y_center, '.', 'color', c2, 'markersize', 5);
end

% 添加数轴和标题
xlabel('x', 'color', 'white', 'fontsize', 10);
ylabel('y', 'color', 'white', 'fontsize', 10);
title('Topological Chaos', 'color', 'white', 'fontsize', 18, 'fontweight', 'bold');