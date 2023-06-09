% 运用双摆模型动画
% 初始角度
theta1 = pi/3;
theta2 = -pi/4;

% 初始速度
w1 = 0;
w2 = 0;

% 物理参数
g = 9.8;  % 重力加速度
l1 = 3;   % 第一根杆长度
l2 = 2;   % 第二根杆长度
m1 = 2;   % 第一个质点质量
m2 = 1;   % 第二个质点质量

% 仿真时间
tmax = 10;
dt = 0.01;
tspan = 0:dt:tmax;

% 初始状态
init = [theta1 w1 theta2 w2];

% 调用ode45求解微分方程
[t,y] = ode45(@(t,y)double_pend(t, y, m1, m2, l1, l2, g), tspan, init);

% 动画绘制
figure('Name', '双摆动画');
for i = 1:length(t)
    x1 = l1*sin(y(i, 1));
    y1 = -l1*cos(y(i, 1));
    x2 = x1+l2*sin(y(i, 3));
    y2 = y1-l2*cos(y(i, 3));
    plot([0;x1;x2], [0;y1;y2], '-o', 'LineWidth', 2);
    axis([-3 3 -3 1]);
    title(sprintf('双摆动画, t = %.2f', t(i)));
    grid on;
    drawnow;
end


% 使用 animatedline 函数来动态绘制出双摆的运动轨迹
% 要调用这个double_pend函数，需要传入若干个参数(见上)，包括时间 T，摆的位置 Theta1 与 Theta2，摆杆长度 L1 和 L2，以及每个时间步长的间隔时间 interval
function dydt = double_pend(t, y, m1, m2, l1, l2, g)
    theta1 = y(1);
    w1 = y(2);
    theta2 = y(3);
    w2 = y(4);

    dtheta1dt = w1;
    dw1dt = (m2*g*sin(theta2)*cos(theta1-theta2)-m2*l1*w1^2*sin(theta1-theta2)-...
        m2*l2*w2^2*sin(theta1-theta2)-(m1+m2)*g*sin(theta1))/((m1+m2)*l1-m2*l1*cos(theta1-theta2).^2);
    dtheta2dt = w2;
    dw2dt = ((m1+m2)*(g*sin(theta1)*cos(theta1-theta2)-l1*w1^2*sin(theta1-theta2)...
        -g*sin(theta2))-m2*l2*w2^2*sin(theta1-theta2)*cos(theta1-theta2))/((m1+m2)*l2-m2*l2*cos(theta1-theta2).^2);

    dydt = [dtheta1dt; dw1dt; dtheta2dt; dw2dt];
end