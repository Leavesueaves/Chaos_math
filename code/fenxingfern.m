function fern = fenxingfern(n)
% BARNLEY_FERN 绘制巴恩斯利蕨类barnsley_fern)
% BARNLEY_FERN(n), 将创建一个以蕨类形状为主题的MATLAB图像
% 自适应于形状阈值 n，默认为10000。 

% 设置默认值
if nargin < 1
    n = 10000;
end

% 设置巴恩斯利蕨类的参数
a = [ 0.00   0.00  0.00  0.16  0.00  0.00;
      0.85   0.04 -0.04  0.85  0.00  1.60;
      0.20  -0.26  0.23  0.22  0.00  1.60;
     -0.15   0.28  0.26  0.24  0.00  0.44 ];

% 开始绘制
fern(1,:)=[0 0];
for i = 2:n
    % 生成随机数，用于确定绘制使用的参数行
    r=rand;
    p=find(r<=cumsum(a(:,1)),1,'first');
    
    % 根据选择的参数行更新坐标位置
    fern(i,1)=a(p,1)*fern(i-1,1)+a(p,2)*fern(i-1,2)+a(p,5);
    fern(i,2)=a(p,3)*fern(i-1,1)+a(p,4)*fern(i-1,2)+a(p,6);
end

% 绘制图像
plot(fern(:,1),fern(:,2),'.','MarkerSize',1);
set(gca,'Color',[0.2 0.2 0.2],'XTick',[],'YTick',[]);
axis([-3 3 0 10]);
xlabel(' ');
ylabel(' ');
title('巴恩斯利蕨类');

fenxingfern(10000);
print('fenxingfern.png', '-dpng', '-r300')