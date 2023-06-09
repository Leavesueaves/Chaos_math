% 已知物理参数
L1 = 5;L2 = 3;  %两摆杆长度和质量
m1 = 3;m2 = 5;
g = 9.80665;   % 物理重力加速度m/s^2


% 定义初始参数
% y0的第1参数，即摆1的初始角度；第2，即摆2的初始角度
% 第3，摆1的初始角速度；第4，摆2的初始角速度
theta1_0 = pi/2;
theta2_0 = pi/2;
%警告: 在 t=2.623401e+00 处失败。在时间 t 处，步长必须降至所允许的最小值(7.105427e-15)以下，才能达到积分容差要求。
tspan = [0,0.01,2];
doublePendulum(tspan,theta1_0,theta2_0,L1,L2,m1,m2,g);

function [T, Theta1, Theta2] = doublePendulum(tspan,theta1_0,theta2_0,L1,L2,m1,m2,g)
% 定义求解常微分方程所需的函数
    function dydt = doubleP(t,y)
        % 定义双摆模型方程
        d1 = m1+m2*L1^2/L2^2;
        d2 = m2*L1*L2*cos(y(1)-y(2))/L2^2;
        d3 = m2*L1*L2*sin(y(1)-y(2))*y(4)^2/L2;
        d4 = g/L2*sin(y(2)) + cos(y(1)-y(2))*y(3)^2/L2;
        dydt = [y(3); y(4); (m2*d4*d2-d3*m2*cos(y(1)-y(2)))/(d1-m2*d2*d2); (d1*d4-m2*d3*cos(y(1)-y(2)))/(L2*(d1-m2*d2*d2))];
    end
    % 定义初值和时间步长
    y0 = [theta1_0, theta2_0, 0, 0];
    options = odeset('RelTol',1e-10,'AbsTol',1e-10);

    % 调用ode45求解微分方程组
    [T,Y] = ode45(@doubleP,tspan,y0,options);
    
    % 计算摆的位置
    Theta1 = L1*sin(Y(:,1));
    Theta2 = L2*sin(Y(:,2))+Theta1;
    Theta1 = -L1*cos(Y(:,1));
    Theta2 = -L2*cos(Y(:,2))+Theta2;

    % 绘制双摆摆角随时间变化的图像
    plot(T,Y(:,1:2))
    legend('\theta_1','\theta_2')
    xlabel('时间 t')
    ylabel('摆角 \theta')
    title('双摆摆角随时间变化的图像')
end