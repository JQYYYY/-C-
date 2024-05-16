clear;
clc;
load FEMALE.txt;
load MALE.txt;
MALE = horzcat(MALE, ones(size(MALE, 1), 1));
FEMALE = horzcat(FEMALE, 2 * ones(size(FEMALE, 1), 1));
data = [MALE(:, 1) MALE(:, 2) MALE(:, 3);
        FEMALE(:, 1) FEMALE(:, 2) FEMALE(:, 3)];

% [center,U,obj_fcn] = fcm(data(:, 1:2), 5);  % 聚类中心data_center、隶属度矩阵U和目标函数值obj_fcn
% maxU = max(U);
% index1 = find(U(1,:) == maxU);   % 判断属于类别1的样本下标
% index2 = find(U(2,:) == maxU);
% index3 = find(U(3,:) == maxU);
% index4 = find(U(4,:) == maxU);
% index5 = find(U(5,:) == maxU);
% figure(1);
% line(data(index1,1),data(index1,2),'linestyle','none','marker','*');
% line(data(index2,1),data(index2,2),'linestyle','none','marker','*', 'color', 'm');
% line(data(index3,1),data(index3,2),'linestyle','none','marker','*', 'color', 'g');
% line(data(index4,1),data(index4,2),'linestyle','none','marker','*', 'color', 'r');
% line(data(index5,1),data(index5,2),'linestyle','none','marker','*', 'color', 'y');
% title('模糊C均值聚类分析图 cluster=5');
% xlabel('身高'); ylabel('体重');

% 设置要尝试的类别数范围
num_clusters = 2:6;
silhouette_values = zeros(size(num_clusters));  % 初始化轮廓系数向量
% 对每个类别数执行聚类并计算轮廓系数
for i = 1:length(num_clusters)
    num_cluster = num_clusters(i);
    [~, U, ~] = fcm(data(:, 1:2), num_cluster);
    [max_values, max_indices] = max(U);
    result = evalclusters(data(:, 1:2), max_indices', 'silhouette');
    silhouette_values(i) = result.CriterionValues;
end
% 绘制曲线图
figure(2);
plot(num_clusters, silhouette_values, '*-');
xlabel('Number of Clusters');
ylabel('Silhouette Coefficient');
title('Silhouette Coefficient vs. Number of Clusters');