% Lorenz混沌轨道和非混沌轨道在相空间中占据不同的吸引区域,动态生成图

% 定义参数和初始值范围
sigma = 10;
beta = 8/3;
rho1 = 15;
rho2 = 28;
rho3 = 50;
x_init = {-5:0.5:5, -5:0.5:5, -5:0.5:5};
n = 10000;
t_start = 0;
t_end = 100;
dt = 0.01;
tspan = linspace(t_start, t_end, n);
options = odeset('RelTol', 1e-06, 'AbsTol', [1e-06 1e-06 1e-06], 'OutputFcn', @odeplot);

% 定义Lorenz微分方程
f = @(t, X, rho) [sigma*(X(2)-X(1)); X(1)*(rho-X(3))-X(2); X(1)*X(2)-beta*X(3)];

% 绘制立体图
figure('color', 'white'); hold on;
for i = 1:numel(x_init{1})
    for j = 1:numel(x_init{2})
        for k = 1:numel(x_init{3})
            % 计算轨迹
            [t, xyz] = ode45(@(t, X) f(t, X, rho1), tspan, [x_init{1}(i); x_init{2}(j); x_init{3}(k)], options);
            color = [0.35 0.72 0.53];
            % 判断是否为Lorenz混沌轨道
            if isLorenzChaos(xyz)
                color = [0.94 0.53 0.47];
            end
            plot3(xyz(:, 1), xyz(:, 2), xyz(:, 3), 'color', color,'LineWidth',0.5);
            
            [t, xyz] = ode45(@(t, X) f(t, X, rho2), tspan, [x_init{1}(i); x_init{2}(j); x_init{3}(k)], options);
            color = [0.35 0.72 0.53];
            if isLorenzChaos(xyz)
                color = [0.94 0.53 0.47];
            end
            plot3(xyz(:, 1), xyz(:, 2), xyz(:, 3), 'color', color,'LineWidth',0.5);
            
            [t, xyz] = ode45(@(t, X) f(t, X, rho3), tspan, [x_init{1}(i); x_init{2}(j); x_init{3}(k)], options);
            color = [0.35 0.72 0.53];
            if isLorenzChaos(xyz)
                color = [0.94 0.53 0.47];
            end
            plot3(xyz(:, 1), xyz(:, 2), xyz(:, 3), 'color', color,'LineWidth',0.5);
        end
    end
end

% 设置图形属性
title('Lorenz Chaotic and Non-Chaotic Trajectories in Phase Space', 'fontsize', 16, 'fontweight', 'bold');
xlabel('x', 'fontsize', 14);
ylabel('y', 'fontsize', 14);
zlabel('z', 'fontsize', 14);
grid on;
legend('Non-Chaotic, \rho=15', 'Chaotic, \rho=15', 'Non-Chaotic, \rho=28', 'Chaotic, \rho=28', 'Non-Chaotic, \rho=50', 'Chaotic, \rho=50');
view([20 30]);

% 判断一个轨迹是否为Lorenz混沌轨道
function isChaos = isLorenzChaos(xyz)
    [~,~,lam] = pca(xyz); % 计算主成分分析
    [~, idx] = sort(lam); % 按特征值大小排序
    isChaos = idx(1) ~= 3 || idx(2) ~= 2; % 判断混沌性
end