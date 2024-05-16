clear;
clc;
load FEMALE.txt;
load MALE.txt;
MALE = horzcat(MALE, ones(size(MALE, 1), 1));
FEMALE = horzcat(FEMALE, 2 * ones(size(FEMALE, 1), 1));
data = [MALE(:, 1) MALE(:, 2) MALE(:, 3);
        FEMALE(:, 1) FEMALE(:, 2) FEMALE(:, 3)];

[center,U,obj_fcn] = fcm(data(:, 1:2), 2);  % 聚类中心data_center、隶属度矩阵U和目标函数值obj_fcn
figure(1);
plot(data(:,1), data(:,2), 'o');
maxU = max(U);
index1 = find(U(1,:) == maxU);   % 判断属于类别1的样本下标
index2 = find(U(2,:) == maxU);
figure(2);
subplot(1, 2, 1);
line(data(index1,1),data(index1,2),'linestyle','none','marker','x');
line(data(index2,1),data(index2,2),'linestyle','none','marker','*', 'color', 'm');
title('模糊C均值聚类分析图');
xlabel('身高'); ylabel('体重');
index3 = find(data(:, 3) == 1);
index4 = find(data(:, 3) == 2);
subplot(1, 2, 2);
line(data(index3,1),data(index3,2),'linestyle','none','marker','x');
line(data(index4,1),data(index4,2),'linestyle','none','marker','*', 'color', 'm');
title('实际样本类别');
xlabel('身高'); ylabel('体重');