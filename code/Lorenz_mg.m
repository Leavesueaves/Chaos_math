% Lorenz 方程在不同的 y 初始条件下生成的轨迹

% 采用数组和循环同时绘制多个初始条件谱图
% 存在上一错误时，可清除所有变量，关闭所有图形窗口
% clear all;
% close all;

% 定义 Lorenz 方程的参数和函数句柄
sigma = 10;
beta = 8/3;
rho = 28;
f = @(t, x) [sigma*(x(2)-x(1)); x(1)*(rho-x(3))-x(2); x(1)*x(2)-beta*x(3)];

% 定义颜色和标记样式
colors = ['r', 'b', 'g'];
markers = ['s', 'o', 'd'];

% 定义 y 初始条件
y0 = [1.001, 1.0001, 1.00001];

% 创建新图形窗口
figure;

% 循环遍历 y 初始值
for i = 1:length(y0)
    % 计算洛伦兹方程的解
    [t, y] = ode45(f, [0, 50], [1, 0, y0(i)]);

    % 绘制 Lorenz 吸引子的 y 轨迹
    plot(t, y(:,2), '-', 'linewidth', 0.5, 'color', colors(i));
    hold on;
end

% 添加图例、坐标轴标签和标题
legend('y0 = 1.001', 'y0 = 1.0001', 'y0 = 1.00001');
xlabel('t');
ylabel('y');
title('Lorenz Attractor for Different Initial Conditions (y)');