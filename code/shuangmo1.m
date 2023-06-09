% 参数定义
L1 = 1;     % 第一根摆长
L2 = 0.5;   % 第二根摆长
m1 = 1;     % 第一根摆质量
m2 = 0.5;   % 第二根摆质量
g = 9.81;   % 重力加速度

% 初始状态定义
theta1 = pi/6;  % 第一根摆角度
theta2 = 0;     % 第二根摆角度
dtheta1 = 0;    % 第一根摆角速度
dtheta2 = 0;    % 第二根摆角速度

% 动画绘制
tspan = [0 30]; % 时间跨度
y0 = [theta1 dtheta1 theta2 dtheta2]; % 初始状态向量
[t, y] = ode45(@(t,y) pendulum2(t, y, L1, L2, m1, m2, g), tspan, y0); % 解微分方程

x1 = L1*sin(y(:,1)); % 第一根摆x坐标
y1 = -L1*cos(y(:,1)); % 第一根摆y坐标
x2 = L1*sin(y(:,1)) + L2*sin(y(:,3)); % 第二根摆x坐标
y2 = -L1*cos(y(:,1)) - L2*cos(y(:,3)); % 第二根摆y坐标

set(gcf, 'renderer', 'painters');
axis equal; % x、y轴比例相等
axis([-1.5*(L1+L2) 1.5*(L1+L2) -1.5*(L1+L2) 1.5]); % 设置坐标轴范围
hold on;

x1_trace = zeros(length(t), 1); % 第一个摆的摆顶端x坐标
y1_trace = zeros(length(t), 1); % 第一个摆的摆顶端y坐标
x2_trace = zeros(length(t), 1); % 第二个摆的摆顶端x坐标
y2_trace = zeros(length(t), 1); % 第二个摆的摆顶端y坐标

% 绘制双摆动画，同时画出摆顶端轨迹连线
for k = 1:length(t)-1
    plot([0 x1(k) x2(k)], [0 y1(k) y2(k)], 'linewidth', 0.5); % 绘制双摆图形
    plot(x2(1:k), y2(1:k), '.', 'color', [0.8 0.05 0.1], 'markersize', 10); % 绘制尾迹
    x1_trace(k+1) = L1*sin(y(k+1,1));
    y1_trace(k+1) = -L1*cos(y(k+1,1));
    x2_trace(k+1) = x1_trace(k+1) + L2*sin(y(k+1,3));
    y2_trace(k+1) = y1_trace(k+1) - L2*cos(y(k+1,3));
    plot([x1_trace(k) x1_trace(k+1)], [y1_trace(k) y1_trace(k+1)], 'linewidth', 1, 'color', 'blue'); % 第一个摆的轨迹线
    plot([x2_trace(k) x2_trace(k+1)], [y2_trace(k) y2_trace(k+1)], 'linewidth', 1, 'color', 'green'); % 第二个摆的轨迹线
    drawnow; % 实时显示
end

% 微分方程定义
function dydt = pendulum2(t, y, L1, L2, m1, m2, g)
    dydt = zeros(4,1);

    % 向量拆分为各个分量
    theta1 = y(1);
    dtheta1 = y(2);
    theta2 = y(3);
    dtheta2 = y(4);

    % 运动方程
    % 第一个摆的力
    F1 = -m1*L1*dtheta1^2*sin(theta1) - m1*g*cos(theta1)*sin(theta1);
    % 第二个摆的力
    F2 = -m2*(L1*dtheta1^2*sin(theta1) + L2*dtheta2^2*sin(theta2)) - m2*g*cos(theta2)*sin(theta2);
    % 坐标加速度
    d2theta1 = (F1 + m1*g*sin(theta1)*cos(theta1) + F2*cos(theta1-theta2))/(m1*L1^2 + m2*L1^2 - m2*L1*L2*cos(theta1-theta2));
    d2theta2 = (F2*cos(theta1-theta2) + (m1+m2)*g*sin(theta1) + L1*dtheta1^2*sin(theta1)*cos(theta1-theta2) - (m1+m2)*L2*dtheta2^2*sin(theta1-theta2))/(L2^2*m2 + (m1+m2)*L1^2 - 2*L1*L2*m2*cos(theta1-theta2));

    dydt(1) = dtheta1; % 第一个摆角速度
    dydt(2) = d2theta1; % 第一个摆角加速度
    dydt(3) = dtheta2; % 第二个摆角速度
    dydt(4) = d2theta2; % 第二个摆角加速度
end