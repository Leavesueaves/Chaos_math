% Lorenz，y 初始值情况下的初始条件敏感性
% 绘制一个散点图，显示 y 初始值的频谱从低到高的变化，每个频谱曲线的颜色根据相应的 y 初始值进行着色
% 在另一个子图中显示了 Lorenz 吸引子的演变趋势。

% 定义洛伦兹方程
sigma = 16;
beta = 4;
rho = 45.92;
f = @(t,y) [sigma*(y(2)-y(1)); y(1)*(rho-y(3))-y(2); y(1)*y(2)-beta*y(3)];

% 定义 y 初始条件
y0 = 1.001;

% 计算洛伦兹方程的解
[t, y] = ode45(f, [0, 50], [1, 0, y0]);

% 用 FFT 算法计算洛伦兹方程 y 变量的频谱
N = length(y);
Y = fft(y(:,2));
Pyy = Y.*conj(Y)/N;
f = 1/(t(2)-t(1))*(0:(N/2))/N;

% 绘制频谱图（注意此处使用的是 semilogy 方法）
semilogy(f,Pyy(1:N/2+1))
grid on
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% 显示结果