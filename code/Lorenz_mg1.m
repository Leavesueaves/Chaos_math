% 绘制洛伦兹吸引子（Lorenz attractor）的代码，同时显示出吸引子占据的相空间区域内对初始条件的敏感依赖性

%% 参数设定
sigma = 10;
beta = 8/3;
rho = 28;
dt = 0.005;
max_t = 200;

%% 计算Lorenz attractor
x = 0.1; y = 0.2; z = 0.3;
x_traj = zeros(max_t/dt,1); x_traj(1) = x;
y_traj = zeros(max_t/dt,1); y_traj(1) = y;
z_traj = zeros(max_t/dt,1); z_traj(1) = z;

for i=2:length(x_traj)
    dx_dt = sigma*(y - x);
    dy_dt = x*(rho - z) - y;
    dz_dt = x*y - beta*z;
    x_new = x + dx_dt*dt;
    y_new = y + dy_dt*dt;
    z_new = z + dz_dt*dt;
    x_traj(i) = x_new;
    y_traj(i) = y_new;
    z_traj(i) = z_new;
    x = x_new; y = y_new; z = z_new;
end

%% 绘制Lorenz attractor
figure('color','black');

plot3(x_traj,y_traj,z_traj, 'color', [0.894,0.102,0.110]); hold on;
scatter3(x_traj,y_traj,z_traj,5,'filled', 'MarkerFaceAlpha',0.2,'MarkerEdgeAlpha',0.2);

title('Lorenz attractor', 'color','white');
xlabel('x', 'color','white'); ylabel('y', 'color','white'); zlabel('z', 'color','white');
axis tight;
view([40,20]); xlim([-25,25]); ylim([-35,35]); zlim([5,55]);

%% 绘制敏感依赖性图
figure('color','black');

delta = 1e-8;
x_traj_perturbed = x_traj+delta*randn(length(x_traj),1);
y_traj_perturbed = y_traj+delta*randn(length(y_traj),1);
z_traj_perturbed = z_traj+delta*randn(length(z_traj),1);

plot3(x_traj,y_traj,z_traj, 'color', [0.894,0.102,0.110]); hold on;
scatter3(x_traj,y_traj,z_traj,5,'filled', 'MarkerFaceAlpha',0.2,'MarkerEdgeAlpha',0.2);
plot3(x_traj_perturbed,y_traj_perturbed,z_traj_perturbed, 'color', [0.980,0.745,0.412]);

title('Sensitive Dependence on Initial Conditions', 'color','white');
xlabel('x', 'color','white'); ylabel('y', 'color','white'); zlabel('z', 'color','white');
axis tight;
view([40,20]); xlim([-25,25]); ylim([-35,35]); zlim([5,55]);