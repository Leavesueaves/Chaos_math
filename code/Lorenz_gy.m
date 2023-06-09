% 绘制广义洛伦兹模型
% 从不同的初始条件开始，无量纲时间在0.625到5之间，加热参数r=680

% 广义洛伦兹模型
% r为加热参数，a、b、c分别为三个控制参数
r = 680;
a = 0.25;
b = 4;
c = -8/3;

% 初始条件
x1_0 = 1;
y1_0 = 0;
z1_0 = 0;

x2_0 = 0;
y2_0 = 1;
z2_0 = 0;

% 物理参数
sigma = 10;
beta = 8/3;
rho = 28;

% 时间范围以及时间步长
t_start = 0.625;
t_end = 5;
dt = 0.01;
t = t_start:dt:t_end;

%% 计算广义洛伦兹模型
x1_traj = zeros(length(t), 1);
y1_traj = zeros(length(t), 1);
z1_traj = zeros(length(t), 1);

x2_traj = zeros(length(t), 1);
y2_traj = zeros(length(t), 1);
z2_traj = zeros(length(t), 1);

x1_traj(1) = x1_0;
y1_traj(1) = y1_0;
z1_traj(1) = z1_0;

x2_traj(1) = x2_0;
y2_traj(1) = y2_0;
z2_traj(1) = z2_0;

for i = 2:length(t)
    x1_dot = sigma*(y1_traj(i-1) - x1_traj(i-1));
    y1_dot = x1_traj(i-1)*(rho - z1_traj(i-1)) - y1_traj(i-1);
    z1_dot = x1_traj(i-1)*y1_traj(i-1) - beta*(z1_traj(i-1) - r) + a*(x1_traj(i-1)^2);
    
    x1_traj(i) = x1_traj(i-1) + x1_dot*dt;
    y1_traj(i) = y1_traj(i-1) + y1_dot*dt;
    z1_traj(i) = z1_traj(i-1) + z1_dot*dt;
    
    x2_dot = sigma*(y2_traj(i-1) - x2_traj(i-1));
    y2_dot = x2_traj(i-1)*(rho - z2_traj(i-1)) - y2_traj(i-1);
    z2_dot = x2_traj(i-1)*y2_traj(i-1) - beta*(z2_traj(i-1) - r) + b*(x2_traj(i-1)^2) + c*(x2_traj(i-1))*z2_traj(i-1);
    
    x2_traj(i) = x2_traj(i-1) + x2_dot*dt;
    y2_traj(i) = y2_traj(i-1) + y2_dot*dt;
    z2_traj(i) = z2_traj(i-1) + z2_dot*dt;
end

%% 绘制广义洛伦兹模型图像

% 绘制轨迹
figure();
plot3(x1_traj, y1_traj, z1_traj, 'color', [0.894,0.102,0.110]);
hold on;
plot3(x2_traj, y2_traj, z2_traj, 'color', [0.216,0.494,0.722]);

% 设置图像
title('Generalized Lorenz system', 'fontsize', 16, 'fontweight', 'bold');
xlabel('x', 'fontsize', 14); 
ylabel('y', 'fontsize', 14); 
zlabel('z', 'fontsize', 14);
legend(['x_0 = [', num2str(x1_0), ', ', num2str(y1_0), ', ', num2str(z1_0), ']'], ['x_0 = [', num2str(x2_0), ', ', num2str(y2_0), ', ', num2str(z2_0), ']']);
grid on;