% Lorenz函数的洛伦兹吸引子

% 2.定义模型参数
sigma = 10; 
beta = 8/3;
rho = 28; 
% 定义一组初始条件和一个时间间隔
x0 = [1, 0, 0.5];
tspan = 0:.01:100;

% 3.解常微分方程,定义一个选项结构来设置ode45的参数
options = odeset('RelTol', 1e-4, 'AbsTol', [1e-4 1e-4 1e-4]);
% ode45函数求解洛伦茨方程
[t, x] = ode45(@(t,x) LorenzFunc(t, x, sigma, rho, beta), tspan, x0, options);

% 4.绘制洛伦兹吸引子
plot3(x(:,1), x(:,2), x(:,3), 'linewidth', 0.5); 
xlabel("x"); ylabel("y"); zlabel("z");
title('洛伦兹吸引子图(Lorenz Attractor)');
grid on

% 1.先定义洛伦兹方程，使用ode45函数来求解常微分方程组。
function dxdt = LorenzFunc(t, x, sigma, rho, beta)
    dxdt = [sigma*(x(2)-x(1));      % dx/dt = sigma*(y-x)
    x(1)*(rho-x(3))-x(2);           % dy/dt = x*(rho-z)-y
    x(1)*x(2) - beta*x(3)];         % dz/dt = xy - betaz
end