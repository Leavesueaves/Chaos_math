function blackhole(xc, yc, zc, r, theta_res, phi_res)
% 绘制黑洞模型

% 设置参数
rs = r / 15;
s = rs / 2;
max_iter = 50;
min_distance = 0.02;

% 创建网格
[theta, phi] = meshgrid(linspace(0, 2*pi, theta_res), linspace(0, pi, phi_res));

% 将网格转换为笛卡尔空间坐标
x = (r + rs * cos(theta)) .* sin(phi);
y = (r + rs * cos(theta)) .* cos(phi);
z = rs * sin(theta);

% 计算每个网格点到最近的点的距离，并判断是否在恶魔星（黑洞）内
h = sqrt(x.^2 + y.^2 + z.^2);
for i = 1:max_iter
    dx = -s * sign(x);
    dy = -s * sign(y);
    dz = -2 * s * z /r;
    x = x + dx;
    y = y + dy;
    z = z + dz;
    h_new = sqrt(x.^2 + y.^2 + z.^2);
    if(max(max(abs(h-h_new))) < min_distance)
        break;
    end
    h = h_new;
end

% 可视化
figure;
v = isosurface(xc+x, yc+y, zc+z, h, 0);
patch(v,'FaceColor',[253/255,234/255,161/255],'EdgeColor','none');
set(gca,'Color',[0 0 0],'XColor','none','YColor','none','ZColor','none');
axis equal;
axis vis3d;
view(40, 20);
light('Position', [0 0 1]);
light('Position', [1 1 0]);
light('Position', [-1 -1 0]);
colormap(copper);
camlight('headlight');
end

% 命令框输入运行blackhole(0, 0, 30, 100, 100)