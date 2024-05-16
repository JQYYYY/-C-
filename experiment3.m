clc;
% 二维正态分布，k1=(-1,0)',k2=(1,0)',先验概率P_w1=P_w2，设计最小分类器，输入特征向量，自动获得分类结果
load MALE.txt;
load FEMALE.txt;
k1 = mean(MALE);
k2 = mean(FEMALE);
figure(1);
plot(MALE(:, 1), MALE(:, 2), 'o', FEMALE(:, 1), FEMALE(:, 2), 'x');
title('Bayes Train Dataset'); 
xlabel('身高/cm');
ylabel('体重/kg');

P_w1 = [0.2 0.5 0.7];     % 第一类先验概率
P_w2= [0.8 0.5 0.3];      % 第二类先验概率
R1 = cov(MALE(:, 1), MALE(:, 2));
R2 = cov(FEMALE(:, 1), FEMALE(:, 2));
% 画出真实标签图
load test1.txt;
test = test1;
label1 = find(test(:, 3) == 1);
label2 = find(test(:, 3) == 2);
figure(2);
subplot(2, 2, 1);
plot(test(label1, 1), test(label1, 2), 'o', test(label2, 1), test(label2, 2), 'x');
title('Testdata True Label');
xlabel('身高/cm');
ylabel('体重/kg');
% 进行预测
L = length(test);
for k = 1:3
    for i = 1:L
        X = test(i, 1:2);   % 一个测试样本
        H = 0.5 * (X - k1) * inv(R1) * (X - k1)' - 0.5 * (X - k2) * inv(R2) * (X - k2)'...
            + 0.5 * log(det(R1) / det(R2)) - log(P_w1(k) / P_w2(k));      % 类别1的判别函数值
        if H > 0
            result(i) = 2;
        else
            result(i) = 1;
        end
    end
    % 画出预测标签图
    predict1 = find(result == 1);
    predict2 = find(result == 2);
    subplot(2, 2, k + 1);
    plot(test(predict1, 1), test(predict1, 2), 'o', test(predict2, 1), test(predict2, 2), 'x');
    title(['Bayes Predict Label', ' P_w1=', num2str(P_w1(k))]);
    xlabel('身高/cm');
    ylabel('体重/kg');
    % 计算预测错误率
    error = L - length(find(test(:, 3) == result'));
    error_rate = error / L;
    fprintf('P_w1: %.2f, 预测错误率为：%.2f%%\n', P_w1(k), error_rate * 100);
end
