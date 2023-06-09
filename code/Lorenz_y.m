% 洛伦兹方程用于生成y变量的图。x和z的初始条件保持不变，但y的初始条件在1.001、1.0001和1.00001之间变化

% 定义洛伦兹方程
sigma = 16;
beta = 4;
rho = 45.92;
f = @(t,y) [sigma*(y(2)-y(1)); y(1)*(rho-y(3))-y(2); y(1)*y(2)-beta*y(3)];

% 设置初始条件
y0 = [1.001, 0, 1]; % y 初始值为 1.001
[t1,y1] = ode45(f, [0, 50], y0);

y0 = [1.0001, 0, 1]; % y 初始值为 1.0001
[t2,y2] = ode45(f, [0, 50], y0);

y0 = [1.00001, 0, 1]; % y 初始值为 1.00001
[t3,y3] = ode45(f, [0, 50], y0);

% 绘制图形
plot3(y1(:,1),y1(:,2),y1(:,3),'linewidth',2,'color','b'); 
hold on
plot3(y2(:,1),y2(:,2),y2(:,3),'linewidth',1,'color','k'); 
plot3(y3(:,1),y3(:,2),y3(:,3),'linewidth',1,'color','r'); 
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Lorenz attractor with different initial y values');
legend('y0 = 1.001', 'y0 = 1.0001', 'y0 = 1.00001')
grid on;